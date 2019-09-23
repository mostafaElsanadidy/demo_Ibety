//
//  IbetyPresenter.swift
//  IBety
//
//  Created by Mohamed on 8/29/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

import FacebookLogin

import FBSDKLoginKit
import FBSDKShareKit
import FacebookCore

class IbetyPresenter:InterectorToPresenterProtocol{

    var view: PresenterToViewProtocol?
    var interector: PresentorToInterectorProtocol?
    var router: PresenterToRouterProtocol?
    
    var myDetailsIndex = 0
    var indexOfPage = 0
    
    func updateTabBarViewController(with index: Int, indexOfPage: Int) {
        
        self.myDetailsIndex = index
        self.indexOfPage = indexOfPage
        
        view?.receiveIndexOfMyDetailsPage(index: index)
        router?.updateTabBarViewController(with: index, indexOfPage: indexOfPage)
    }
    
}

extension IbetyPresenter:ViewToPresenterProtocol{
   
    func loginWithFacebook() {
        
        let manager = FBSDKLoginKit.LoginManager()
        
        if let token = AccessToken.current{
            
            manager.logOut()
            print(token.tokenString)
            
            print(token.appID)
            
            interector?.loginWithFacebook(with: token)
            completeAsVisitor(index: 0)
        }
        else{
            manager.logIn(permissions: [.publicProfile,.email],
                          viewController: view as! FirstViewController){
                
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
                    
                    print(accessToken.tokenString)
                    
                    print(accessToken.appID)
                    self.interector?.loginWithFacebook(with: accessToken)
                }
            }
        }
    }
    
    
    func presentIndexInTabBarController(index: Int) {
        router?.presentIndexInTabBarController(index: index)
    }
    
    func showLanguageScreen(in index: Int) {
        router?.insertThirdViewControllerInTabBar(controllerName: "ThirdTabViewController1", in: index, indexOfPage: 1)
        router?.presentIndexInTabBarController(index: index)
    }
    
    func completeAsVisitor(index: Int) {
    
        router?.insertMyDetailsViewController(controllerName: "MyDetailsViewController", index: myDetailsIndex, indexOfPage: indexOfPage)
        presentIndexInTabBarController(index: index)
    }
    
    func drawPathLine(by frame: CGRect, mainFrame: CGRect){
        
        let path = UIBezierPath()
        
        var x1 = mainFrame.origin.x
        var y1 = frame.origin.y+frame.height/2
        var x2 = frame.origin.x-frame.width/2
        print("\(x1)")
        print("\(x2)")
        
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y1))
        
        
        x1 = mainFrame.origin.x + mainFrame.width
        y1 = frame.origin.y+frame.height/2
        x2 = frame.origin.x+frame.width*1.5
        print("\(x1)")
        print("\(x2)")
        
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y1))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.462745098, green: 0.05882352941, blue: 0.2156862745, alpha: 0.3943661972)
        shapeLayer.fillColor = UIColor.brown.cgColor

        view?.showViewsWithShapeLayer(shapeLayer: shapeLayer)
    }
    

    func initiate_PresentViewController(controllerName: String){
        router?.initiate_PresentViewController(controllerName: controllerName)
    }
    
    
    
    func updateUserDefaults(value: Any, key: String, byKey: String) {
        
        if byKey == ""{
            interector?.insertUserDefaults(value: value, key: key)
        }
        else{
        let isEnteredBack = interector?.findUserDefaults(forKey: byKey) as! Bool
        //UserDefaults.standard.bool(forKey: "IsEnterBackGround")
        if !isEnteredBack{
            interector?.insertUserDefaults(value: value, key: key)
            }
        }
    }

    func updateView(){
        interector?.isBeforeLogin()
        
        let cancel_Tag = [1,2,3,4]
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? FirstViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: cancel_Tag)}
        }
    }
    
   
    
    func updateIfEnterBackground(){
        let indexOfPage = interector?.findUserDefaults(forKey: "PAGENAME") as! String
        let isEnteredBack = interector?.findUserDefaults(forKey: "IsEnterBackGround") as! Bool
        
        print("\(isEnteredBack) mostafa \(indexOfPage)")
        
        if isEnteredBack && (indexOfPage == "MyDetailsViewController" || indexOfPage == "FirstTABViewController") {
            router?.presentIndexInTabBarController(index:0)
        }
        interector?.insertUserDefaults(value: false, key: "IsEnterBackGround")
    }
    
}
