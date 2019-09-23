//
//  InfoViewRouter.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class InfoViewRouter: InfoViewPresenterToRouterProtocol {
    
    class func createModule(view: InfoViewController) {
        
        
        let presenter: InfoViewViewToPresenterProtocol & InfoViewInterectorToPresenterProtocol = InfoViewPresenter();
        
        let interactor: InfoViewPresentorToInterectorProtocol = InfoViewInterector();
        let router: InfoViewPresenterToRouterProtocol = InfoViewRouter();
        
        view.presenter = presenter;
        presenter.view = view as! InfoViewPresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
        
    }
    
    var presenter:InfoViewViewToPresenterProtocol?
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func dismissViewController() {
        if let imagePicker = presenter?.view as? UIViewController{
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    func displayImagePickerController(viewCotroller: UIImagePickerController) {
        
        if let imagePicker = presenter?.view as? UIViewController{
            imagePicker.present(viewCotroller, animated: true, completion: nil)}
    }
    
        func instantiateViewController(with identifier: String) -> UIViewController{
            
            return mainstoryboard.instantiateViewController(withIdentifier: identifier)
        }
    
    func cancelUpdate() {
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MyProjectPartsViewController") as! MyProjectPartsViewController
        tabBarViewController.viewControllers![3] = viewController
        tabBarViewController.selectedIndex = 3
        tabBarViewController.viewControllers![3].tabBarItem!.image = UIImage(named: "Group 656")
        tabBarViewController.viewControllers![3].tabBarItem!.selectedImage = UIImage(named: "Group-1")
        tabBarViewController.viewControllers![3].tabBarItem!.title = ""
    }
}
