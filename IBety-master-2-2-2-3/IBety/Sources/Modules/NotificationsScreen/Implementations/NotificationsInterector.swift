//
//  NotificationsInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class NotificationsInterector: NotificationsPresentorToInterectorProtocol {
    
    var ownerLoginResult:OwnerLogin_Result!
    let urlStr = "http://ibety.laraeast.com/api/notifications"
    var notificationSettings=NotificationsSettings(){
        
        didSet{
            presenter?.updateViews(with: self.notificationSettings.data!)
        }
    }
    
    var presenter: NotificationsInterectorToPresenterProtocol?
    
    func displayNotificationsService() {
        
        let url = URL.init(string: urlStr)
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            let token = ownerLoginResult.token!
            
            let headers = ["Accept":"application/json",
                           "Authorization":"Bearer \(token)"
            ]
            
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
                        self.presenter?.showError(with: errorMessageText)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print(response.error?.localizedDescription)
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        //           data = countryResult
                        
                        UserDefaults.standard.set( response.data!, forKey: "DisplayedNotifications")
                        self.notificationSettings = try! JSONDecoder().decode(NotificationsSettings.self, from: response.data!)
                        
                        //  print("\(response.value!) bnkjbjkhjbjbh")
                        //   print("\(countryResult.data![0].name) ")
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            //alamofireFunction2(httpMethod: .get, urlStr: urlStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "DisplayedNotifications")
            
        }

    }
}

