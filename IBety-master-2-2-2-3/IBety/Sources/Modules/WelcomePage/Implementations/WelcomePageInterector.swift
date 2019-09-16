//
//  WelcomePageInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class WelcomeInterector: WelcomePresentorToInterectorProtocol {
    
    var ownerLoginResult:OwnerLogin_Result!
    var presenter: WelcomeInterectorToPresenterProtocol?
    
    func updateOwnerUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "UserLoginResult")
        UserDefaults.standard.removeObject(forKey: "UserProfile")
        
        print(UserDefaults.standard.data(forKey: "UserLoginResult"))
        print("mosdviosljm")
        UserDefaults.standard.set("FirstViewController", forKey: "PAGENAME")
    }
 
    
    func isBeforeLogin() {
            
            var indexOfPage = 0
        
            if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
                ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
                print(ownerLoginResult.data!.verified!)
                print(ownerLoginResult.data!.type!)
                if ownerLoginResult.data!.type! == "owner" && ownerLoginResult.data!.verified!{
                    indexOfPage = 2
                }
                else if ownerLoginResult.data!.type! == "customer" ||  !ownerLoginResult.data!.verified!{
                    indexOfPage = 1
                }}else{
                    indexOfPage = 0
            }
        
           presenter?.updateTabBarViewController(using: 3, indexOfPage: indexOfPage)
            // viewController.isProInfo = true
        
        }
    }

