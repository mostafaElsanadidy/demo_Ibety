//
//  MyProjectPartsInterector.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class MyProjectPartsInterector: MyProjectPartsPresentorToInterectorProtocol{
    
    var presenter: MyProjectPartsInterectorToPresenterProtocol?
    let urlStr = "http://ibety.laraeast.com/api/projects/"
    
    var ownerLoginResult = OwnerLogin_Result()
    var displayedSearchProject:DisplayedSearchedProducts!
    var displayedProjectDetails : projectCreationDetails!{
        didSet{
            let projectData = self.displayedProjectDetails.data!
            presenter?.changeTitleView(with: projectData.name!)
        }
    }
    
    
    func updateView() {
        
        errorMessageText = ""
        if let data2 = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data2)
            
            let headers = [
                "Authorization": "Bearer \(self.ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json"
            ]
            
            presenter?.hideViews()
                    
                    
                    let displayedProjectUrlStr = urlStr+"\(self.ownerLoginResult.data!.projects!.data!.id!)"
                    print("\(displayedProjectUrlStr) $$$$$$$$$$$$$$$$$$")
                    //        if displayedProjectUrlStr {
                    //
                    //        }
                    
                    let url = URL(string: displayedProjectUrlStr)
                    
                    
                    
                    
                    
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
                                self.presenter?.showNetworkError(with: errorMessageText)
                                
                                print("******************************** \(response.value!) **********************")
                                //  print("\()")
                                print("errorrrrelse")
                                // print("")
                                
                            }else{
                                
                                print("\(url!)")
                                print(response.value!)
                                //           data = countryResult
                                UserDefaults.standard.set( response.data!, forKey: "displayCreatedProject")
                                //  UserDefaults.standard.set( response.data!, forKey: "displayProject")
                                self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: response.data!)
                                
                            }
                        case .failure(_):
                            print("error")
                            
                            break
                        }
                    }
                }
    }
    
    
    
    func alamofireDisplayedData(projectID:Int){
        
        
        //        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlkYzgyZjIxZjRiMTE3ODBhNzFiMmVhNDUyZTY4ZDQ0NjljZTNjNTk1ZWExOGJhMDUxODUxZjEzNTM2ZDMxZjBkMWFjZjk4MDBkZmQ0NjAxIn0.eyJhdWQiOiIxIiwianRpIjoiOWRjODJmMjFmNGIxMTc4MGE3MWIyZWE0NTJlNjhkNDQ2OWNlM2M1OTVlYTE4YmEwNTE4NTFmMTM1MzZkMzFmMGQxYWNmOTgwMGRmZDQ2MDEiLCJpYXQiOjE1NjQzODU1MzksIm5iZiI6MTU2NDM4NTUzOSwiZXhwIjoxNTk2MDA3OTM5LCJzdWIiOiIxOTQiLCJzY29wZXMiOltdfQ.HWV-2gvECYV3Yfr3vaDojtlUjWfTleoKG-QIUUg7Ms5s6dyXH7OOIqMzUKtuOrETvyR_KGmFUaS4V77kRhxXxUskhweqfmwXfZMPEiBcDBzbAxbF4_coVwshXvcV8-P4nb9RpSm_p_nR_r9zJtiSDvdxU5y5hxmGmL410AkV39SEJajEFf-hQMRlXcD683HJ8lPntssWkfK7JhHF118RvGLx6Pj_TP4qMag1pPQ1Q1xQ_WlXRO6SwZIrAu0nT7vniss32aClL6EP8kX5wQXMo8I9ZTEZk90bc6d8k-3jnvaP-fZthKgq99cSQxYXhqSsgUICBTFeZQbb64dvSy_Q7NiXbYbA9uxLmO4cBRvPhIIEBA1EEuVNWdFQKTKSAQ7MIEUey5WjMFv7bcopBrZaEhJbh7svPdDhayDlVJo9Udedv26QBM7_TyvejxKGuWvIZuWozslZpJ1KOhdjv4f461pWDZrmGjyC2Qpd7Nwhy6Q-2JWJHxSpa1AAsWwNAdLgvQIlG2r8hy2aoxadgD2SUtAT5lfU7Dm4d4l70tNT09HdC4YLCKe2HbMh9-Gf15Iz63IPaR2xlOVh5suKNVGHktO6QwHWt4dvcgef46DDhnmUDtTPjV0aVZOAg1M296nlODM28kifB8mf8BgDf1IHzoQZUDoohnet3R1ZsAHtgzE"
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            //
            
            let headers = [
                "Authorization": "Bearer \(self.ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
            ]
            
            
            let displayedProjectUrlStr = urlStr+"\(projectID)"
            print("\(displayedProjectUrlStr) $$$$$$$$$$$$$$$$$$")
            //        if displayedProjectUrlStr {
            //
            //        }
            print("\(displayedProjectUrlStr) *****************************")
            alamofireFunction2(httpMethod: .get, urlStr: displayedProjectUrlStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "displayProject")
            
            
            let urlProProductsStr = displayedProjectUrlStr + "/products"
            //        alamofireFunction2(httpMethod: .get, urlStr: urlProProductsStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "displayProjectProducts")
            
        }
    }
}
