//
//  ProfileInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class ProfileInterector:ProfilePresentorToInterectorProtocol{
    
    var presenter: ProfileInterectorToPresenterProtocol?
    let urlProfileStr = "http://ibety.laraeast.com/api/profile"
    var ownerLoginResult:OwnerLogin_Result!
    var userProfileResult=User_Profile(){
        
        didSet{
            presenter?.receiveProfileDetails(data: self.userProfileResult.data!)
        }
    }
    func isBeforeLogin() {
    
        
        var index = 0
        var indexOfPage = 0
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            print(self.ownerLoginResult.data!.type!)
            print(self.ownerLoginResult.data!.phone_number!)
            if self.ownerLoginResult.data!.type! == "owner" && ownerLoginResult.data!.verified!{
                indexOfPage = 2
            }
            else if self.ownerLoginResult.data!.type! == "customer" || !ownerLoginResult.data!.verified!{
                indexOfPage = 1
            }
            index = 3
        }
        else{
            
            indexOfPage = 0
            index = 1
            }
        presenter?.updateTabBarViewController(with: index, indexOfPage: indexOfPage)
        
    }
    
    func saveData(with profileUpdateObj: ProfileUpdateObj) {
        
        
        
        let dicOfBody:[String:Any] = ["name":profileUpdateObj.name,
                                      "password":profileUpdateObj.password,
                                 "password_confirmation":profileUpdateObj.password_confirmation,
                                      "avatar":profileUpdateObj.avatar]
        
        
        // print("\(dicOfBody)")
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            let token = ownerLoginResult.token!
            print("\(token)")
            let headers = [
                "Authorization": "Bearer \(ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
                "Content-Type":"application/x-www-form-urlencoded"
            ]
            
            
            let url = URL(string: urlProfileStr)
            alamofireFunction2(httpMethod: .patch, urlStr: urlProfileStr, dicOfHeader: headers, dicOfBody: dicOfBody, userDefaultKey: "UserProfile")
            
            Alamofire.request(url!, method: .patch ,parameters: dicOfBody, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
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
                        
                        print(url!)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print(response.error?.localizedDescription)
                        print("errorrrrelse")
                        // print("")
                        self.presenter?.showError(with: errorMessageText)
                        
                    }else{
                        
                        //           data = countryResult
                        
                        UserDefaults.standard.set( response.data!, forKey: "UserProfile")
                        
                        self.presenter?.showUpdateAlert()
                        
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
        }
        // dismiss(animated: true, completion: nil)
        
    }
    
    func displayUserImage(with urlStr: String) {
        Alamofire.request(urlStr).responseData { (response) in
            if response.error == nil {
                // print(response.result)
                // Show the downloaded image:
                if let data = response.data {
                    self.presenter?.receiveUserImage(data: data)
                }
            }
        }
    }
    
    func displayProfileService() {
        
        
        if let profileData = UserDefaults.standard.data(forKey: "UserProfile"){
            userProfileResult = try! JSONDecoder().decode(User_Profile.self, from: profileData)
        }
        else{
            
            if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
                ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
                let token = ownerLoginResult.token!
                let headers = [
                    "Authorization": "Bearer \(ownerLoginResult.token!)",
                    "X-Accept-Language":"ar",
                    "Accept":"application/json" ,
                ]
                
                errorMessageText = ""
                let url = URL.init(string: urlProfileStr)
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
                            
                            self.presenter?.showError(with: errorMessageText)
                            
                            print("******************************** \(response.value!) **********************")
                            //  print("\()")
                            print("errorrrrelse")
                            // print("")
                            
                        }else{
                            
                            UserDefaults.standard.set( response.data!, forKey: "UserProfile")
                            
                            self.userProfileResult = try! JSONDecoder().decode(User_Profile.self, from: response.data!)
                            print("\(response.value!)")
                            
                        }
                    case .failure(_):
                        print("error")
                        
                        break
                    }
                }
                
            }
            
        }
    }
}
