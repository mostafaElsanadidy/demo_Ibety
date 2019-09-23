//
//  MyProjectPartsRouter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class MyProjectPartsRouter: MyProjectPartsPresenterToRouterProtocol {
    
   
    var presenter:MyProjectPartsViewToPresenterProtocol?
    static func createModule(view: MyProjectPartsViewController) {
    
        let presenter: MyProjectPartsViewToPresenterProtocol & MyProjectPartsInterectorToPresenterProtocol = MyProjectPartsPresenter();
        
        let interactor: MyProjectPartsPresentorToInterectorProtocol = MyProjectPartsInterector();
        let router: MyProjectPartsPresenterToRouterProtocol = MyProjectPartsRouter();
        
        view.presenter = presenter;
        presenter.view = view as! MyProjectPartsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
    
    func moveBttnToPage(num: Int) {
        
        var viewController = UIViewController()
        
        if num == 1{
         viewController = mainstoryboard.instantiateViewController(withIdentifier: "FourTabViewController")
            if let viewController = viewController as? FourTabViewController{
                viewController.isProInfo = true
                
            }
         }
            
        else if num == 2{
            
            viewController = mainstoryboard.instantiateViewController(withIdentifier: "MyProductViewController2")
            if let viewController = viewController as? MyProductViewController{
                viewController.isVertical = false
                viewController.isUpdateState = true
            }
        }
        
        else if num == 3{
             viewController = mainstoryboard.instantiateViewController(withIdentifier: "FourTabViewController")
            if let viewController = viewController as? FourTabViewController{
                viewController.isProInfo = false
                viewController.iscommunicateInfo = true
            }
        }
        
        else if num == 0{
             viewController = mainstoryboard.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
        }
        tabBarViewController.viewControllers![3] = viewController
        tabBarViewController.selectedIndex = 3
        tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
}

}
