//
//  MyProductsInterector.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class nameMyProductsInterector: MyProductsPresentorToInterectorProtocol {
    
    var presenter: MyProductsInterectorToPresenterProtocol?
    var ownerLoginResult:OwnerLogin_Result!

    
    var displayedProjectDetails=projectCreationDetails(){
        didSet{
            presenter?.changeTitleView(with: self.displayedProjectDetails.data!)
        }
    }
    
    var displayedProductsDetails=DisplayedProducts(){
        didSet{
            presenter?.changeCollectionView(with: self.displayedProductsDetails.data)
        }
    }
    
    func deleteProduct(with selectIndex: Int) {
        
        let urlStr = "http://ibety.laraeast.com/api/projects"
        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        
        print(projectID)
//        if displayedProjectDetails.data!.id! == projectID{
            if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
                ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
                let headers = [
                    "Authorization": "Bearer \(ownerLoginResult.token!)",
                    "X-Accept-Language":"ar",
                    "Accept":"application/json"
                    
                    // "Content-Type":"application/json"
                ]
                
                let productsData = self.displayedProductsDetails
                
                let urlUpdateProductStr = urlStr + "/\(projectID)/products/\(productsData.data![selectIndex].id!)"
                
                let url = URL.init(string: urlUpdateProductStr)
                
                errorMessageText = ""
                Alamofire.request(url!, method: .delete ,parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
                    switch(response.result) {
                    case .success:
                        
                        
                        // print("\(newTodo)")
                        let temp = response.response?.statusCode ?? 400
                        if temp >= 300 {
                            
                            let dic = try! JSONSerialization.jsonObject(
                                with: response.data!, options: []) as? [String: Any]
                            if let dicOfErrors = dic!["errors"] as? [String:[String]]{
                                for key in dicOfErrors.keys{
                                    
                                    if let value = dicOfErrors[key]{
                                        errorMessageText += "\(key) : \(value[0].debugDescription) \n"
                                        
                                        print(value)
                                    }
                                }}
                            self.presenter?.showNetworkError(with: errorMessageText)
                            print("******************************** \(response.value!) **********************")
                            //  print("\()")
                            print("errorrrrelse")
                            // print("")
                            
                        }else{
                            
                            print("\(url!)")
                            //           data = countryResult
                            print(response.value!)
                            UserDefaults.standard.set( response.data!, forKey: "deletedProduct")
                            
                            self.displayedProductsDetails = try! JSONDecoder().decode(DisplayedProducts.self, from: response.data!)
                            
                            self.presenter?.showDeletionAlert()
                        }
                    case .failure(_):
                        print("error")
                        
                        break
                    }
                }
                
                
                //                delegate?.dicOfProductUpdate(viewController: self, dicOfProducts: dicOfProductDetails)
                //                dismiss(animated: true, completion: nil)
            }
    }
    
    func changeCellImage(with imageUrlStr: String) {
        Alamofire.request(imageUrlStr).responseData { (response) in
            if response.error == nil {
                print(response.result)
                print("success")
                // Show the downloaded image:
                if let data = response.data {
                    self.presenter?.displayCellImage(with: data)
                }
            }
        }
    }
    
    func findUserDefaultsValue(for key: String) {
    
        let projectID = UserDefaults.standard.integer(forKey: key)
        presenter?.receiveUserDefaultsValue(value: projectID)
    }
    
    func displayMyProductsService() {
        
        if let data = UserDefaults.standard.data(forKey: "displayCreatedProject"){
            
            self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data)
            
        }
        
        findUserDefaultsValue(for: "ProjectID")
        displayProducts()
        
    }
    
    func displayProducts(){
        
        if let data2 = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data2)
            
            let headers = [
                "Authorization": "Bearer \(self.ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json"
            ]
            
            print("\(tabBarViewController.selectedIndex) sdfgasgsfdgdaf")
            
            let data = UserDefaults.standard.data(forKey: "displayCreatedProject")
            errorMessageText = ""
            //    self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
            let urlStr = "http://ibety.laraeast.com/api/projects/"
            let displayedProjectUrlStr = urlStr+"\(self.displayedProjectDetails.data!.id!)"
            let urlProProductsStr = displayedProjectUrlStr + "/products"
            
            let url = URL(string: urlProProductsStr)
            
            Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
                switch(response.result) {
                case .success:
                    
                    
                    // print("\(newTodo)")
                    let temp = response.response?.statusCode ?? 400
                    if temp >= 300 {
                        
                        let dic = try! JSONSerialization.jsonObject(
                            with: response.data!, options: []) as? [String: Any]
                        if let dicOfErrors = dic!["errors"] as? [String:[String]]{
                            for key in dicOfErrors.keys{
                                
                                if let value = dicOfErrors[key]{
                                    errorMessageText += "\(key) : \(value[0].debugDescription) \n"
                                    
                                    print(value)
                                }
                            }}
                        self.presenter?.showNetworkError(with: errorMessageText)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print(response.error?.localizedDescription)
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        //           data = countryResult
                        
                        UserDefaults.standard.set( response.data!, forKey: "displayProjectProducts")
                        
                        //                            let productsData = self.displayedProductsDetails.data!
                        
                        print(" ******************** \(response.value!) ******************** ")
                        //let productsCount = self.displayedProductsDetails.data?.count ?? 0
                        
                        self.displayedProductsDetails = try! JSONDecoder().decode(DisplayedProducts.self, from: response.data!)
                        
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                    
                }
                
            }}
    }
    
}
