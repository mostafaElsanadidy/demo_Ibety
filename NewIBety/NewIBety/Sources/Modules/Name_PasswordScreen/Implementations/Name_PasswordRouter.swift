//
//  Name_PasswordRouter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class Name_PasswordRouter:Name_PasswordPresenterToRouterProtocol{
    
    var presenter : Name_PasswordViewToPresenterProtocol?
    
    class func createModule(view: Name_PasswordViewController) {
    
        let presenter: Name_PasswordViewToPresenterProtocol & Name_PasswordInterectorToPresenterProtocol = Name_PasswordPresenter();
        
        let interactor: Name_PasswordPresentorToInterectorProtocol = Name_PasswordInterector();
        let router: Name_PasswordPresenterToRouterProtocol = Name_PasswordRouter();
        
        view.presenter = presenter;
        presenter.view = view as! Name_PasswordPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    var mainstoryboard2:UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func dismissViewController() {
        
        if let viewController = presenter?.view as? UIViewController{
            
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func PerformSegue(with identifier: String) {
        if let viewController = presenter?.view as? UIViewController{
            
            viewController.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
    
    func insertThirdViewControllerInTabBar(controllerName: String, in index: Int, indexOfPage: Int) {
        let viewController = mainstoryboard2.instantiateViewController(withIdentifier: controllerName) as! ThirdTabViewController
        viewController.indexOfPage = indexOfPage
        tabBarViewController.viewControllers!.insert(viewController, at: index)
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Bell"), selectedImage: UIImage(named: "Bell-1"))
        
    }
    
    func insertViewControllerInTabBar(controllerName: String, in index: Int) {
        
        if controllerName == "MyProjectPartsViewController"{
        let viewController2 = self.mainstoryboard2.instantiateViewController(withIdentifier: controllerName) as! MyProjectPartsViewController
        tabBarViewController.viewControllers!.insert(viewController2, at: index)
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), selectedImage: UIImage(named: "Group-1"))
        }
            
        else if controllerName == "LoginViewController"{
        let viewController2 = self.mainstoryboard2.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        tabBarViewController.viewControllers![index] = viewController2
        tabBarViewController.viewControllers![index].tabBarItem!.image = UIImage(named: "User-2")
        }
    }
    
    func presentIndexInTabBarController(index: Int) {
        tabBarViewController.selectedIndex = index
        
        if let viewController = presenter?.view as? UIViewController{
            viewController.present(tabBarViewController, animated: true, completion: nil)}
    }
}
