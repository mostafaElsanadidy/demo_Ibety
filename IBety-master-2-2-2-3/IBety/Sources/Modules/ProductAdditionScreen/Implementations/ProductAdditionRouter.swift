//
//  ProductAdditionRouter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ProductAdditionRouter: ProductAdditionPresenterToRouterProtocol {
    var presenter: ProductAdditionViewToPresenterProtocol?
    
    func dismissViewController() {
        
        if let view = presenter?.view as? UIViewController{
            view.dismiss(animated: true, completion: nil)
        }
    }
    
    class func createModule(view: ProductAdditionViewController) {
        
        let presenter: ProductAdditionViewToPresenterProtocol & ProductAdditionInterectorToPresenterProtocol = ProductAdditionPresenter();
        
        let interactor: ProductAdditionPresentorToInterectorProtocol = ProductAdditionInterector();
        let router: ProductAdditionPresenterToRouterProtocol = ProductAdditionRouter();
        
        view.presenter = presenter;
        presenter.view = view as! ProductAdditionPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
}
