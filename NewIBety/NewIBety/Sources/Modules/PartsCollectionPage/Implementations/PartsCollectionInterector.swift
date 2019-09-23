//
//  PartsCollectionInterector.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PartsCollectionInterector:PartsCollectionPresentorToInterectorProtocol{
    
    var presenter: PartsCollectionInterectorToPresenterProtocol?
    
    func displayCellImageService(for cell: MYPARTSCollectionViewCell, with item: CategoryProjectsData) {
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
    
    func displayCategoryProjects(with selectedIndex: Int, for  cell:MYPARTSCollectionViewCell) {
        
        print("\(selectedIndex) sfnsdjkfnsdjfnjk")
        print(UserDefaults.standard.data(forKey: "UserLoginResult"))
        print("snafskjdnfsjkdnfjdskgnvsdkjvnsdjkvas")
        if let token = UserDefaults.standard.string(forKey: "loginToken"){
            
            let headers = [
                "Authorization": "Bearer \(token)",
                "X-Accept-Language":"ar",
                "Accept":"application/json" ,
            ]
            
            let urlStr = "http://ibety.laraeast.com/api/projects/"
            
            let displayedProjectUrlStr = urlStr+"\(selectedIndex)"
            print("\(displayedProjectUrlStr) $$$$$$$$$$$$$$$$$$")
            //        if displayedProjectUrlStr {
            //
            //        }
            let url = URL(string: displayedProjectUrlStr)
            
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
                        self.presenter?.showError()
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        //           data = countryResult
                        UserDefaults.standard.set( response.data!, forKey: "displayProject")
                        
                        
                        if response.data != nil{
                            // print(data)
//                            let viewController = self.storyboard!.instantiateViewController(
//                                withIdentifier: "ProDetailsViewController")
//                                as! ProDetailsViewController
//
                            
                            
                            let urlProProductsStr = displayedProjectUrlStr + "/products"
                            alamofireFunction2(httpMethod: .get, urlStr: urlProProductsStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "displayProjectProducts")
                            
                            
                            self.presenter?.performSegue(identifier: "showProjectPage")
                            
                            
                            
                                let dictionOfTitle_Image:[String:Any] = ["title" : cell.nameLabel.text!,
                                                                         "image" : cell.imageView.image!]
                                
                                print("adsfasdfsdfsdafsdfasdfsdfsdf")
                                
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SendProjectData"), object: nil, userInfo: dictionOfTitle_Image)
                            
                            
                        }
                        print("\(response.value!)")
                        //   print("\(countryResult.data![0].name) ")
                        
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
            print("\(displayedProjectUrlStr) *****************************")
        }
        else{
            self.presenter?.showError()
        }
    }
    func updateCollectionView() {
        let data = UserDefaults.standard.data(forKey: "DisplayedCategoryProjects")
        let category_Projects = try! JSONDecoder().decode(CategoryProjects.self, from: data!)
        presenter?.updateCollectionView(with: category_Projects)
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleOfPage(_:)), name: NSNotification.Name(rawValue: "SendCategoryData"), object: nil)
    }
    
    // handle notification
    @objc func changeTitleOfPage(_ notification: Notification) {
        if let image = notification.userInfo?["image"] as? UIImage , let title = notification.userInfo?["title"] as? String{
            // do something with your image
            print("\(title) dbfbfdbdfbdf")
            presenter?.updateTitleView(with: image, name: title)
        }
    }
    
    
}
