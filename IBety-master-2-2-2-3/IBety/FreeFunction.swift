//
//  FreeFunction.swift
//  IBety
//
//  Created by Mohamed on 7/18/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import  Alamofire
import UIKit
import SSCustomTabbar

var userProject : project_Details!
var error_Message1 : errorMessage!
var dicOfProductDetails : [String:String]!
var dicOfUpdateProject : [String:Any]!
//var projectID:Int!
var tabBarViewController:UITabBarController!
//var navigationController1:CustomNavController!



func alamofireFunction( urlStr:String , dicOfHeader: [String:String], dicOfBody: [String:Any]?){
    
    //var data:countriesResult?
    let urlString = String(format:urlStr)
    
    let url = URL(string: urlString)
    let newTodo = dicOfBody
    
    Alamofire.request(url!, method: HTTPMethod.get, encoding: URLEncoding.default, headers: dicOfHeader).responseJSON { (response:DataResponse) in
        switch(response.result) {
        case .success:
            
            print("\(response.value!)")
            
            let temp = response.response?.statusCode ?? 400
            if temp >= 300 {
                
                print("errorrrrelse")
                
                
            }else{
                
     //           data = countryResult
                UserDefaults.standard.set( response.data!, forKey: "UserResult2")
               // print("\(countryResult.data![0].name) ")
                // self.dataOfUser = response.data!
            }
        case .failure(_):
            print("error")
            
            break
        }
    }
   // return data
}


func alamofireFunction2( httpMethod: HTTPMethod , urlStr:String , dicOfHeader: [String:String], dicOfBody: [String:Any]?, userDefaultKey: String){
    
    let urlString = String(format:urlStr)
    
    let url = URL(string: urlString)
    let newTodo = dicOfBody
    
    print("\(url) mostafa")
    
    Alamofire.request(url!, method: httpMethod ,parameters: newTodo, encoding: URLEncoding.default, headers: dicOfHeader).responseJSON { (response:DataResponse) in
        switch(response.result) {
        case .success:
            
            
           // print("\(newTodo)")
            let temp = response.response?.statusCode ?? 400
            if temp >= 300 {
                
               let dic = try! JSONSerialization.jsonObject(
                    with: response.data!, options: []) as? [String: Any]
                if let dicOfErrors = dic!["errors"] as? [String:Any]{
                    if let dic = dicOfErrors["product.description"] as? [String]{
                        print("   \(dic[0]) ******************")
                    }
                }
                
                print(url!)
                print("******************************** \(response.value!) **********************")
              //  print("\()")
                print(response.error?.localizedDescription)
                print("errorrrrelse")
             // print("")
                
            }else{
                
                //           data = countryResult
                
                    UserDefaults.standard.set( response.data!, forKey: userDefaultKey)
                print("\(response.value!) bnkjbjkhjbjbh")
                //   print("\(countryResult.data![0].name) ")
    
            }
        case .failure(_):
            print("error")
            
            break
        }
    }

}
