//
//  FirstViewController.swift
//  IBety
//
//  Created by Mohamed on 7/9/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SSCustomTabbar
import FacebookLogin

import FBSDKLoginKit
import FBSDKShareKit
import FacebookCore

class FirstViewController: UIViewController{
    

    @IBOutlet weak var facebookBttn: UIButton!
    @IBOutlet weak var googleBttn: UIButton!
    @IBOutlet weak var twitterBttn: UIButton!
    @IBOutlet weak var continueBttn: UIButton!
    @IBOutlet weak var languageBttn: UIButton!
    @IBOutlet weak var createAccountBttn: UIButton!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    var presenter:ViewToPresenterProtocol?
    
    var index = 0
//    let categoriesUrlStr = "http://ibety.laraeast.com/api/categories"
////    var displayedCategories:CategoryResult!
//    var ownerLoginResult:OwnerLogin_Result!
//    let headers = [
//        "X-Accept-Language":"ar",
//        "Accept":"application/json"
//    ]
//
//    var language: String!
//    var bundle: Bundle!
//    let LANGUAGE_KEY: String = "LANGUAGE_KEY"
//
//    var errorMessageText = ""
//    var index = 0
    
    override func viewDidLoad() {
        
        IbetyRouter.createModule(viewController: self)
        presenter?.updateView()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.updateUserDefaults(value: "FirstViewController", key: "PAGENAME" , byKey: "IsEnterBackGround" )
        
       continueBttn.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        let str = "create_account".localized
        
        print(str)
        createAccountBttn.setTitle(str, for: .normal)
        //        let language = UserDefaults.standard.string(forKey: "languageOfApp")
        
        presenter?.updateIfEnterBackground()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         presenter?.drawPathLine(by: separatorLabel.frame, mainFrame:createAccountBttn.frame)
        
    }
    
    @IBAction func completeAsVisitor() {
        presenter?.completeAsVisitor(index: 0)
    }
    
    @IBAction func english_arabicLanguageSetting() {
        presenter?.showLanguageScreen(in: index)
    }
    
    @IBAction func logInBttnAction() {
//
//        let navigationController = storyboard!.instantiateViewController(withIdentifier: "UINavigationController") as! UINavigationController
        if !self.isBeingPresented{
         presenter?.initiate_PresentViewController(controllerName: "Login1ViewController")
//        navigationController.pushViewController(viewController, animated: true)
         //   present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginWithFaceBook() {
      
        let manager = FBSDKLoginKit.LoginManager()
        
        if let token = AccessToken.current{
            
            manager.logOut()
            let urlStr = "http://ibety.laraeast.com/api/login/facebook"
            print(token.tokenString)
            
            print(token.appID)
            
            alamofireFunction2(httpMethod: .post, urlStr: urlStr, dicOfHeader: getHeaders, dicOfBody: ["access_token":token.tokenString], userDefaultKey: "accessFacebooktoken")
            presenter?.completeAsVisitor(index: 0)
        }
        else{
        manager.logIn(permissions: [.publicProfile,.email], viewController: self){
            
            (result) in
            switch result{
                
            case .cancelled:
                print("User Cancelled")
                break
                
            case .failed(let error):
                print("Login Failed with error = \(error.localizedDescription)")
                break
                
            case .success(granted: let grantedPermissions, declined: let declinedPermissions, token: let accessToken):
                print(" access token == \(accessToken.tokenString)")
                
                let urlStr = "http://ibety.laraeast.com/api/login/facebook"
                print(accessToken.tokenString)
                
                print(accessToken.appID)
                
                alamofireFunction2(httpMethod: .post, urlStr: urlStr, dicOfHeader: getHeaders, dicOfBody: ["access_token":accessToken.tokenString], userDefaultKey: "accessFacebooktoken")
            }
        }
    }
        
}
    
    @IBAction func loginWithGoogle() {
        
        
    }
    
    @IBAction func loginWithTwitter() {
        
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FirstViewController : PresenterToViewProtocol{
    
    
    func showViewsWithShapeLayer(shapeLayer: CAShapeLayer) {
        
        scrollView.layer.addSublayer(shapeLayer)
        
        continueBttn.layer.cornerRadius = continueBttn.frame.width/2
        languageBttn.imageView!.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2)
        
        loginButton.layer.cornerRadius = 10
        createAccountBttn.layer.cornerRadius = 10
        loginButton.layer.borderColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        loginButton.layer.borderWidth = 1
    }
    
    func receiveIndexOfMyDetailsPage(index: Int) {
        self.index = index
    }
}


    

