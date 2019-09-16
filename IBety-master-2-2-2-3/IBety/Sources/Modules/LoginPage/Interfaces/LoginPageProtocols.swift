//
//  LoginPageProtocols.swift
//  IBety
//
//  Created by 68lion on 8/31/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol LoginPagePresenterToViewProtocol: class {
    
    func show_Error(errorMessageText:String);
}

protocol LoginPageInterectorToPresenterProtocol: class {
    
    func presentIndexInTabBarController(index:Int)
    func insertViewController(controllerName:String , index:Int)
    func insertMyDetailsViewController(controllerName:String , index:Int, indexOfPage:Int)
    func insertThirdViewController(controllerName:String , index:Int , indexOfPage:Int)
    func show_Error(errorMessageText:String);
    func performSegue(identifier:String)
}

protocol LoginPagePresentorToInterectorProtocol: class {
    var presenter: LoginPageInterectorToPresenterProtocol? {get set} ;
    func loginService(userName:String , password:String);
}

protocol LoginPageViewToPresenterProtocol: class {
    var loginView: LoginPagePresenterToViewProtocol? {get set};
    var interector: LoginPagePresentorToInterectorProtocol? {get set};
    var router: LoginPagePresenterToRouterProtocol? {get set}
    func updateView();
//    func passDataToAnotherView(segue:UIStoryboardSegue)
    func login(userName:String , password:String)
    func dissmissViewController()
    func passDataToAnotherView(segue: UIStoryboardSegue)
}

protocol LoginPagePresenterToRouterProtocol: class {
    
    var presenter: LoginPageViewToPresenterProtocol? {get set}
    static func createModule(viewController:Login1ViewController);
    func dissmissViewController()
    func performSegue(identifier:String)
//    func passDataToAnotherView(segue:UIStoryboardSegue)
    
    func passDataToAnotherView(segue: UIStoryboardSegue)
    func insertMyDetailsViewController(controllerName:String , index:Int, indexOfPage:Int)
    func insertThirdViewControllerInTabBar(controllerName:String , in index:Int , indexOfPage:Int)
    func insertViewControllerInTabBar(controllerName:String , in index:Int)
    func presentIndexInTabBarController(index:Int)
    
  //  func pass_DataToSomeView(segue:UIStoryboardSegue)
}
