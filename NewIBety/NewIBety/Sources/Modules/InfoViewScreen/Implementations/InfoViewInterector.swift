//
//  InfoViewInterector.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class InfoViewInterector: InfoViewPresentorToInterectorProtocol {
    
    var presenter: InfoViewInterectorToPresenterProtocol?
    
    var default_Cities:defaultCities?
    var categoryResult:CategoryResult?
    var image : UIImage!
    var ownerLoginResult:OwnerLogin_Result!
    
    let urlStr = "http://ibety.laraeast.com/api/"
    let dicOfHeader = ["X-Accept-Language":"ar", "Accept":"application/json"]
    var isUpdateState:Bool = false
    var changedProjectDetail:project_Details!
    var displayedProjectDetails:projectCreationDetails!
    
    var projectInfo:project_Info!

    func showProjectImage(with urlStr: String) {
    
        
        Alamofire.request(URL(string: urlStr)!).responseData { (response) in
            if response.error == nil {
                print(response.result)
                // Show the downloaded image:
                if let data = response.data {
                    
                    self.presenter?.displayImage(wit: data)
                }
            }
        }
    }
    
    func displayProjectService() {
        let data = UserDefaults.standard.data(forKey: "displayCreatedProject")
        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
        presenter?.showProjectDetails(with: displayedProjectDetails)
    }
    
    
    func category_defaultCitiesService() {
        let urlCountryStr = urlStr+"countries/default/cities"
        let urlCategoryStr = urlStr+"categories"
        let method = HTTPMethod.get
        alamofireFunction2(httpMethod: method, urlStr: urlCountryStr, dicOfHeader: dicOfHeader, dicOfBody: nil, userDefaultKey : "DefaultCities_ListData")
        alamofireFunction2(httpMethod: method,  urlStr: urlCategoryStr, dicOfHeader: dicOfHeader, dicOfBody: nil, userDefaultKey : "Categories_ListData")
    }
    
    func showDefault_CitiesService() {
        let data1 = UserDefaults.standard.data(forKey: "DefaultCities_ListData")
        self.default_Cities = try! JSONDecoder().decode(defaultCities.self, from: data1!)
        presenter?.changeDropDown(with: self.default_Cities!.data!.cities!)
    }
    
    func showCategoriesService() {
        let data1 = UserDefaults.standard.data(forKey: "Categories_ListData")
        self.categoryResult = try! JSONDecoder().decode(CategoryResult.self, from: data1!)
        presenter?.change_DropDown(with: self.categoryResult!.data!)
    }
    
    func updateProject() {
        
        let projectData = self.displayedProjectDetails.data!
        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        if projectData.id! == projectID{
            
            let data = UserDefaults.standard.data(forKey: "UserLoginResult")
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data!)
            
            
            print(ownerLoginResult.token!)
            //    print(projectInfo.projectImageStr!)
            
            let headers = [
                "Authorization": "Bearer \(ownerLoginResult.token!)",
                "X-Accept-Language":"ar",  "Accept":"application/json"]
            let updateUrlStr = urlStr+"projects/\(projectID)"
            
            // print(dicOfUpdateProject["image"])
            let url = URL(string: updateUrlStr)
            
            errorMessageText = ""
            
            Alamofire.request(url!, method: .patch ,parameters: dicOfUpdateProject, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
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
                        
                        UserDefaults.standard.set( response.data!, forKey: "updateProject")
                        //  print("\(response.value!) bnkjbjkhjbjbh")
                        //   print("\(countryResult.data![0].name) ")
                        
                        self.presenter?.finishUpdate()
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            //   alamofireFunction2(httpMethod: .patch, urlStr: updateUrlStr, dicOfHeader: headers, dicOfBody: dicOfUpdateProject, userDefaultKey: "updateProject")
        }
        
        
    }
}
