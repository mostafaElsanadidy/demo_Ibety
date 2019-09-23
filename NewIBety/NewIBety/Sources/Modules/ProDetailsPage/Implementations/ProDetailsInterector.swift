//
//  ProDetailsInterector.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//
import UIKit
import Foundation
import Alamofire

class ProDetailsInterector: ProDetailsPresentorToInterectorProtocol {
    
    var presenter: ProDetailsInterectorToPresenterProtocol?
    
    func alamofireDisplayedData(projectID:Int){
        
        if let token = UserDefaults.standard.string(forKey: "loginToken"){
            // self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            //
            
            let headers = [
                "Authorization": "Bearer \(token)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
            ]
            
            
            let displayedProjectUrlStr = urlStr+"projects/\(projectID)"
            print("\(displayedProjectUrlStr) $$$$$$$$$$$$$$$$$$")
            //        if displayedProjectUrlStr {
            //
            //        }
            print("\(displayedProjectUrlStr) *****************************")
            
            let url = URL.init(string: displayedProjectUrlStr)
            
            errorMessageText = ""
            Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
                switch(response.result) {
                case .success:
                    
                    print("\(response.value!)")
                    
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
                        print("errorrrrelse")
                        
                        
                    }else{
                        UserDefaults.standard.set(response.data! , forKey: "displayProject")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeProjectData"), object: nil)
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            //        alamofireFunction2(httpMethod: .get, urlStr: urlProProductsStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "displayProjectProducts")
            
        }
    }
    var displayedSearchProject = DisplayedSearchedProducts(){
        didSet{
            presenter?.updateView(with: self.displayedSearchProject.data!)
        }
    }
    
    func displayCellImageService(with item: DisplayedSearchedProductsData) {
        Alamofire.request(item.media!.image!.conversions!.thumb!).responseData { (response) in
            if response.error == nil {
                print(response.result)
                // Show the downloaded image:
                if let data = response.data {
                    self.presenter?.displayCellImage(with: data)
                }
            }
        }
    }
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleOfPage(_:)), name: NSNotification.Name(rawValue: "SendProjectData"), object: nil)
    }
    
    // handle notification
    @objc func changeTitleOfPage(_ notification: Notification) {
        
        print(" fsdkfmonodsf;;;ojm;oijsadio;f;jsdfosdfdsfdsfdsfsdfsdfsdf ")
        if let image = notification.userInfo?["image"] as? UIImage , let title = notification.userInfo?["title"] as? String{
            // do something with your image
            print("\(title) dbfbfdbdfbdf")
            presenter?.updateTitleView(with: image, name: title)
        }
    }
    
    
    func searchProject(with name: String) {
    
        let urlStr =  "http://ibety.laraeast.com/api/search/projects?name=\(name)"
        
        print("******************************** \(urlStr) ****************************")
        let url = URL.init(string: urlStr)
        
        if let token = UserDefaults.standard.string(forKey: "loginToken"){
            //self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            let dicOfHeader = ["Authorization": "Bearer \(token)",
                "X-Accept-Language":"ar",
                "Accept":"application/json"]
            
            
            errorMessageText = ""
            Alamofire.request(url!, method: .get ,parameters: nil, encoding: URLEncoding.default, headers: dicOfHeader).responseJSON { (response:DataResponse) in
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
                        self.presenter?.showNetworkError(with:errorMessageText)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        print("\(url!)")
                        //           data = countryResult
                        
                        
                        UserDefaults.standard.set( response.data!, forKey: "displaySearchProject")
                        if let data = response.data{
                            self.displayedSearchProject = try! JSONDecoder().decode(DisplayedSearchedProducts.self, from: data)
                            
                            //                    self.displayedSearchProject = try! JSONDecoder().decode(displayedProjectProduct.self, from: response.data!)
                            
                            // self.displayedSearchProject.
                            print("\(response.value!) %%%%%%%%%%%%%% ")
                         //   print("\(self.dropDown.dataSource) ^^^^^^^^^^^^^^^")
                            //   print("\(countryResult.data![0].name) ")
                            
                        }
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
        }
    }
}
