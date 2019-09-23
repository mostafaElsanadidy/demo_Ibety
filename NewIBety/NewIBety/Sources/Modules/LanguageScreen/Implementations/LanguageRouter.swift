//
//  LanguageRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class LanguageRouter: LanguagePresenterToRouterProtocol {
    var presenter: LanguageViewToPresenterProtocol?
    
    
    class func createModule(view: LanguageViewController) {
        
        let presenter: LanguageViewToPresenterProtocol & LanguageInterectorToPresenterProtocol = LanguagePresenter();
        
        let interactor: LanguagePresentorToInterectorProtocol = LanguageInterector();
        let router: LanguagePresenterToRouterProtocol = LanguageRouter();
        
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
    
    func returnToFirst() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.mainstoryboard.instantiateViewController(withIdentifier: "FirstViewController")
    }
    
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int) {
        
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: controllerName) as! MyDetailsViewController
        viewController.indexOfPage = indexOfPage
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = index
    }
}
