//
//  ProfileRouter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ProfileRouter:ProfilePresenterToRouterProtocol{
    
    var presenter: ProfileViewToPresenterProtocol?
    class func createModule(view: LoginViewController) {
        
        let presenter: ProfileViewToPresenterProtocol & ProfileInterectorToPresenterProtocol = ProfilePresenter();
        
        let interactor: ProfilePresentorToInterectorProtocol = ProfileInterector();
        let router: ProfilePresenterToRouterProtocol = ProfileRouter();
        
        view.presenter = presenter;
        presenter.view = view as! ProfilePresenterToViewProtocol;
        
        presenter.router = router;
        presenter.interector = interactor;
        interactor.presenter = presenter;
        router.presenter = presenter
    }
    
    var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func displayImagePickerController(imagePicker: UIImagePickerController) {
        if let view = presenter?.view as? UIViewController{
            view.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func dismissViewController() {
        if let view = presenter?.view as? UIViewController{
            view.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateTabBarViewController(with index: Int, indexOfPage: Int) {
        
        let viewController = self.mainstoryboard.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
        viewController.indexOfPage = indexOfPage
        tabBarViewController.viewControllers![index] = viewController
        tabBarViewController.viewControllers![index].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = index
    }
}
