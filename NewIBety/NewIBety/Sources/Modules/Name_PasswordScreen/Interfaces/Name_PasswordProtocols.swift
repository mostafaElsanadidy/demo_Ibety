//
//  Name_PasswordProtocols.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol Name_PasswordPresenterToViewProtocol: class {

    func displayWritePhoneNumAlert()
    func showNetworkError(with errorMessageText:String)
    func showNetworkError()
    func changeTimeLabel(with time:String)
    func updateViews(with selectedIndexOfView:Int)
}

protocol Name_PasswordInterectorToPresenterProtocol: class {
    
    func showNetworkError(with errorMessageText:String)
    
    func takeUserDefaultValue(data:Data)
    func PerformSegue(with identifier:String)
    func insertThirdViewControllerInTabBar(controllerName:String , in index:Int , indexOfPage:Int)
    func insertViewControllerInTabBar(controllerName:String , in index:Int)
    func presentIndexInTabBarController(index:Int)
}

protocol Name_PasswordPresentorToInterectorProtocol: class {
    var presenter: Name_PasswordInterectorToPresenterProtocol? {get set} ;
    
    func findUserDefaultValue(for key:String)
    func forgetPasswordService(with phoneNum:String)
    func checkCode(codeText:String , phoneNum:String)
    func createNewPassword(newPassword:String , configPassword:String)
}

protocol Name_PasswordViewToPresenterProtocol: class {
    var view: Name_PasswordPresenterToViewProtocol? {get set};
    var interector: Name_PasswordPresentorToInterectorProtocol? {get set};
    var router: Name_PasswordPresenterToRouterProtocol? {get set}
    var mainViews:[UIView]? {get set}
    
    func updateViews()
    func updateTime()
    func createTime()
    func receiveView(view:UIView , mainViews:[UIView])
    func updateSendCodeView(with mainView:UIView ,phoneText:String , newPassword:String , configPassword:String);
    func forgetPasswordService()
    func dismissViewController()
}

protocol Name_PasswordPresenterToRouterProtocol: class {
   
    var presenter:Name_PasswordViewToPresenterProtocol? {get set}
    static func createModule(view:Name_PasswordViewController);
    
    func dismissViewController()
    func PerformSegue(with identifier:String)
    func insertThirdViewControllerInTabBar(controllerName:String , in index:Int , indexOfPage:Int)
    func insertViewControllerInTabBar(controllerName:String , in index:Int)
    func presentIndexInTabBarController(index:Int)
}

