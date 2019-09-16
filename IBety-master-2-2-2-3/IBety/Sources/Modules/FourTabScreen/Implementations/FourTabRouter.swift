//
//  FourTabRouter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//
import UIKit
import Foundation

class FourTabRouter: FourTabPresenterToRouterProtocol {
    var presenter: FourTabViewToPresenterProtocol?
   
    static func createModule(view: FourTabViewController) {

        let presenter:FourTabViewToPresenterProtocol & FourTabInterectorToPresenterProtocol = FourTabPresenter();
        
        let interactor: FourTabPresentorToInterectorProtocol = FourTabInterector();
        let router: FourTabPresenterToRouterProtocol = FourTabRouter();
        
        view.presenter = presenter;
        presenter.view = view as! FourTabPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
   
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func moveBttnToPage(index: Int) {
        if index == 1{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "ViewController0_1") as! InfoViewController
            viewController.isUpdateState = true
            addChildViewController(childViewController: viewController)}
        
        else if index == 2{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MyProductViewController2") as! MyProductViewController
            viewController.isVertical = false
            viewController.isUpdateState = true
            addChildViewController(childViewController: viewController)
        }
        if index == 3{
            
            let viewController = mainstoryboard.instantiateViewController(withIdentifier: "ViewController2_1") as! ProjectDataViewController
            viewController.isUpdateState = true
            addChildViewController(childViewController: viewController)
        }
        
        }
    
    
    func addChildViewController(childViewController: UIViewController){
        if let parentController = presenter?.view as? FourTabViewController{
            childViewController.willMove(toParent: parentController)
            
            // Add to containerview
            parentController.demoView.addSubview(childViewController.view)
            parentController.addChild(childViewController)
            childViewController.view.frame = parentController.demoView.frame
            childViewController.didMove(toParent: parentController)}
    }
    
    func cancelPage() {
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "MyProjectPartsViewController") as! MyProjectPartsViewController
        
        
        tabBarViewController.viewControllers![3] = viewController
        tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = 3
    }
    
}



