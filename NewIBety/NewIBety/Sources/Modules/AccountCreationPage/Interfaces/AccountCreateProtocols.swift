//
//  AccountCreateProtocols.swift
//  IBety
//
//  Created by 68lion on 8/30/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit
import DropDown

protocol AccountCreate_PresenterToViewProtocol: class {
    func showError(errorMessageText:String);
    func updateDropDownData(with cities:[defaultCity])
    func presentAccountCreateAlert(type:String)
    func updateCheckBttn(isOn:Bool)
}

protocol AccountCreate_InterectorToPresenterProtocol: class {
   // func liveNewsFetchedFailed();
    func showError(errorMessageText:String);
    func updateDropDownData(with cities:[defaultCity])
    func finishAccountCreate(type:String)
}

protocol AccountCreate_PresentorToInterectorProtocol: class {
    var presenter: AccountCreate_InterectorToPresenterProtocol? {get set} ;
    func default_CitiesService();
    func insertUserDefaults(value:Any , key:String)
    func createAccountService(n: String, e: String, m: String, c: Int, p: String, t: String)
}

protocol AccountCreate_ViewToPresenterProtocol: class {
    var accountView: AccountCreate_PresenterToViewProtocol? {get set};
    var accountInterector: AccountCreate_PresentorToInterectorProtocol? {get set};
    var accountRouter: AccountCreate_PresenterToRouterProtocol? {get set}
    
    func updateCitiesBttn()
    func hideKeyboardWhenTappedAround()
    func dissmissViewController()
    func createAccount(n: String, e: String, m: String, c: Int, p: String, t: String)
    func passDataToAnotherView(segue: UIStoryboardSegue)
    func updateUserDefaults(value:Any , key:String)
    func performSegue(identifier:String)
}

protocol AccountCreate_PresenterToRouterProtocol: class {
    static func createModule(viewController:AccountCreationViewController);
    var presenter: AccountCreate_ViewToPresenterProtocol? {get set};
    func dissmissViewController()
    func passDataToAnotherView(segue:UIStoryboardSegue)
    func performSegue(identifier:String)
}




