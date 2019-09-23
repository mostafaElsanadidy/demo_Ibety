//
//  SearchProjectsRouter.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class SearchProjectsRouter: SearchPresenterToRouterProtocol{
    
    var presenter: SearchViewToPresenterProtocol?
    
    class func createModule(view: SearchProjectsViewController) {
        
        let presenter: SearchViewToPresenterProtocol & SearchInterectorToPresenterProtocol = SearchProjectsPresenter()
        ;
        
        let interactor: SearchPresentorToInterectorProtocol = SearchProjectsInterector();
        let router: SearchPresenterToRouterProtocol = SearchProjectsRouter();
        
        view.presenter = presenter;
        
        presenter.view = view as! SearchPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    
    func performSegue(identifier: String) {
        
        if let view = presenter?.view as? UIViewController{
            
            view.performSegue(withIdentifier: identifier, sender: nil)
        }
    }
    
    func popViewController() {
        if let viewController = presenter?.view as? UIViewController{
            viewController.navigationController?.popViewController(animated: true)
        }
    }
}
