//
//  MyProjectPartsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol MyProjectPartsPresenterToViewProtocol: class {
    
    func changeTitleView(with title:String)
    func hideViews()
    func showNetworkError(with text:String)
}

protocol MyProjectPartsInterectorToPresenterProtocol: class {
    
    func hideViews()
    func changeTitleView(with title:String)
    func showNetworkError(with text:String)
}

protocol MyProjectPartsPresentorToInterectorProtocol: class {
    var presenter: MyProjectPartsInterectorToPresenterProtocol? {get set} ;
    func updateView()
}

protocol MyProjectPartsViewToPresenterProtocol: class {
    var view: MyProjectPartsPresenterToViewProtocol? {get set};
    var interector: MyProjectPartsPresentorToInterectorProtocol? {get set};
    var router: MyProjectPartsPresenterToRouterProtocol? {get set}
    func updateView();
    func moveBttnToPage(num:Int)
}

protocol MyProjectPartsPresenterToRouterProtocol: class {
    
    var presenter:MyProjectPartsViewToPresenterProtocol?{get set}
    static func createModule(view:MyProjectPartsViewController);
    func moveBttnToPage(num:Int)
}


