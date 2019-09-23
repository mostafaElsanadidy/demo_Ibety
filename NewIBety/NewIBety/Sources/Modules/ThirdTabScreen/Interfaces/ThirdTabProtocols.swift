//
//  ThirdTabProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol ThirdTabPresenterToViewProtocol: class {
    
}

protocol ThirdTabInterectorToPresenterProtocol: class {
    
    func insertMyDetailsViewController(index:Int, indexOfPage:Int)
}

protocol ThirdTabPresentorToInterectorProtocol: class {
    var presenter: ThirdTabInterectorToPresenterProtocol? {get set} ;
    func isBeforeLogin()
}

protocol ThirdTabViewToPresenterProtocol: class {
    var view: ThirdTabViewController? {get set};
    var interector: ThirdTabPresentorToInterectorProtocol? {get set};
    var router: ThirdTabPresenterToRouterProtocol? {get set}
    
    func viewDidLoad(with indexOfPage:Int)
    func cancelPage()
}

protocol ThirdTabPresenterToRouterProtocol: class {
    
    var presenter:ThirdTabViewToPresenterProtocol?{get set}
    static func createModule(view:ThirdTabViewController);
    func addChildController(indexOfPage:Int)
    func insertMyDetailsViewController(controllerName:String , index:Int , indexOfPage:Int)
    func dismissViewController()
}
