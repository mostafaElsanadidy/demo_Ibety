//
//  AdvertisingInfoProtocols.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol AdvertisingInfoPresenterToViewProtocol: class {
    
    func changeViews(with applicationSettings : ApplicationSettings)
    func changeShadowPath(with path:CGPath)
}

protocol AdvertisingInfoInterectorToPresenterProtocol: class {
    
    func changeViews(with applicationSettings : ApplicationSettings)
}

protocol AdvertisingInfoPresentorToInterectorProtocol: class {
    var presenter: AdvertisingInfoInterectorToPresenterProtocol? {get set} ;
    
    func displayApplicationSettings()
}

protocol AdvertisingInfoViewToPresenterProtocol: class {
    var view: AdvertisingInfoPresenterToViewProtocol? {get set};
    var interector: AdvertisingInfoPresentorToInterectorProtocol? {get set};
    var router: AdvertisingInfoPresenterToRouterProtocol? {get set}
    
    func updateView()
    func createRectangle(with rect:CGRect)
}

protocol AdvertisingInfoPresenterToRouterProtocol: class {
    var presenter:AdvertisingInfoViewToPresenterProtocol?{get set}
    static func createModule(view:AdvertisingInfoViewController);
}
