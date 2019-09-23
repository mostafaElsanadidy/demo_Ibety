//
//  AboutApplicationProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

protocol AboutApplicationPresenterToViewProtocol: class {
    
    func displayApplicationDetails(appSettings:ApplicationSettingsData)
}

protocol AboutApplicationInterectorToPresenterProtocol: class {
    
    func displayApplicationDetails(appSettings:ApplicationSettingsData)
}

protocol AboutApplicationPresentorToInterectorProtocol: class {
    var presenter: AboutApplicationInterectorToPresenterProtocol? {get set} ;
    func showDetailsAboutApplication()
    
}

protocol AboutApplicationViewToPresenterProtocol: class {
    var view: AboutApplicationPresenterToViewProtocol? {get set};
    var interector: AboutApplicationPresentorToInterectorProtocol? {get set};
    var router: AboutApplicationPresenterToRouterProtocol? {get set}
    func viewDidLoad();
}

protocol AboutApplicationPresenterToRouterProtocol: class {
    
    var presenter: AboutApplicationViewToPresenterProtocol?{get set}
    static func createModule(viewController:AboutApplicationViewController)
}
