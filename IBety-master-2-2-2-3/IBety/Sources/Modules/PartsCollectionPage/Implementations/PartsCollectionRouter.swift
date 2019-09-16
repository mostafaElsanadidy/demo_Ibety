//
//  PartsCollectionRouter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class PartsCollectionRouter:PartsCollectionPresenterToRouterProtocol{
    
    var presenter: PartsCollectionViewToPresenterProtocol?
    
    class func createModule(view: PartsCollectionViewController) {
        
        let presenter: PartsCollectionViewToPresenterProtocol & PartsCollectionInterectorToPresenterProtocol & PartsCollectionViewToPresenterProtocol = PartsCollectionPresenter()
        ;
        
        let interactor: PartsCollectionPresentorToInterectorProtocol = PartsCollectionInterector();
        let router: PartsCollectionPresenterToRouterProtocol = PartsCollectionRouter();
        
        view.presenter = presenter;
        
        presenter.view = view as! PartsCollectionPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
    
    
    func popViewController() {
        if let viewController = presenter?.view as? UIViewController{
            viewController.navigationController?.popViewController(animated: true)
        }
    }
    
    func performSegue(identifier: String) {
        
        if let viewController = presenter?.view as? UIViewController{
            viewController.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
}
