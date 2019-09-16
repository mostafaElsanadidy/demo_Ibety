//
//  IbetyInterector+LoginPage.swift
//  IBety
//
//  Created by 68lion on 8/31/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class LoginInterector:LoginPagePresentorToInterectorProtocol{
    
    
    var presenter: LoginPageInterectorToPresenterProtocol?
    
    
    var loginOfOwner = OwnerLogin_Result(){
        didSet{
            
            presenter?.insertViewController(controllerName: "LoginViewController", index: 1)
            var indexOfPage = 0
            if self.loginOfOwner.data!.type! == "owner" && self.loginOfOwner.data!.verified!{
                indexOfPage = 2
            }
            else if self.loginOfOwner.data!.type! == "customer" || !self.loginOfOwner.data!.verified!{
                indexOfPage = 1
            }else{
                indexOfPage = 0
            }
            
             presenter?.insertThirdViewController(controllerName: "ThirdTabViewController1", index: 2, indexOfPage: 7)
            
            presenter?.insertMyDetailsViewController(controllerName: "MyDetailsViewController", index: 3, indexOfPage: indexOfPage)
            // viewController.isProInfo = true
           
            let count = self.loginOfOwner.data?.projects?.count
            
            if self.loginOfOwner.data!.type! == "owner" && ( count == nil || count! == 0){
                //   self.dismiss(animated: true, completion: nil)
                
                presenter?.performSegue(identifier: "CreateProjectSegue")
            }
            else{
                
                UserDefaults.standard.set( self.loginOfOwner.data!.projects!.data!.id!, forKey: "ProjectID")
                    presenter?.presentIndexInTabBarController(index: 3)
                UserDefaults.standard.set("MyDetailsViewController", forKey: "PAGENAME")
                
            }
        }
    }
    
    func loginService(userName: String, password: String) {
    
        let loginUrlString = urlStr+"login"
        // print("\(userRegisteration.email!)")
        
        let newTodo : [String:Any] = ["phone_number": userName, "password": password]
        let url = URL.init(string: loginUrlString)
        // let dicOfHeaders = ["Accept":"application/json", "X-Accept-Language":"ar"]
        
        errorMessageText = ""
        
        print(UserDefaults.standard.data(forKey: "UserLoginResult"))
        Alamofire.request(url!,
                          method: .post,
                          parameters: newTodo,
                          encoding: URLEncoding.default,
                          headers: getHeaders)
            
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
                        
                        if let presenter = self.presenter as? LoginPageInterectorToPresenterProtocol{
                            presenter.show_Error(errorMessageText: errorMessageText)}
                        print(url!)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print(response.error?.localizedDescription)
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        self.loginOfOwner = try! JSONDecoder().decode(OwnerLogin_Result.self, from: response.data!)
                        
                        
                        UserDefaults.standard.set(response.data!, forKey:"UserLoginResult")
                        
                        UserDefaults.standard.set(self.loginOfOwner.token!, forKey: "loginToken")
                        print("\(response.value)")
                        //  print("******************** \(self.loginOfOwner.data![0].projects?.data!.address! ?? "") ****************** ")
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
        }
        //moveToMyDetails()
        
        
        }
    
    
}
