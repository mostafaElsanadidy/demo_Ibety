//
//  SearchProjectsInterector.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import AlamofireImage
import Alamofire

class SearchProjectsInterector: SearchPresentorToInterectorProtocol {
    
    var presenter: SearchInterectorToPresenterProtocol?
    
    var displayedSearchProject=DisplayedSearchedProducts(){
        
        didSet{
            
            presenter?.updateCollectionView(with: self.displayedSearchProject.data!)
        }
    }
    
    
    func searchProject(with name: String) {
        
        let urlStr =  "http://ibety.laraeast.com/api/search/projects?name=\(name)"
        
        print("******************************** \(urlStr) ****************************")
        let url = URL.init(string: urlStr)
        
        if let token = UserDefaults.standard.string(forKey: "loginToken"){
            //self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            
            let dicOfHeader = ["Authorization": "Bearer \(token)",
                "X-Accept-Language":"ar",
                "Accept":"application/json"]
            
            
            errorMessageText = ""
            Alamofire.request(url!, method: .get ,parameters: nil, encoding: URLEncoding.default, headers: dicOfHeader).responseJSON { (response:DataResponse) in
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
                        self.presenter?.showNetworkError(with:errorMessageText)
                        print("******************************** \(response.value!) **********************")
                        //  print("\()")
                        print("errorrrrelse")
                        // print("")
                        
                    }else{
                        
                        print("\(url!)")
                        //           data = countryResult
                        
                        
                        UserDefaults.standard.set( response.data!, forKey: "displaySearchProject")
                        if let data = response.data{
                            self.displayedSearchProject = try! JSONDecoder().decode(DisplayedSearchedProducts.self, from: data)
                            
                           
                            print("\(response.value!) %%%%%%%%%%%%%% ")
                            
                        }
                    }
                case .failure(_):
                    print("error")
                    
                    break
                }
            }
        }
        else{
             presenter?.showNetworkError()
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
                        self.presenter?.showNetworkError(with: errorMessageText)
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
                                                                     "image" : cell.imageView.image ?? UIImage.init(named: "")]
                            
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
            self.presenter?.showNetworkError()
        }
    }
    
    func changeCellImage(for cell: MYPARTSCollectionViewCell, with item: DisplayedSearchedProductsData) {
        let url = URL.init(string: item.media!.image!.conversions!.thumb!)
        cell.imageView.af_setImage(withURL: url!, placeholderImage: UIImage.init(named: ""), filter: nil,  imageTransition:UIImageView.ImageTransition.crossDissolve(0.5) , runImageTransitionIfCached: true, completion: nil)
    }
}
