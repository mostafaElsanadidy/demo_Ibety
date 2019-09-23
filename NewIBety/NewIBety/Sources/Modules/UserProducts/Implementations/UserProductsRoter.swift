//
//  UserProductsRoter.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class UserProductsRouter:UserProductsPresenterToRouterProtocol{
    
    var presenter: UserProductsViewToPresenterProtocol?
    class func createModule(view: UserProductsViewController) {
        
        let presenter: UserProductsViewToPresenterProtocol & UserProductsInterectorToPresenterProtocol & UserProductsViewToPresenterProtocol = UserProductsPresenter()
        ;
        
        let interactor: UserProductsPresentorToInterectorProtocol = UserProductsInterector();
        let router: UserProductsPresenterToRouterProtocol = UserProductsRouter();
        
        view.presenter = presenter;
        
        presenter.view = view as! UserProductsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
  
    
    
}
