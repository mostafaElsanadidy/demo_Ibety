//
//  AboutApplicationRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class AboutApplicationRouter: AboutApplicationPresenterToRouterProtocol {
    
    var presenter: AboutApplicationViewToPresenterProtocol?
    
    class func createModule(viewController: AboutApplicationViewController) {
        
        let presenter: AboutApplicationViewToPresenterProtocol & AboutApplicationInterectorToPresenterProtocol = AboutApplicationPresenter();
        
        let interactor: AboutApplicationPresentorToInterectorProtocol = AboutApplicationInterector();
        let router: AboutApplicationPresenterToRouterProtocol = AboutApplicationRouter();
        
        viewController.presenter = presenter;
        presenter.view = viewController;
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
}
