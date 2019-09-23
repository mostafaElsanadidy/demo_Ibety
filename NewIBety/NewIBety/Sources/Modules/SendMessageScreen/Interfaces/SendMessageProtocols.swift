//
//  SendMessageProtocols.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol SendMessagePresenterToViewProtocol: class {
    
    func showNetworkError(with text:String)
    func showAlertForSendingFeedback()
    func changeShadowPath(with path:CGPath)
}

protocol SendMessageInterectorToPresenterProtocol: class {
    
    func showNetworkError(with text:String)
    func showAlertForSendingFeedback()
    func insertMyDetailsViewController(controllerName:String , index:Int, indexOfPage:Int)
}

protocol SendMessagePresentorToInterectorProtocol: class {
    var presenter: SendMessageInterectorToPresenterProtocol? {get set} ;
    func sendFeebackMessage(with name:String , email:String , message:String)
    func findLoginResult()
}

protocol SendMessageViewToPresenterProtocol: class {
    var view: SendMessagePresenterToViewProtocol? {get set};
    var interector: SendMessagePresentorToInterectorProtocol? {get set};
    var router: SendMessagePresenterToRouterProtocol? {get set}
    
    func sendFeebackMessage(with name:String , email:String , message:String)
    func updateTabBarController()
    func updateViews()
    func createRectangle(with rect:CGRect)
}

protocol SendMessagePresenterToRouterProtocol: class {
    
    var presenter:SendMessageViewToPresenterProtocol? {get set};
    static func createModule(view:SendMessageViewController);
    func insertMyDetailsViewController(controllerName:String , index:Int, indexOfPage:Int)
}

