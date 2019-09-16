//
//  MyDetailsRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class MyDetailsRouter: MyDetailsPresenterToRouterProtocol {
    var presenter: MyDetailsViewToPresenterProtocol?
    
    class func createModule(view: MyDetailsViewController) {
        
        let presenter: MyDetailsViewToPresenterProtocol & MyDetailsInterectorToPresenterProtocol = MyDetailsPresenter();
        
        let interactor: MyDetailsPresentorToInterectorProtocol = MyDetailsInterector();
        let router: MyDetailsPresenterToRouterProtocol = MyDetailsRouter();
        
        view.presenter = presenter;
        presenter.view = view as! MyDetailsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func moveToFirstViewController() {
        
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        
                rootviewcontroller.rootViewController = self.mainstoryboard.instantiateViewController(withIdentifier: "FirstViewController")
            
        
//        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
//        if let view = presenter?.view as? UIViewController{
//            view.present(viewController, animated: true, completion: nil)}
    }
    
    func moveToProjectPartsPage() {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MyProjectPartsViewController") as! MyProjectPartsViewController
        tabBarViewController.viewControllers![3] = viewController
        tabBarViewController.selectedIndex = 3
        tabBarViewController.viewControllers![3].tabBarItem!.image = UIImage(named: "Group 656")
        tabBarViewController.viewControllers![3].tabBarItem!.title = ""
    }
    
    func performSegue(withIdentifier: String) {
        
        if let view = presenter?.view as? UIViewController{
            view.performSegue(withIdentifier: withIdentifier, sender: nil)
    }
  }
    
    func instantiateViewController(withIdentifier: String) {
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: withIdentifier) as! LoginViewController
        tabBarViewController.viewControllers![1] = viewController
        tabBarViewController.selectedIndex = 1
    }
    
    func updateTabBarViewController(with index: Int, indexOpage: Int) {
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "ThirdTabViewController1") as! ThirdTabViewController
        viewController.indexOfPage = indexOpage
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = index
    }
    
}
