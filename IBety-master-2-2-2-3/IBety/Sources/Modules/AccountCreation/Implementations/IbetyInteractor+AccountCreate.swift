//
//  IbetyInteractor+AccountCreate.swift
//  IBety
//
//  Created by 68lion on 8/30/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class AccountInterector : AccountCreate_PresentorToInterectorProtocol{
    
    
    var presenter: AccountCreate_InterectorToPresenterProtocol?
    var ownerLoginResult = OwnerLogin_Result(){
        
        didSet{
           
                presenter?.finishAccountCreate(type: self.ownerLoginResult.data!.type!)
        }
    }
    var default_Cities = defaultCities(){
        
        didSet{
                presenter?.updateDropDownData(with: default_Cities.data!.cities!)
        }
        
    }
    var citiesData2:Data!

    
    func insertUserDefaults(value:Any , key:String){
        
        UserDefaults.standard.set(value, forKey: key)
    }
    func createAccountService(n: String, e: String, m: String, c: Int, p: String, t: String){
        
        
            
            let registerUrlString = urlStr+"register"
            let url = URL.init(string: registerUrlString)
            errorMessageText = ""
            
           // print("\(userRegisteration.email!)")
            let newTodo : [String:Any] = ["name": n, "email": e, "phone_number": m, "password": p, "password_confirmation": p, "type": t, "city_id": c]
        
            
        Alamofire.request(url!, method: .post ,parameters: newTodo, encoding: URLEncoding.default, headers: getHeaders).responseJSON { (response:DataResponse) in
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
                        //                    if let dicOfErrors = dic!["errors"] as? [String:Any]{
                        //
                        //                        if let dic = dicOfErrors["product.description"] as? [String]{
                        //                            print("   \(dic[0]) ******************")
                        //                        }
                        //                    }
                        
                      
                            self.presenter?.showError(errorMessageText: errorMessageText)
                        print(url!)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print(response.error?.localizedDescription)
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        UserDefaults.standard.set( response.data!, forKey: "UserLoginResult")
                        
                        self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: response.data!)
                        UserDefaults.standard.set(self.ownerLoginResult.token!, forKey: "loginToken")
                        //  print("\(response.value!) bnkjbjkhjbjbh")
                        //   print("\(countryResult.data![0].name) ")
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
        
    }

    func default_CitiesService() {

        let urlCitiesStr = urlStr + "countries/default/cities"
        
        let url = URL.init(string: urlCitiesStr)
        if citiesData2 == nil{
            // let urlCategoryStr = urlStr+"categories"
            
            Alamofire.request(url!, method: .get ,parameters: nil, encoding: URLEncoding.default, headers: getHeaders).responseJSON { (response:DataResponse) in
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
                
                            self.presenter?.showError(errorMessageText: errorMessageText)
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        //           data = countryResult
                        
                        UserDefaults.standard.set( response.data!, forKey: "DefaultCities_ListData")
                        self.default_Cities = try! JSONDecoder().decode(defaultCities.self, from: response.data!)
                        //  print("\(response.value!) bnkjbjkhjbjbh")
                        //   print("\(countryResult.data![0].name) ")
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
        }else{
            
            self.default_Cities = try! JSONDecoder().decode(defaultCities.self, from: citiesData2)
        }
        
        
    }
    
}
