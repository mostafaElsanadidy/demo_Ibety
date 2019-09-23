//
//  ProjectDataInterector.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//


import Alamofire

class ProjectDataInterector: ProjectDataPresentorToInterectorProtocol {
    
    var presenter:ProjectDataInterectorToPresenterProtocol?
    var ownerLoginResult:OwnerLogin_Result!
    var displayedProjectDetails = projectCreationDetails(){
        didSet{
            presenter?.displayProjectDetails(with: self.displayedProjectDetails)
        }
    }
    
    func updateProjectService() {
        
//        let projectData = self.displayedProjectDetails.data!
//        let projectID = UserDefaults.standard.integer(forKey: "ProjectID")
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            
            print(ownerLoginResult.token!)
            //    print(projectInfo.projectImageStr!)
            
            let headers = [
                "Authorization": "Bearer \(ownerLoginResult.token!)",
                "X-Accept-Language":"ar",  "Accept":"application/json"]
            let updateUrlStr = urlStr+"projects/\(ownerLoginResult.data!.projects!.data!.id!)"
            
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
                        
                       self.presenter?.showAlertForProjectUpdate()
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            //   alamofireFunction2(httpMethod: .patch, urlStr: updateUrlStr, dicOfHeader: headers, dicOfBody: dicOfUpdateProject, userDefaultKey: "updateProject")
        
        }
        
    }
    
    var projectDetails = projectCreationDetails(){
        didSet{
            
            let urlAddProjectStr = urlStr+"projects"
            let urlAddProductStr = urlAddProjectStr + "/\(self.projectDetails.data!.id!)/products"
            
            let headers = [
                "Authorization": "Bearer \(ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
            ]
            
            UserDefaults.standard.set( self.projectDetails.data!.id!, forKey: "ProjectID")
            
            if self.projectDetails != nil{
                alamofireFunction2(httpMethod: .post, urlStr: urlAddProductStr, dicOfHeader: headers, dicOfBody: dicOfProductDetails, userDefaultKey: "AddNewProductData")}
            
        }
    }
    
    func createProjectService() {
        
        errorMessageText = ""
        
        
        print(userProject.productPrice)
        print("asdfdfdasn kjnkjnkj nkjnkjnkjn")
        var dicOfBody:[String:Any] = ["project[name]" : userProject.projectName ,
                                      "project[description]" : userProject.projectDescription ,
                                      "project[city_id]" :  userProject.projectCity_Id,
                                      "project[category_id]" : userProject.projectCategory_Id ,
                                      "project[image]" : userProject.projectImage ,
                                      "project[latitude]" : userProject.projectLatitude ,
                                      "project[longitude]" : userProject.projectLongitude ,
                                      "project[address]" : userProject.projectAddress ,
                                      "project[email]" : userProject.projectEmail,
                                      "project[phone]" : userProject.projectPhone ,
                                      "product[name]" : userProject.productName ,
                                      "product[description]" : userProject.productDescription ,
                                      "product[price]" : userProject.productPrice ,
                                      "product[images][0]" : userProject!.productImages[0]
        ]
        
        let urlAddProjectStr = urlStr+"projects"
        let url = URL(string: urlAddProjectStr)
        for (index , imageStr) in userProject.productImages.enumerated(){
            dicOfBody.updateValue(imageStr, forKey: "product[images][\(index)]")
        }
        
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            let headers = [
                "Authorization": "Bearer \(ownerLoginResult.token!)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
            ]
            
            Alamofire.request(url!, method: .post ,parameters: dicOfBody, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
                switch(response.result) {
                case .success:
                    
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
                        print(url!)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print(response.error?.localizedDescription)
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        //           data = countryResult
                        UserDefaults.standard.set( response.data!, forKey: "AddProjectData")
                        
                        self.projectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: response.data!)
                        print("\(response.value!)")
                        
                        self.presenter?.showAlertForProjectCreation()
                        //   print("\(countryResult.data![0].name) ")
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            
            
        }
    }
    
    func displayProjectDetails() {
        
        let data = UserDefaults.standard.data(forKey: "displayCreatedProject")
        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
    }
}
