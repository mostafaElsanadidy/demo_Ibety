//
//  LoginRouter.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class LoginRouter:LoginPagePresenterToRouterProtocol{
    
    var presenter: LoginPageViewToPresenterProtocol?
  
    
    class func createModule(viewController: Login1ViewController) {
        
        let presenter: LoginPageViewToPresenterProtocol & LoginPageInterectorToPresenterProtocol & LoginPageViewToPresenterProtocol = LoginPresenter()
        ;
        
        let interactor: LoginPagePresentorToInterectorProtocol = LoginInterector();
        let router: LoginPagePresenterToRouterProtocol = LoginRouter();
        
        viewController.loginPresenter = presenter;
        
        presenter.loginView = viewController as! LoginPagePresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
    
    func performSegue(identifier: String) {
        if let view = presenter?.loginView as? UIViewController{
            view.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
    
    func dissmissViewController() {
        if let view = presenter?.loginView as? UIViewController{
            view.dismiss(animated: true, completion: nil)
        }
    }
    
    func passDataToAnotherView(segue: UIStoryboardSegue) {
        
        if segue.identifier == "Create_ProjectSegue"{
            
            let viewController = segue.destination as! ParentViewController
            viewController.presenter?.isUpdateState = false
        }
    }
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func presentIndexInTabBarController(index: Int) {
        tabBarViewController.selectedIndex = index
        if let viewController = presenter?.loginView as? UIViewController{
            viewController.present(tabBarViewController, animated: true, completion: nil)}
    }
    
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int) {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
            as! MyDetailsViewController
        viewController.indexOfPage = indexOfPage
        
        let count = tabBarViewController.viewControllers!.count
        if (index == 3 && count == 3) || count == 1{
            tabBarViewController.viewControllers!.insert(viewController, at: index)
        }else{
            tabBarViewController.viewControllers![3] = viewController
            }
    }
    
    func insertViewControllerInTabBar(controllerName:String , in index:Int){
        
        let viewController3 = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
        //as! LoginViewController
        tabBarViewController.viewControllers![index] = viewController3
    }
    
    
    func insertThirdViewControllerInTabBar(controllerName:String , in index:Int , indexOfPage:Int){
        
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
            as! ThirdTabViewController
        viewController.indexOfPage = indexOfPage
        if index == 2 && tabBarViewController.viewControllers!.count == 2{
            tabBarViewController.viewControllers!.insert(viewController, at: index)
        }else{
            tabBarViewController.viewControllers![index] = viewController}
      //  tabBarViewController.viewControllers!.insert(viewController, at: index)
    }
    
}
