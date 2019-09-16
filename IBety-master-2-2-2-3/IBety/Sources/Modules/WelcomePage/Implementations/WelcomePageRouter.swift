//
//  WelcomePageRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class WelcomeRouter: WelcomePresenterToRouterProtocol {
    
    var presenter: WelcomeViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    class func createModule(view: WelcomeViewController) {
    
        let presenter: WelcomeViewToPresenterProtocol & WelcomeInterectorToPresenterProtocol = WelcomePresenter();
        
        let interactor: WelcomePresentorToInterectorProtocol = WelcomeInterector();
        let router: WelcomePresenterToRouterProtocol = WelcomeRouter();
        
        view.presenter = presenter;
        presenter.view = view ;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    func moveToFirstViewController() {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        
        if let view = presenter?.view as? WelcomeViewController{
            view.present(viewController, animated: true, completion: nil)}
    }
    
    func updateTabBarViewController(using index: Int, indexOfPage: Int) {
        
        let viewController2 = self.mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        tabBarViewController.viewControllers![1] = viewController2
        tabBarViewController.viewControllers![1].tabBarItem!.image = UIImage(named: "User-2")
        
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "ThirdTabViewController1") as! ThirdTabViewController
        viewController.indexOfPage = 7
        
        let viewController3 = self.mainstoryboard.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
        viewController3.indexOfPage = indexOfPage
        
        if tabBarViewController.viewControllers!.count == 2{
            tabBarViewController.viewControllers!.insert(viewController, at: 2)
            tabBarViewController.viewControllers!.insert(viewController3, at: 3)
        }else{
            tabBarViewController.viewControllers![2] = viewController
            tabBarViewController.viewControllers![3] = viewController3
        }
        
        tabBarViewController.viewControllers![2].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Bell"), selectedImage: UIImage(named: "Bell-1"))
        tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), selectedImage: UIImage(named: "Group-1"))
        
        tabBarViewController.selectedIndex = 3
        
        if let view = presenter?.view as? UIViewController{
           view.present(tabBarViewController, animated: true, completion: nil)
        }
        
    }
}
