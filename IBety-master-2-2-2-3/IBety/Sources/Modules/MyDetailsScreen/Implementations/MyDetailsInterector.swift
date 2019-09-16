//
//  MyDetailsInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Alamofire
import FBSDKLoginKit

class MyDetailsInterector: MyDetailsPresentorToInterectorProtocol {
    
    var presenter: MyDetailsInterectorToPresenterProtocol?
    var ownerLoginResult:OwnerLogin_Result!
    var userProfileResult:User_Profile!
    var applicationSettings:ApplicationSettings!
    
    
    func displayApplicationSettings() {
        let urlSettingsStr = "http://ibety.laraeast.com/api/settings"
        alamofireFunction2(httpMethod: .get, urlStr: urlSettingsStr, dicOfHeader: ["Accept":"application/json"], dicOfBody: nil, userDefaultKey: "ApplicationSettings")
    }
    
    func updateOwnerUserDefaults() {
       
      let manager = FBSDKLoginKit.LoginManager()
        
        manager.logOut()
        UserDefaults.standard.removeObject(forKey: "UserLoginResult")
        UserDefaults.standard.removeObject(forKey: "UserProfile")
        
        print(UserDefaults.standard.data(forKey: "UserLoginResult"))
        print("mosdviosljm")
        updatePageName_UserDefault(with: "FirstViewController")
    }
    
    func updatePageName_UserDefault(with value:String){
        
        UserDefaults.standard.set(value, forKey: "PAGENAME")
    }
    
    func displayMyProject() {
        
        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        
        let urlStr = "http://ibety.laraeast.com/api/projects/\(projectID)"
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            print(ownerLoginResult.data!.projects!.count)
            
            let count = self.ownerLoginResult.data!.projects!.count
            
            if count == nil || count! == 0{
                
                presenter?.performSegue(withIdentifier: "CreateProjectSegue")
                
            }
            else{
                
                
             presenter?.moveToProjectPartsPage()
        }
    }
  }
    
    func displayProfilePersonly() {
        
        errorMessageText = ""
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            let token = ownerLoginResult.token!
            let headers = [
                "Authorization": "Bearer \(ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
            ]
            
            let urlProfileStr = "http://ibety.laraeast.com/api/profile"
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
                        self.presenter?.showNetworkError(witth: errorMessageText)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        UserDefaults.standard.set( response.data!, forKey: "UserProfile")
                        self.presenter?.instantiateViewController(withIdentifier: "LoginViewController")
                        print("\(response.value!)")
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            // alamofireFunction2(httpMethod: .get, urlStr: urlProfileStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "UserProfile")
        }
    }
    
    func isBeforeLogin() {
        
        var index = 0
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
           index = 3
        }else{
            
            index = 1
            }
        
       presenter?.updateTabBarViewController(with: index)
        
    }
}
