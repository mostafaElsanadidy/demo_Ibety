//
//  CommunicateDetailsRouter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class CommunicateDetailsRouter:CommunicateDetailsPresenterToRouterProtocol{
    
   var presenter: CommunicateDetailsViewToPresenterProtocol?
    class func createModule(view: CommunicateDetailsViewController) {
        
        let presenter: CommunicateDetailsViewToPresenterProtocol & CommunicateDetailsInterectorToPresenterProtocol = CommunicateDetailsPresenter();
        
        let interactor: CommunicateDetailsPresentorToInterectorProtocol = CommunicateDetailsInterector();
        let router: CommunicateDetailsPresenterToRouterProtocol = CommunicateDetailsRouter();
        
        
        presenter.view = view as! CommunicateDetailsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        view.presenter = presenter
    }
}
