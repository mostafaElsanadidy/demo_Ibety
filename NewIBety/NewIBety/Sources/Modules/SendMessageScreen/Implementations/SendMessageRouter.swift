//
//  SendMessageRouter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class SendMessageRouter: SendMessagePresenterToRouterProtocol {
    
    
    var presenter : SendMessageViewToPresenterProtocol?
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    class func createModule(view: SendMessageViewController) {
     
        let presenter: SendMessageViewToPresenterProtocol & SendMessageInterectorToPresenterProtocol = SendMessagePresenter();
        
        let interactor: SendMessagePresentorToInterectorProtocol = SendMessageInterector();
        let router: SendMessagePresenterToRouterProtocol = SendMessageRouter();
        
        view.presenter = presenter;
        presenter.view = view as! SendMessagePresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int) {
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
        viewController.indexOfPage = indexOfPage
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = index
    }
    
}
