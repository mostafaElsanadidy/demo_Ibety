//
//  UserProductsInterector.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Alamofire
import Foundation

class UserProductsInterector: UserProductsPresentorToInterectorProtocol {
    
    var presenter: UserProductsInterectorToPresenterProtocol?
    var displayedProject_Details:projectCreationDetails!
    var displayedProductsDetails : DisplayedProducts!
    let proUrlStr = "http://ibety.laraeast.com/api/projects"
    let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
    
    let data2 = UserDefaults.standard.data(forKey: "displayProject")
    
    func displayCellImageService(for cell: ProductCollectionViewCell, with item: product_Data_) {
        
        Alamofire.request(item.media!.images![0].conversions!.thumb!).responseData { (response) in
            if response.error == nil {
                print(response.result)
                print("success")
                // Show the downloaded image:
                if let data = response.data {
                    self.presenter?.displayCellImage(for: cell, with: data)
                }
            }
        }
    }
    
    func displayedProjectDetails() {
        let data = UserDefaults.standard.data(forKey: "displayProject")
        self.displayedProject_Details = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
        presenter?.reloadCollectionView(displayProjectDetails: displayedProject_Details)
    }
    
    func displayUserProductsService() {
        if let data = UserDefaults.standard.data(forKey: "displayProject"){
            
            self.displayedProject_Details = try! JSONDecoder().decode(projectCreationDetails.self, from: data)
            
        }
        
        if let token = UserDefaults.standard.string(forKey: "loginToken"){
            
            let headers = [
                "Authorization": "Bearer \(token)",
                "X-Accept-Language":"ar",
                "Accept":"application/json"
            ]
            var dataStr = "displayProject"
            
            print("\(tabBarViewController.selectedIndex) sdfgasgsfdgdaf")
            
            let data = UserDefaults.standard.data(forKey: dataStr)
            errorMessageText = ""
            self.displayedProject_Details = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
            let urlStr = "http://ibety.laraeast.com/api/projects/"
            let displayedProjectUrlStr = urlStr+"\(self.displayedProject_Details.data!.id!)"
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
                        self.presenter?.showNetworkError(errorMessageText: errorMessageText)
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
                        self.presenter?.reloadCollectionViewByService(displayProductsDetails: self.displayedProductsDetails!.data!)
                    }
                case .failure(_):
                    print("error")
                    
                    break
                    
                }
                
            }}
        
    }
    
    
}
