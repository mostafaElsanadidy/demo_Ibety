//
//  MyProductsRouter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class MyProductsRouter: MyProductsPresenterToRouterProtocol {
    var presenter: MyProductsViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
    class func createModule(view: MyProductViewController) {
        
        let presenter: MyProductsViewToPresenterProtocol & MyProductsInterectorToPresenterProtocol = MyProductsPresenter();
        
        let interactor: MyProductsPresentorToInterectorProtocol = nameMyProductsInterector();
        let router: MyProductsPresenterToRouterProtocol = MyProductsRouter();
        
        view.presenter = presenter;
        presenter.view = view as! MyProductsPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    func performSegue(withIdentifier: String) {
        
        if let view = presenter?.view as? UIViewController{
            view.performSegue(withIdentifier: withIdentifier, sender: nil)
        }
    }
    
    func prepareForSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "editProduct"{
            let viewController = segue.destination as! ProductAdditionViewController
            
            let selectIndex = presenter?.selectedIndexOfCell!
            viewController.indexOfSelectedProduct = presenter?.displayedProductsDetails![selectIndex!].id!
            viewController.isUpdateState = true
            
        }
        if segue.identifier == "AddProductSegue"{
            
            let viewController = segue.destination as! ProductAdditionViewController
            viewController.isUpdateState = false
        }
    }
    
    
    func cancelPage() {
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "MyProjectPartsViewController") as! MyProjectPartsViewController
        
        tabBarViewController.viewControllers![3] = viewController
        tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = 3
    }
    
}
