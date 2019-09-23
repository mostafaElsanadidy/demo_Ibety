//
//  ProjectDataRouter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//


import UIKit

class ProjectDataRouter: ProjectDataPresenterToRouterProtocol {
    
    var presenter: ProjectDataViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    class func createModule(view: ProjectDataViewController) {
        
        let presenter: ProjectDataViewToPresenterProtocol & ProjectDataInterectorToPresenterProtocol = ProjectDataPresenter();
        
        let interactor: ProjectDataPresentorToInterectorProtocol = ProjectDataInterector();
        let router: ProjectDataPresenterToRouterProtocol = ProjectDataRouter();
        
        view.prsenter = presenter;
        presenter.view = view as! ProjectDataPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
    
    func institiateViewController(with identifier: String, in index: Int) {
        
        if identifier == "MyProjectPartsViewController"{
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "MyProjectPartsViewController") as! MyProjectPartsViewController
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![3].tabBarItem!.image = UIImage(named: "Group 656")
             tabBarViewController.viewControllers![3].tabBarItem!.title = ""
        tabBarViewController.selectedIndex = index}
        
    }
    
    func performSegue(withIdentifier: String) {
        
        if let view = presenter!.view as? UIViewController{
            view.performSegue(withIdentifier: withIdentifier, sender: nil)
        }
    }
    
}
