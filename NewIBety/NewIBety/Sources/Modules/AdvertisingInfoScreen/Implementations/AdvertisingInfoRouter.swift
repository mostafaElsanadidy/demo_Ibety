//
//  AdvertisingInfoRouter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class AdvertisingInfoRouter: AdvertisingInfoPresenterToRouterProtocol {
    
    
   var presenter: AdvertisingInfoViewToPresenterProtocol?
    class func createModule(view: AdvertisingInfoViewController) {
    
        let presenter: AdvertisingInfoViewToPresenterProtocol & AdvertisingInfoInterectorToPresenterProtocol & AdvertisingInfoViewToPresenterProtocol = AdvertisingInfoPresenter();
        
        let interactor: AdvertisingInfoPresentorToInterectorProtocol = AdvertisingInfoInterector();
        let router: AdvertisingInfoPresenterToRouterProtocol = AdvertisingInfoRouter();
        
        view.presenter = presenter;
        presenter.view = view as! AdvertisingInfoPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
}
