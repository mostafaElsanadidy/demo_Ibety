//
//  CommunicationRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class CommunicationRouter: CommunicationPresenterToRouterProtocol {
    
   var presenter: CommunicationViewToPresenterProtocol?
    
    class func createModule(view: CommunicationViewController) {
        
        let presenter: CommunicationViewToPresenterProtocol & CommunicationInterectorToPresenterProtocol = CommunicationPresenter();
        
        let interactor: CommunicationPresentorToInterectorProtocol = CommunicationInterector();
        let router: CommunicationPresenterToRouterProtocol = CommunicationRouter();
        
        view.presenter = presenter;
        presenter.view = view as! CommunicationPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func updateTabBarViewController(with index: Int) {
        
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "ThirdTabViewController1") as! ThirdTabViewController
        viewController.indexOfPage = 6
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = index
    }
}
