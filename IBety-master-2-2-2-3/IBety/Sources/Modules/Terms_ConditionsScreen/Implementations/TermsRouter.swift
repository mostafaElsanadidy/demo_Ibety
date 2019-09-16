//
//  TermsRouter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class Terms_ConditionsRouter: Terms_ConditionsPresenterToRouterProtocol {
    
    var presenter: Terms_ConditionsViewToPresenterProtocol?
    
    
    class func createModule(view: Terms_ConditionsViewController) {
    
        let presenter: Terms_ConditionsViewToPresenterProtocol = Terms_ConditionsPresenter();
        let router: Terms_ConditionsPresenterToRouterProtocol = Terms_ConditionsRouter();
        
        view.presenter = presenter;
        presenter.view = view;
        presenter.router = router;
        router.presenter = presenter
    }
    
    
    func dismissViewController() {
        
        
            presenter!.view!.dismiss(animated: true, completion: nil)
        
    }
    
    
}
