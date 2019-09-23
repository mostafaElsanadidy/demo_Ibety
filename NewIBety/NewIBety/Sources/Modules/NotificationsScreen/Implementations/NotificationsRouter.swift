//
//  NotificationsRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class NotificationsRouter:NotificationsPresenterToRouterProtocol{
    
    var presenter: NotificationsViewToPresenterProtocol?
    
    class func createModule(view: NotificationTableViewController) {
     
        let presenter: NotificationsViewToPresenterProtocol & NotificationsInterectorToPresenterProtocol = NotificationsPresenter();
        
        let interactor: NotificationsPresentorToInterectorProtocol = NotificationsInterector();
        let router: NotificationsPresenterToRouterProtocol = NotificationsRouter();
        
        view.presenter = presenter;
        presenter.view = view as! NotificationsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
}
