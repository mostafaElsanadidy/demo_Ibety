//
//  SendMessageInterector.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire

class SendMessageInterector:SendMessagePresentorToInterectorProtocol{
    
    var ownerLoginResult:OwnerLogin_Result!
    
    func findLoginResult() {
        
        var indexOfPage = 0
        var index = 1
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            index = 3
            self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            if self.ownerLoginResult.data!.type! == "owner" && self.ownerLoginResult.data!.verified!{
                indexOfPage = 2
            }
            else if self.ownerLoginResult.data!.type! == "customer" || !self.ownerLoginResult.data!.verified!{
                indexOfPage = 1
            }}
        else{
            
            index = 1
            indexOfPage = 0
            }
        
        presenter?.insertMyDetailsViewController(controllerName: "MyDetailsViewController", index: index, indexOfPage: indexOfPage)
        
        
    }
    
    func sendFeebackMessage(with name: String, email: String, message: String) {
        
        let dicOfHeader = [
            "Accept":"application/json"]
        let url = URL.init(string: "http://ibety.laraeast.com/api/feedback")
        //
        let dicOfbody = ["name":name,
                         "email":email,
                         "message":message]
        //alamofireFunction2(httpMethod: .get, urlStr: urlStr, dicOfHeader: dicOfHeader, dicOfBody: nil, userDefaultKey: "displaySearchedProject")
        
        errorMessageText = ""
        Alamofire.request(url!, method: .post ,parameters: dicOfbody, encoding: URLEncoding.default, headers: dicOfHeader).responseJSON { (response:DataResponse) in
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
                    
                    print("\(url!)")
                    //           data = countryResult
                    print(response.value!)
                    UserDefaults.standard.set( response.data!, forKey: "feebackMessage")
                    self.presenter?.showAlertForSendingFeedback()
                    
                }
            case .failure(_):
                print("error")
                
                break
            }
        }
    }
    
    
    var presenter: SendMessageInterectorToPresenterProtocol?
    
    
}

//
//let dicOfHeader = [
//    "Accept":"application/json"]
//let url = URL.init(string: "http://ibety.laraeast.com/api/feedback")
////
//let dicOfbody = ["name":nameTextView.text!,
//                 "email":emailTextView.text!,
//                 "message":messageTextView.text!]
////alamofireFunction2(httpMethod: .get, urlStr: urlStr, dicOfHeader: dicOfHeader, dicOfBody: nil, userDefaultKey: "displaySearchedProject")
//
//errorMessageText = ""
//Alamofire.request(url!, method: .post ,parameters: dicOfbody, encoding: URLEncoding.default, headers: dicOfHeader).responseJSON { (response:DataResponse) in
//    switch(response.result) {
//    case .success:
//
//
//        // print("\(newTodo)")
//        let temp = response.response?.statusCode ?? 400
//        if temp >= 300 {
//
//            let dic = try! JSONSerialization.jsonObject(
//                with: response.data!, options: []) as? [String: Any]
//            if let dicOfErrors = dic!["errors"] as? [String:[String]]{
//                for key in dicOfErrors.keys{
//
//                    if let value = dicOfErrors[key]{
//                        self.errorMessageText += "\(key) : \(value[0].debugDescription) \n"
//
//                        print(value)
//                    }
//                }}
//            self.showNetworkError()
//            print("******************************** \(response.value!) **********************")
//            //  print("\()")
//            print("errorrrrelse")
//            // print("")
//
//        }else{
//
//            print("\(url!)")
//            //           data = countryResult
//            print(response.value!)
//            UserDefaults.standard.set( response.data!, forKey: "feebackMessage")
//
//            let alert = UIAlertController(
//                title: "Thank you...",
//                message:
//                "your opinion will arrive to admin.",
//                preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .default, handler: {
//
//                _ in
//                let viewController = self.storyboard!.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
//                if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
//
//                    tabBarViewController.viewControllers![3] = viewController
//                    tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
//                    tabBarViewController.selectedIndex = 3
//                    self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
//                    if self.ownerLoginResult.data!.type! == "owner" && self.ownerLoginResult.data!.verified!{
//                        viewController.indexOfPage = 2
//                    }
//                    else if self.ownerLoginResult.data!.type! == "customer" || !self.ownerLoginResult.data!.verified!{
//                        viewController.indexOfPage = 1
//                    }}
//                else{
//
//                    viewController.indexOfPage = 0
//                    tabBarViewController.viewControllers![1] = viewController
//                    tabBarViewController.viewControllers![1].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
//                    tabBarViewController.selectedIndex = 1}
//
//
//            })
//            alert.addAction(action)
//            self.present(alert, animated: true, completion: nil)
//
//        }
//    case .failure(_):
//        print("error")
//
//        break
//    }
//}
