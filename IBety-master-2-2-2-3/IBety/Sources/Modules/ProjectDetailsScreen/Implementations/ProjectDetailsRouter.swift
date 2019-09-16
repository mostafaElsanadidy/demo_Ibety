//
//  ProjectDetailsRouter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class ProjectDetailsPresenterRouter: ProjectDetailsPresenterToRouterProtocol {
    
   var presenter: ProjectDetailsViewToPresenterProtocol?
    static func createModule(view: ProjectDetailsViewController) {
        
        let presenter: ProjectDetailsViewToPresenterProtocol & ProjectDetailsInterectorToPresenterProtocol & ProjectDetailsViewToPresenterProtocol = ProjectDetailsPresenter();
        
        let interactor: ProjectDetailsPresentorToInterectorProtocol = ProjectDetailsInterector();
        let router: ProjectDetailsPresenterToRouterProtocol = ProjectDetailsPresenterRouter();
        
        view.presenter = presenter;
        presenter.view = view as! ProjectDetailsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
}
