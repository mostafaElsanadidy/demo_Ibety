//
//  InteractorClass.swift
//  IBety
//
//  Created by Mohamed on 8/29/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin

let urlStr = "http://ibety.laraeast.com/api/"
var errorMessageText = ""
let getHeaders = [
    "X-Accept-Language":"ar",
    "Accept":"application/json"
]

class IbetyInterector : PresentorToInterectorProtocol{
    
    
    
    var presenter: InterectorToPresenterProtocol?
    
    var userRegisteration:UserRegisteration!
    var error : errorMessage!
    var type="customer"
    var indexOfSelectedCity = 0
    
  //  let urlStr = "http://ibety.laraeast.com/api/"
    var countryResult = countriesResult()
    
    
//    var accountPresenter:AccountCreate_InterectorToPresenterProtocol?
//    var loginViewPresenter:AccountCreate_ViewToPresenterProtocol?
//    var viewPresenter:ViewToPresenterProtocol?
    
    var categoriesUrlStr = urlStr+"categories"
    //    var displayedCategories:CategoryResult!
    var ownerLoginResult:OwnerLogin_Result!
    
    
    
    var language: String!
    var bundle: Bundle!
    let LANGUAGE_KEY: String = "LANGUAGE_KEY"
    
   // var dropDown = DropDown()

    func findUserDefaults(forKey key: String) -> Any {
        return UserDefaults.standard.object(forKey: key)!
    }
    
    func insertUserDefaults(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func loginWithFacebook(with token: AccessToken) {
     
        let facebookUrlStr = urlStr+"login/facebook"
        alamofireFunction2(httpMethod: .post, urlStr: facebookUrlStr, dicOfHeader: getHeaders, dicOfBody: ["access_token":token.tokenString], userDefaultKey: "accessFacebooktoken")
    }
    
    func isBeforeLogin(){
         var index = 0
        var indexOfPage = 0
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            print(ownerLoginResult.data!.type!)
            print(ownerLoginResult.data!.verified!)
            print(ownerLoginResult.data!.phone_number!)
            
            if ownerLoginResult.data!.type! == "owner" && ownerLoginResult.data!.verified!{
                indexOfPage = 2
            }
            else if ownerLoginResult.data!.type! == "customer" || !ownerLoginResult.data!.verified!{
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
    
   
}

