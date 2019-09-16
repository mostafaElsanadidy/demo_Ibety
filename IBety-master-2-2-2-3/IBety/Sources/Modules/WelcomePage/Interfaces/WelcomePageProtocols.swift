//
//  WelcomePageProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

protocol WelcomePresenterToViewProtocol: class {
 
}

protocol WelcomeInterectorToPresenterProtocol: class {
    
    func updateTabBarViewController(using index:Int , indexOfPage:Int)
}

protocol WelcomePresentorToInterectorProtocol: class {
    var presenter: WelcomeInterectorToPresenterProtocol? {get set} ;
    func updateOwnerUserDefaults()
    func isBeforeLogin()
}

protocol WelcomeViewToPresenterProtocol: class {
    var view: WelcomeViewController? {get set};
    var interector: WelcomePresentorToInterectorProtocol? {get set};
    var router: WelcomePresenterToRouterProtocol? {get set}
    
    func updateViews()
    func logout();
    func skipWelcomePage()
}

protocol WelcomePresenterToRouterProtocol: class {
    
    var presenter:WelcomeViewToPresenterProtocol?{get set}
    static func createModule(view:WelcomeViewController);
    func moveToFirstViewController()
    func updateTabBarViewController(using index:Int , indexOfPage:Int)
}
