//
//  ProDetailsRouter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class ProDetailsRouter:ProDetailsPresenterToRouterProtocol {
    
    
    var ProjectDetailsViewController : ProjectDetailsViewController!
    var UserProductsViewController : UserProductsViewController!
    var CommunicateDetailsViewController : CommunicateDetailsViewController!
    
    
    class func createModule(view: ProDetailsViewController) {
        
        let presenter:  ProDetailsInterectorToPresenterProtocol & ProDetailsViewToPresenterProtocol = ProDetailsPresenter()
        ;
        
        let interactor: ProDetailsPresentorToInterectorProtocol = ProDetailsInterector();
        let router: ProDetailsPresenterToRouterProtocol = ProDetailsRouter();
        
        view.presenter = presenter;
        
        presenter.view = view as! ProDetailsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    func popViewController() {
        if let viewController = presenter?.view as? UIViewController{
            let _ = viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func addViewController(childController: UIViewController, in parentController: UIViewController, in contentView: UIView) {
        childController.willMove(toParent: parentController)
        
        // Add to containerview
        contentView.addSubview(childController.view)
        parentController.addChild(childController)
        childController.view.frame = contentView.bounds
        childController.didMove(toParent: parentController)
    }
    
    
    
    var presenter:ProDetailsViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func instantiateViewController() {
         CommunicateDetailsViewController = self.mainstoryboard.instantiateViewController(
            withIdentifier: "CommunicateDetailsViewController") as! CommunicateDetailsViewController
        
         ProjectDetailsViewController = self.mainstoryboard.instantiateViewController(
            withIdentifier: "ProjectDetailsViewController") as! ProjectDetailsViewController
        
         UserProductsViewController = self.mainstoryboard.instantiateViewController(
            withIdentifier: "UserProductsViewController") as! UserProductsViewController
        
    }
    
    
    func addChildViewController(with Identifier: String, isVertical: Bool, in contentView: UIView) {
        
        
        UserProductsViewController.isVertical = isVertical
        
        if let view = presenter?.view as? UIViewController{
            
           addViewController(childController: UserProductsViewController, in: view, in: contentView)
        }
        
    }
    
    func addChildViewController(with Identifier: String, in contentView: UIView) {
        
        var viewController = UIViewController()
        if Identifier == "CommunicateDetailsViewController"{
             viewController = CommunicateDetailsViewController
       }
        else if Identifier == "ProjectDetailsViewController"{
            
             viewController = ProjectDetailsViewController
        }
        
        if let view = presenter?.view as? UIViewController{
            addViewController(childController: viewController, in: view, in: contentView)
        }
 }
}
