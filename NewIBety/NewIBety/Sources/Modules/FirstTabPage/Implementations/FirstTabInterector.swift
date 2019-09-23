//
//  FirstTabInterector.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Alamofire

class FirstTabInterector:FirstTabPresentorToInterectorProtocol{
   
    func displayCategoryProjectsService(identifier: String, with cell: MYPARTSCollectionViewCell, selectedCategoryIndex: Int) {
        let categoryProjectsUrlStr = "http://ibety.laraeast.com/api/categories/\(selectedCategoryIndex)/projects"
      
        let url = URL(string: categoryProjectsUrlStr)
        errorMessageText = ""
        Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: getHeaders).responseJSON { (response:DataResponse) in
            switch(response.result) {
            case .success:
                
                errorMessageText = ""
                print("\(response.value!)")
                
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
                    self.presenter?.show_Error(errorMessageText: errorMessageText)
                    print("errorrrrelse")
                    
                    
                }else{
                    
                    //           data = countryResult
                    UserDefaults.standard.set( response.data!, forKey: "DisplayedCategoryProjects")
                    
                    self.presenter?.performSegue(identifier: identifier)
                        
                        print("\(cell.nameLabel.text!)")
                        
                        let dictionOfTitle_Image:[String:Any] = ["title" : cell.nameLabel.text!,
                                                                 "image" : cell.imageView.image!]
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SendCategoryData"), object: nil, userInfo: dictionOfTitle_Image)
                    
                    // self.present(tabBarViewController, animated: true, completion: nil)
                    
                    print("\(response.value!) sgvsagsdgsg ")
                }
            case .failure(_):
                print("error")
                
                break
            }
        }
    }
    var presenter:FirstTabInterectorToPresenterProtocol?
    var displayedCategories:CategoryResult!
    
    func updatePageName_UserDefault(with value:String){
        
        UserDefaults.standard.set(value, forKey: "PAGENAME")
    }
    
    func displayCellImageService(for cell: MYPARTSCollectionViewCell, with item: categoriesData) {
        Alamofire.request(item.media!.image!.conversions!.thumb!).responseData { (response) in
            if response.error == nil {
                print(response.result)
                // Show the downloaded image:
                if let data = response.data {
                    
                    self.presenter?.displayCellImage(for: cell, with: data)
                    
                }
            }
        }
    }
    func displayCategoriesService() {
        Alamofire.request(url!, method: .get ,parameters: nil, encoding: URLEncoding.default, headers: getHeaders).responseJSON {
            (response:DataResponse) in
            switch(response.result) {
            case .success:
                errorMessageText = ""
                
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
                    self.presenter?.show_Error(errorMessageText: errorMessageText)
                    print("******************************** \(response.value!) **********************")
                    //  print("\()")
                    print(response.error?.localizedDescription)
                    print("errorrrrelse")
                    // print("")
                    
                }else{
                    
                    //           data = countryResult
                    
                    UserDefaults.standard.set( response.data!, forKey: "DisplayedCategory")
                    //  print("\(response.value!) bnkjbjkhjbjbh")
                    //   print("\(countryResult.data![0].name) ")
                    
                    print("fdafadsfas")
                    self.displayedCategories = try! JSONDecoder().decode(CategoryResult.self, from: response.data!)
                    self.presenter?.reloadCollectionViewByService(displayedCategories: self.displayedCategories)
                    
                }
            case .failure(_):
                print("error")
                
                break
            }
        }
    }
    
    
    let url = URL.init(string: "http://ibety.laraeast.com/api/categories")

}
