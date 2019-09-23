//
//  ParentViewRouter.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ParentViewRouter: ParentViewPresenterToRouterProtocol{
    
    var presenter: ParentViewViewToPresenterProtocol?
    
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func instantiateViewController(with identifier: String) -> UIViewController{
    
        return mainstoryboard.instantiateViewController(withIdentifier: identifier)
    }
    
    class func createModule(view: ParentViewController) {
        
        
    let presenter:ParentViewViewToPresenterProtocol = ParentViewPresenter();
        
        let interactor: ParentViewPresentorToInterectorProtocol = ParentViewInterector();
        let router: ParentViewPresenterToRouterProtocol = ParentViewRouter();
        
        view.presenter = presenter;
        presenter.view = view as! ParentViewPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
//        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    
    func addChildViewController(childViewController: UIViewController) {
        
        if let parentController = presenter?.view as? ParentViewController{
        childViewController.willMove(toParent: parentController)
        
        // Add to containerview
            for subView in parentController.containerView.subviews{
                subView.isHidden = true
            }
            
        parentController.containerView.addSubview(childViewController.view)
        parentController.addChild(childViewController)
        childViewController.view.frame = parentController.containerView.bounds
            childViewController.didMove(toParent: parentController)
            
        }
        
    }
    
    
    func dismissViewController() {
        
        if let view = presenter?.view as? UIViewController{
            view.dismiss(animated: true, completion: nil)}
    }
}
