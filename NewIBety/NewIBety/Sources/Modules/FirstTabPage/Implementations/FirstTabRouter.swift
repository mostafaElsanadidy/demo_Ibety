//
//  FirstTabRouter.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class FirstTabRouter: FirstTabPresenterToRouterProtocol {
    
    class func createModule(viewController: FirstTABViewController) {
        
        let presenter: FirstTabViewToPresenterProtocol & FirstTabInterectorToPresenterProtocol & FirstTabViewToPresenterProtocol = FirstTabPresenter()
        ;
        
        let interactor: FirstTabPresentorToInterectorProtocol = FirstTabInterector();
        let router: FirstTabPresenterToRouterProtocol = FirstTabRouter();
        
        viewController.presenter = presenter;
        
        presenter.view = viewController as! FirstTabPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }

    var presenter: FirstTabViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func performSegue(identifier: String) {
        if let viewController = presenter?.view as? UIViewController{
            viewController.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
    
    func dissmissViewController() {
        if let viewController = presenter?.view as? FirstTABViewController{
            
                let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                
                if rootviewcontroller.rootViewController == tabBarViewController{
                    rootviewcontroller.rootViewController = self.mainstoryboard.instantiateViewController(withIdentifier: "FirstViewController")
                }
            else{
                    viewController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}
