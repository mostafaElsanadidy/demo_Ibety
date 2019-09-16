//
//  CommunicationProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

protocol CommunicationPresenterToViewProtocol: class {

    func updateViews(with applicationSettings:ApplicationSettingsData)
    func updateShadowPath(with path:CGPath)
}

protocol CommunicationInterectorToPresenterProtocol: class {
    
    func updateViews(with applicationSettings:ApplicationSettingsData)
    func updateTabBarViewController(with index:Int)
}

protocol CommunicationPresentorToInterectorProtocol: class {
    var presenter: CommunicationInterectorToPresenterProtocol? {get set} ;
    func displayApplicationSettings()
    func isBeforeLogin()
}

protocol CommunicationViewToPresenterProtocol: class {
    var view: CommunicationPresenterToViewProtocol? {get set};
    var interector: CommunicationPresentorToInterectorProtocol? {get set};
    var router: CommunicationPresenterToRouterProtocol? {get set}
    func viewDidLoad();
    func createRectangle(with rect:CGRect)
    func moveToFeedBackPage()
}

protocol CommunicationPresenterToRouterProtocol: class {
    var presenter:CommunicationViewToPresenterProtocol?{get set}
    static func createModule(view:CommunicationViewController);
    func updateTabBarViewController(with index:Int)
}

