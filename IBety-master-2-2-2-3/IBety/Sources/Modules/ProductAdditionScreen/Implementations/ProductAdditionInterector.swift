//
//  ProductAdditionInterector.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class ProductAdditionInterector: ProductAdditionPresentorToInterectorProtocol {
   
    
    func addNewProductService() {
        
        print("\(dicOfProductDetails!)")
        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        
        if projectID != nil{
            
            
            if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
                ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
                //            let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlkYzgyZjIxZjRiMTE3ODBhNzFiMmVhNDUyZTY4ZDQ0NjljZTNjNTk1ZWExOGJhMDUxODUxZjEzNTM2ZDMxZjBkMWFjZjk4MDBkZmQ0NjAxIn0.eyJhdWQiOiIxIiwianRpIjoiOWRjODJmMjFmNGIxMTc4MGE3MWIyZWE0NTJlNjhkNDQ2OWNlM2M1OTVlYTE4YmEwNTE4NTFmMTM1MzZkMzFmMGQxYWNmOTgwMGRmZDQ2MDEiLCJpYXQiOjE1NjQzODU1MzksIm5iZiI6MTU2NDM4NTUzOSwiZXhwIjoxNTk2MDA3OTM5LCJzdWIiOiIxOTQiLCJzY29wZXMiOltdfQ.HWV-2gvECYV3Yfr3vaDojtlUjWfTleoKG-QIUUg7Ms5s6dyXH7OOIqMzUKtuOrETvyR_KGmFUaS4V77kRhxXxUskhweqfmwXfZMPEiBcDBzbAxbF4_coVwshXvcV8-P4nb9RpSm_p_nR_r9zJtiSDvdxU5y5hxmGmL410AkV39SEJajEFf-hQMRlXcD683HJ8lPntssWkfK7JhHF118RvGLx6Pj_TP4qMag1pPQ1Q1xQ_WlXRO6SwZIrAu0nT7vniss32aClL6EP8kX5wQXMo8I9ZTEZk90bc6d8k-3jnvaP-fZthKgq99cSQxYXhqSsgUICBTFeZQbb64dvSy_Q7NiXbYbA9uxLmO4cBRvPhIIEBA1EEuVNWdFQKTKSAQ7MIEUey5WjMFv7bcopBrZaEhJbh7svPdDhayDlVJo9Udedv26QBM7_TyvejxKGuWvIZuWozslZpJ1KOhdjv4f461pWDZrmGjyC2Qpd7Nwhy6Q-2JWJHxSpa1AAsWwNAdLgvQIlG2r8hy2aoxadgD2SUtAT5lfU7Dm4d4l70tNT09HdC4YLCKe2HbMh9-Gf15Iz63IPaR2xlOVh5suKNVGHktO6QwHWt4dvcgef46DDhnmUDtTPjV0aVZOAg1M296nlODM28kifB8mf8BgDf1IHzoQZUDoohnet3R1ZsAHtgzE"
                let headers = [
                    "Authorization": "Bearer \(ownerLoginResult.token!)",
                    "X-Accept-Language":"ar",
                    "Accept":"application/json"
                    // "Content-Type":"application/json"
                ]
                
                let urlAddProductStr = urlStr + "/\(projectID)/products"
                let url = URL(string: urlAddProductStr)
                
                print("\(dicOfProductDetails!)")
                errorMessageText = ""
                
                
                Alamofire.request(url!, method: .post, parameters: dicOfProductDetails, encoding: URLEncoding.default, headers: headers)
                    .responseJSON { (response:DataResponse) in
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
                                
                                UserDefaults.standard.set( response.data!, forKey: "NewProduct")
                                self.presenter?.dismissViewController()
                            }
                        case .failure(_):
                            print("error")
                            
                            break
                        }
                }
                
            }
        }
    }
    
    
    func updateProductService(selectedIndex: Int) {
        
//        let data = UserDefaults.standard.data(forKey: "displayCreatedProject")
//        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
        
        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        
//        if displayedProjectDetails.data!.id! == projectID{
        
            if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
                ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
                let headers = [
                    "Authorization": "Bearer \(ownerLoginResult.token!)",
                    "X-Accept-Language":"ar",
                    "Accept":"application/json",
                    "Content-Type":"application/x-www-form-urlencoded"
                    // "Content-Type":"application/json"
                ]
                
                let urlUpdateProductStr = urlStr + "/\(projectID)/products/\(selectedIndex)"
                let url = URL.init(string: urlUpdateProductStr)
                
                errorMessageText = ""
                
                Alamofire.request(url!, method: .patch, parameters: dicOfProductDetails, encoding: URLEncoding.default, headers: headers)
                    .responseJSON { (response:DataResponse) in
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
                                
                                UserDefaults.standard.set( response.data!, forKey: "displayedProduct")
                                self.presenter?.showUpdateAlert()
                                
                            }
                        case .failure(_):
                            print("error")
                            
                            break
                        }
                }
            }
    }
        
//        else{
//
//            presenter?.showNetworkError()
//        }
        
        //        if isUpdateState{
        //
        //            upadateProduct()
        //        }
        //
    
    
    
    var presenter: ProductAdditionInterectorToPresenterProtocol?
    
    let urlStr = "http://ibety.laraeast.com/api/projects"
    var changedProductDetail:product_Details!
    var displayedProductDetails=displayedProduct(){
        didSet{
            
            let productData = self.displayedProductDetails.data!
            dicOfProductDetails.updateValue( productData.name! , forKey: "name")
            dicOfProductDetails.updateValue( productData.description! , forKey: "description")
            dicOfProductDetails.updateValue( productData.price_formated! , forKey: "price")
            
            presenter?.updateViews(with: productData)
            
            let photoUrlStr = productData.media!.images![0].conversions!.thumb!
            
            Alamofire.request(photoUrlStr).responseData { (response) in
                if response.error == nil {
                    //  print(response.result)
                    print("success")
                    // Show the downloaded image:
                    if let data = response.data {
                        self.presenter?.displayProductImage(with: data)
                    }
                }
            }
            
            
            
            
            for indexOfImage in 0 ..< productData.media!.images!.count{
                
                Alamofire.request(photoUrlStr).responseData { (response) in
                    if response.error == nil {
                        //  print(response.result)
                        print("success")
                        // Show the downloaded image:
                        if let data = response.data {
                            dicOfProductDetails.updateValue((UIImage(data: data)!.pngData()?.base64EncodedString())!, forKey: "images[\(indexOfImage)]")
                        }
                    }
                }
            }
            
            
            
        }
    }
    var displayedProjectDetails:projectCreationDetails!
    var ownerLoginResult:OwnerLogin_Result!
    
    func displayProductService(with index: Int) {
        
        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        let urlStr = "http://ibety.laraeast.com/"
        
        let data2 = UserDefaults.standard.data(forKey: "UserLoginResult")
        ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data2!)
        
        //
        //        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjBkOGUxOTQ3OWQ2ZGIwNTM1Yzg5NDI5MDcxZTJkMDdiYTU2NDUwNTg2MTRkZmM3ODUxZTQxYTM4NTQxM2IxMjAyNGM1YWYxODVlMTVlNDhiIn0.eyJhdWQiOiIxIiwianRpIjoiMGQ4ZTE5NDc5ZDZkYjA1MzVjODk0MjkwNzFlMmQwN2JhNTY0NTA1ODYxNGRmYzc4NTFlNDFhMzg1NDEzYjEyMDI0YzVhZjE4NWUxNWU0OGIiLCJpYXQiOjE1NjQ0MTc2NDUsIm5iZiI6MTU2NDQxNzY0NSwiZXhwIjoxNTk2MDQwMDQ1LCJzdWIiOiIxOTQiLCJzY29wZXMiOltdfQ.CiqkB590EotA6NKPgKS-xnYD_WxN4xb8hwQlQH4LImOj4_pPONaaOmZRXTqM_V_tcRgJMW2RvvGxR4fG1vj3TnNyl3Mj2oG7D2lwV9RrGZCbdnAD5socbJhVsQn5hTp-wXCJ3kJaM2Y_8iVPNWoPo8FOuLl5RZi3K5LLRJ8vRZsYYT4FM1p0xaFQWyXvdgGzJCK9BlWImtyaUZvQdZjZrnO-pdSHj0GtsMGKtxbS5bcpk_2cMWye2fNByYb_sJkkCyzpxndUEhfPNNaqKppMdjFA0imt8vNAG-76WHr3nKFwtwg6efCk0UK0vz2uY1jLbFImIeWrIiEgLXiryBGDtIEKJW9_35jLNMTrqPlR-txopRyqQCzAgiNlwlnxHkNxJdiREioAJOQkHj036RQWafoGsAKNPmUNMz4N1jyjK6ILKCypurhblMJgmRsi3TRpPcKEzww3A69De-utKPymtf5vo9-0TaGKafrdTFoqRrfNo9dWSC_oQAGwsou_AUsoE0pzHhNRzSiYTAQI0Q8UzP8octAkTNCYJQlwBABbzVibBchwoaQGomoNzPfF2NTDhcr7Y0NBZP37sUh1JSUGeultyitL6yQ6q4_aUo-S5Rqee-n9xOTQo4zRmoyRBLErSK1hhTqqrq79eqYYaYa5ZPVZyVyaCDk9rzl6yu6hTso"
        
        let headers = [
            "Authorization": "Bearer \(ownerLoginResult.token!)",
            "X-Accept-Language":"ar",
            "Accept":"application/json" ,
        ]
        print("\(index)")
        
        
        let data = UserDefaults.standard.data(forKey: "displayCreatedProject")
        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
        let productUrlStr = urlStr + "api/projects/\(displayedProjectDetails.data!.id!)/products/\(index)"
        let url = URL.init(string: productUrlStr)
        
        errorMessageText = ""
        Alamofire.request(url!, method: .get ,parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
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
                    
                    //           data = countryResult
                    UserDefaults.standard.set( response.data!, forKey: "displayedProduct")
                    
                    if response.data != nil{
                        // print(data)
                        print(index)
                        self.displayedProductDetails = try! JSONDecoder().decode(displayedProduct.self, from: response.data!)        // Do any additional setup after loading the view.
                        
                        
                    }
                    print("\(response.value!)")
                    //   print("\(countryResult.data![0].name) ")
                    
                }
            case .failure(_):
                print("error")
                
                break
            }
        }
        print(productUrlStr)
        
    }
}
