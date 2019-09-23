//
//  FourTabProtocols.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol FourTabPresenterToViewProtocol: class {
    
    func displayMyProject(with data:projectCreationData)
}

protocol FourTabInterectorToPresenterProtocol: class {
   
    func displayMyProject(with data:projectCreationData)
}

protocol FourTabPresentorToInterectorProtocol: class {
    var presenter: FourTabInterectorToPresenterProtocol? {get set} ;
    func displayMyProjectService()
}

protocol FourTabViewToPresenterProtocol: class {
    var view: FourTabPresenterToViewProtocol? {get set};
    var interector: FourTabPresentorToInterectorProtocol? {get set};
    var router: FourTabPresenterToRouterProtocol? {get set}
    func viewDidLoad();
    func moveBttnToPage(index:Int)
    func cancelPage()
}

protocol FourTabPresenterToRouterProtocol: class {
    
    var presenter:FourTabViewToPresenterProtocol? {get set}
    static func createModule(view:FourTabViewController);
    func moveBttnToPage(index:Int)
    func cancelPage()
}
