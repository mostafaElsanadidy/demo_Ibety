//
//  MyDetailsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

protocol MyDetailsPresenterToViewProtocol: class {
    
    func showNetworkError(witth text : String)
    func updateMainView(with shadowPath:CAShapeLayer)
}

protocol MyDetailsInterectorToPresenterProtocol: class {
    
    func performSegue(withIdentifier: String)
    func moveToProjectPartsPage()
    func showNetworkError(witth text : String)
    func updateTabBarViewController(with index:Int)
    func instantiateViewController(withIdentifier: String)
}

protocol MyDetailsPresentorToInterectorProtocol: class {
    var presenter: MyDetailsInterectorToPresenterProtocol? {get set} ;
    func displayApplicationSettings()
    func updateOwnerUserDefaults()
    func updatePageName_UserDefault(with value:String)
    func displayMyProject()
    func displayProfilePersonly()
    func isBeforeLogin()
}

protocol MyDetailsViewToPresenterProtocol: class {
    var view: MyDetailsPresenterToViewProtocol? {get set};
    var interector: MyDetailsPresentorToInterectorProtocol? {get set};
    var router: MyDetailsPresenterToRouterProtocol? {get set}
    
    func logout();
    func cancelPage()
    func displayApplicationSettings()
    func drawPathLine(by frames: [CGRect])
    func moveToMyProject()
    func moveToProfilePersonly()
    func updatePageName_UserDefault(with value:String)
    func moveToPage(indexOfPage:Int)
}

protocol MyDetailsPresenterToRouterProtocol: class {
    
    var presenter:MyDetailsViewToPresenterProtocol?{get set}
    static func createModule(view:MyDetailsViewController);
    func moveToFirstViewController()
    func performSegue(withIdentifier: String)
    func moveToProjectPartsPage()
    func instantiateViewController(withIdentifier: String)
    func updateTabBarViewController(with index:Int , indexOpage:Int)
    }
