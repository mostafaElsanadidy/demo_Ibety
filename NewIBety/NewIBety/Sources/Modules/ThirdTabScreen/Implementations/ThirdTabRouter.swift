//
//  ThirdTabRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ThirdTabRouter: ThirdTabPresenterToRouterProtocol {
    var presenter: ThirdTabViewToPresenterProtocol?
    
    class func createModule(view: ThirdTabViewController) {
        
        let presenter: ThirdTabViewToPresenterProtocol & ThirdTabInterectorToPresenterProtocol = ThirdTabPresenter();
        
        let interactor: ThirdTabPresentorToInterectorProtocol = ThirdTabInterector();
        let router: ThirdTabPresenterToRouterProtocol = ThirdTabRouter();
        
        view.presenter = presenter;
        presenter.view = view;
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func addChildController(indexOfPage: Int) {
        
        if indexOfPage == 7{
            let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "NotificationTableViewController") as! NotificationTableViewController
            addChildViewController(childViewController: viewController)
        }
        
        if indexOfPage == 1{
            
            let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
            addChildViewController(childViewController: viewController)
        }
        
        if indexOfPage == 2{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "AboutApplicationViewController") as! AboutApplicationViewController
            //  viewController.aboutTextView.text = applicationSettings.data!.about!
            addChildViewController(childViewController: viewController)
        }
        
        if indexOfPage == 3{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "CommunicationViewController") as! CommunicationViewController
            //  viewController.aboutTextView.text = applicationSettings.data!.about!
            addChildViewController(childViewController: viewController)
        }
        
        if indexOfPage == 4{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "AdvertisingInfoViewController") as! AdvertisingInfoViewController
            //  viewController.aboutTextView.text = applicationSettings.data!.about!
            addChildViewController(childViewController: viewController)
        }
        
        if indexOfPage == 6 || indexOfPage == 5{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "SendMessageViewController") as! SendMessageViewController
            //  viewController.aboutTextView.text = applicationSettings.data!.about!
            addChildViewController(childViewController: viewController)
        }
    }
    
    func addChildViewController(childViewController: UIViewController){
        if let parentController = presenter?.view as? ThirdTabViewController{
            childViewController.willMove(toParent: parentController)
            
            // Add to containerview
            parentController.containerView.addSubview(childViewController.view)
            parentController.addChild(childViewController)
            childViewController.view.frame = parentController.containerView.bounds
            childViewController.didMove(toParent: parentController)}
    }
    
    
    func dismissViewController() {
        if let view = presenter?.view as? UIViewController{
            view.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int) {
        
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: controllerName) as! MyDetailsViewController
        viewController.indexOfPage = indexOfPage
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = index
    }
    
}

