//
//  ProductViewRouter.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ProductViewRouter: ProductViewPresenterToRouterProtocol {
    
    
    var presenter: ProductViewViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static func createModule(view: ProductViewController) {
        
        
        let presenter: ProductViewViewToPresenterProtocol = ProductViewPresenter();
        
        let interactor: ProductViewPresentorToInterectorProtocol = ProductViewInterector();
        let router: ProductViewPresenterToRouterProtocol = ProductViewRouter();
        
        view.presenter = presenter;
        presenter.view = view as! ProductViewPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
      //  interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    func instantiateViewController(with identifier: String) -> UIViewController {
        
        return mainstoryboard.instantiateViewController(withIdentifier: identifier)
    }
}
