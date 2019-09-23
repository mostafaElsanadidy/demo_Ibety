
//
//  Name_PasswordInterector.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Alamofire

class Name_PasswordInterector: Name_PasswordPresentorToInterectorProtocol {
    
    var presenter: Name_PasswordInterectorToPresenterProtocol?

    let urlStr = "http://ibety.laraeast.com/api/password/"
    
    let headers = [
        "Accept":"application/json"
    ]
    
    var checkCodeResult:CheckCodeServiceResult!
    
    var ownerLoginResult = OwnerLogin_Result(){
        
        didSet{
            
        }
    }
    
    func findUserDefaultValue(for key: String) {
    
        UserDefaults.standard.data(forKey: key)
    }
    
    func createNewPassword(newPassword: String, configPassword: String) {
        
        errorMessageText = ""
        let data = UserDefaults.standard.data(forKey: "CheckPassword")
        self.checkCodeResult = try! JSONDecoder().decode(CheckCodeServiceResult.self, from: data!)
        let check_codeUrlStr = urlStr+"reset"
        let url = URL(string: check_codeUrlStr)
        
        let dicOfBody = [
            "token":checkCodeResult.token!,
            "password":newPassword,
            "password_confirmation":configPassword]
        
        // alamofireFunction2(httpMethod: .post, urlStr: check_codeUrlStr, dicOfHeader: headers, dicOfBody: dicOfBody, userDefaultKey: "ResetPassword")
        
        Alamofire.request(url!, method: .post ,parameters: dicOfBody, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
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
                    
                    UserDefaults.standard.set( response.data!, forKey: "ResetPassword")
                    UserDefaults.standard.set( response.data!, forKey: "UserLoginResult")
                    
                    self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: response.data!)
                    
                    UserDefaults.standard.set( self.ownerLoginResult
                        .token!, forKey: "loginToken")
                    
                    self.presenter?.insertViewControllerInTabBar(controllerName: "LoginViewController", in: 1)
                    
                    self.presenter?.insertThirdViewControllerInTabBar(controllerName: "ThirdTabViewController1", in: 2, indexOfPage: 7)
                    
                    self.presenter?.insertViewControllerInTabBar(controllerName: "MyProjectPartsViewController", in: 3)
                   
                    //tabBarViewController.viewControllers.re
//                    tabBarViewController.selectedIndex = 3
                    
                     print("\(response.value!)")
                    let count = self.ownerLoginResult.data!.projects!.count
                    
                    if count == nil || count! == 0{
                        
                        self.presenter?.PerformSegue(with: "CreateProjectSegue")
                    }
                    else{
                        
                        self.presenter?.presentIndexInTabBarController(index: 3)
                        
                    }
                    //                        if let _ = UserDefaults.standard.data(forKey: "AddProjectData"){
                    //
                    //                        }else{
                    //                            }
                   
                    //  print("******************** \(self.loginOfOwner.data![0].projects?.data!.address! ?? "") ****************** ")
                    
                    //  print("\(response.value!) bnkjbjkhjbjbh")
                    //   print("\(countryResult.data![0].name) ")
                    
                }
            case .failure(_):
                print("error")
                
                break
            }
        }}
    
    func forgetPasswordService(with phoneNum: String) {
        
        let urlForgetStr = urlStr+"forget"
        let dicOfBody = ["username":phoneNum]
        alamofireFunction2(httpMethod: .post, urlStr: urlForgetStr, dicOfHeader: headers, dicOfBody: dicOfBody, userDefaultKey: "ForgetPassword")}
    
    func checkCode(codeText: String, phoneNum: String) {
        
        let check_codeUrlStr = urlStr+"check-code"
        let dicOfBody = ["username":phoneNum,
                         "code":codeText]
        alamofireFunction2(httpMethod: .post, urlStr: check_codeUrlStr, dicOfHeader: headers, dicOfBody: dicOfBody, userDefaultKey: "CheckPassword")

    }
}



