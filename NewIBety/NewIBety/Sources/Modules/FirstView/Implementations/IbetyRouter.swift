//
//  IbetyRouter.swift
//  IBety
//
//  Created by Mohamed on 8/29/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class IbetyRouter:PresenterToRouterProtocol{
    
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func updateTabBar(index:Int){
        
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
    
    func updateTabBarViewController(with index: Int, indexOfPage: Int) {
        
        if index == 3{
        insertViewControllerInTabBar(controllerName: "LoginViewController", in: 1)
        updateTabBar(index: 1)
            insertThirdViewControllerInTabBar(controllerName: "ThirdTabViewController1", in: 2, indexOfPage: 7)
            updateTabBar(index: 2)
        }
        insertMyDetailsViewController(controllerName: "MyDetailsViewController", index: index, indexOfPage: indexOfPage)
       // updateTabBar(index: index)
    }
    
    
    
    func passDataToAnotherView(segue: UIStoryboardSegue) {
        
       
        
    }
    
    
    var presenter: ViewToPresenterProtocol?
    
 //   var viewController:UIViewController!
    func presentIndexInTabBarController(index: Int) {
        
        tabBarViewController.selectedIndex = index
        if let viewController = self.presenter!.view! as? UIViewController{
            viewController.present(tabBarViewController, animated: true, completion: nil)
        }
    }
    
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int) {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
            as! MyDetailsViewController
        viewController.indexOfPage = indexOfPage
        let count = tabBarViewController.viewControllers!.count
        if (index == 3 && count == 3) || count == 1{
           tabBarViewController.viewControllers!.insert(viewController, at: index)
        }else{
            print(tabBarViewController.viewControllers!.count)
            print(index)
            tabBarViewController.viewControllers![index] = viewController}
        
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), selectedImage: UIImage(named: "Group-1"))
    }
    
    func insertViewControllerInTabBar(controllerName:String , in index:Int){
        
        let viewController3 = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
        //as! LoginViewController
        tabBarViewController.viewControllers!.insert(viewController3, at: index)
    }
    
    
    func insertThirdViewControllerInTabBar(controllerName:String , in index:Int , indexOfPage:Int){
        
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
            as! ThirdTabViewController
        viewController.indexOfPage = indexOfPage
        if index == 2 && tabBarViewController.viewControllers!.count == 2{
            tabBarViewController.viewControllers!.insert(viewController, at: index)
        }else{
            print(index)
            tabBarViewController.viewControllers![index] = viewController}
       tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), selectedImage: UIImage(named: "Group-1"))
        
    }
    
  
    func initiate_PresentViewController(controllerName: String){
        
        let viewController = self.presenter!.view! as! UIViewController
         let currentViewController = mainstoryboard.instantiateViewController(withIdentifier: controllerName)
         viewController.present(currentViewController, animated: true, completion: nil)
    }
    
    class func createModule(viewController: FirstViewController) {
     
        var mainstoryboard2: UIStoryboard{
            return UIStoryboard(name:"Main",bundle: Bundle.main)
        }
        
        tabBarViewController = mainstoryboard2.instantiateViewController(
            withIdentifier: "TabBarViewController") as! UITabBarController
        
        let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol & ViewToPresenterProtocol = IbetyPresenter();
        
        let interactor: PresentorToInterectorProtocol = IbetyInterector();
        let router: PresenterToRouterProtocol = IbetyRouter();
        
        viewController.presenter = presenter;
        presenter.view = viewController as! PresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
    
    
}
