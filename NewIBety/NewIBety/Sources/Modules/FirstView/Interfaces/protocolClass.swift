//
//  protocolClass.swift
//  IBety
//
//  Created by Mohamed on 8/29/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import FacebookLogin
import UIKit

protocol PresenterToViewProtocol: class {
//    func showNews(news: LiveNewsModel);
  //  func showError();
   // func showUserDefaultsData(key:String);
    func receiveIndexOfMyDetailsPage(index:Int)
    func showViewsWithShapeLayer(shapeLayer:CAShapeLayer)
}

protocol InterectorToPresenterProtocol: class {
   // func updateTabBar(controllerName:String , index:Int)
    func updateTabBarViewController(with index:Int, indexOfPage:Int)
}


protocol PresentorToInterectorProtocol: class {
    var presenter: InterectorToPresenterProtocol? {get set};
    
    func loginWithFacebook(with token:AccessToken)
    func isBeforeLogin();
    func insertUserDefaults(value:Any , key:String)
    func findUserDefaults(forKey key: String) -> Any
}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set};
    var interector: PresentorToInterectorProtocol? {get set};
    var router: PresenterToRouterProtocol? {get set}
    
    func updateView();
    func loginWithFacebook()
    func updateUserDefaults(value:Any , key:String , byKey:String);
    func updateIfEnterBackground()
    func showLanguageScreen(in index:Int)
    func completeAsVisitor(index:Int)
    func initiate_PresentViewController(controllerName:String)
    func drawPathLine(by frame:CGRect, mainFrame:CGRect)
    func presentIndexInTabBarController(index:Int)
    
}


protocol PresenterToRouterProtocol: class {
    
    var presenter: ViewToPresenterProtocol? {get set};
    
    static func createModule(viewController:FirstViewController);
    func updateTabBarViewController(with index:Int, indexOfPage:Int)
    func initiate_PresentViewController(controllerName:String)
    func insertThirdViewControllerInTabBar(controllerName:String , in index:Int , indexOfPage:Int)
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int)
    func presentIndexInTabBarController(index:Int)
    
}

