//
//  IbetyPresenter+LoginPage.swift
//  IBety
//
//  Created by 68lion on 8/31/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter:LoginPageViewToPresenterProtocol{
   
    var interector: LoginPagePresentorToInterectorProtocol?
    var router: LoginPagePresenterToRouterProtocol?
    var loginView: LoginPagePresenterToViewProtocol?
   
    func updateView() {
        if L102Language.currentAppleLanguage() == "en" {
            if let firstView = loginView as? Login1ViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
     }
    
    func passDataToAnotherView(segue: UIStoryboardSegue) {
        router?.passDataToAnotherView(segue: segue)
    }
    
    func dissmissViewController() {
        router?.dissmissViewController()
    }
    
    func login(userName: String, password: String) {
            interector?.loginService(userName: userName, password: password)
    }
}


extension LoginPresenter:LoginPageInterectorToPresenterProtocol{
    
    func presentIndexInTabBarController(index: Int) {
        router?.presentIndexInTabBarController(index: index)
    }
    
    func performSegue(identifier: String) {
        router?.performSegue(identifier: identifier)
    }
    
    func show_Error(errorMessageText: String) {
        loginView?.show_Error(errorMessageText: errorMessageText)
    }

    
    func updateTabBar(controllerName:String , index:Int){
        
        if index == 1{
            tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "User-2"), tag: 1)
        }
        if index == 2{
            
            tabBarViewController.viewControllers![2].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Bell"), selectedImage: UIImage(named: "Bell-1"))
        }
        
        if index == 3{
            tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), selectedImage: UIImage(named: "Group-1"))
        }
        
    }
    
    
    func insertViewController(controllerName:String , index:Int){
        router?.insertViewControllerInTabBar(controllerName: controllerName, in: 1)
        updateTabBar(controllerName: controllerName, index: index)
    }
    
    
    
    func insertMyDetailsViewController(controllerName:String , index:Int, indexOfPage:Int){
        
        router?.insertMyDetailsViewController(controllerName: controllerName, index: index, indexOfPage: indexOfPage)
        
        
        updateTabBar(controllerName: controllerName, index: index)
    }
    
    
    
    func insertThirdViewController(controllerName:String , index:Int , indexOfPage:Int) {
        
        router?.insertThirdViewControllerInTabBar(controllerName: controllerName, in: index, indexOfPage: indexOfPage)
        updateTabBar(controllerName: controllerName, index: index)
    }
    
}
