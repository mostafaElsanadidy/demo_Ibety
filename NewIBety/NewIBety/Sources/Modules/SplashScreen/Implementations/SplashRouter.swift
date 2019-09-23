//
//  SplashRouter.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class SplashRouter:SplashPresenterToRouterProtocol{
    
    var presenter: SplashViewToPresenterProtocol?
    
    class func createModule(view: ViewController2) {
        
        let presenter: SplashViewToPresenterProtocol = splashPresenter();
        
        
        let router: SplashPresenterToRouterProtocol = SplashRouter();
        
        view.presenter = presenter;
        presenter.view = view;
        presenter.router = router;
        router.presenter = presenter
    }
}
