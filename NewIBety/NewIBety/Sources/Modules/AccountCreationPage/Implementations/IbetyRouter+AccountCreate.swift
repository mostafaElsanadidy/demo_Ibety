//
//  IbetyRouter+AccountCreate.swift
//  IBety
//
//  Created by 68lion on 8/30/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class AccountRouter:AccountCreate_PresenterToRouterProtocol{
   
    var presenter: AccountCreate_ViewToPresenterProtocol?
    func performSegue(identifier: String) {
        if let view = presenter?.accountView as? UIViewController{
            view.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
   
    func dissmissViewController() {
        let viewController = presenter?.accountView as! UIViewController
        viewController.dismiss(animated: true, completion: nil)
    }
    
    class func createModule(viewController:AccountCreationViewController){
        
        let presenter: AccountCreate_ViewToPresenterProtocol & AccountCreate_InterectorToPresenterProtocol & AccountCreate_ViewToPresenterProtocol = AccountCreatePresenter()
        
        
        let interactor: AccountCreate_PresentorToInterectorProtocol = AccountInterector();
        let router: AccountCreate_PresenterToRouterProtocol = AccountRouter();
        
        presenter.accountRouter = router;
        presenter.accountInterector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        presenter.accountView = viewController as! AccountCreate_PresenterToViewProtocol
        viewController.presenter = presenter
        
        
    }
    
    func passDataToAnotherView(segue:UIStoryboardSegue){
        
        if segue.identifier == "showTerms"{
            
            
            let viewController = segue.destination as! Terms_ConditionsViewController
            
            if let accountPresenter = presenter as? Terms_ConditionsViewControllerDelegate{
                
                viewController.presenter?.delegate = accountPresenter }
        }
        
        if segue.identifier == "Create_ProjectSegue"{
            
            
            let viewController = segue.destination as! ParentViewController
            viewController.presenter?.isUpdateState = false
        }
        
    }
    
}

