//
//  LanguageProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol LanguagePresenterToViewProtocol: class {
    
}

protocol LanguageInterectorToPresenterProtocol: class {
    
    func insertMyDetailsViewController(index:Int, indexOfPage:Int)
}

protocol LanguagePresentorToInterectorProtocol: class {
    var presenter: LanguageInterectorToPresenterProtocol? {get set} ;
    func isBeforeLogin()
    
}

protocol LanguageViewToPresenterProtocol: class {
    var view: LanguageViewController? {get set};
    var interector: LanguagePresentorToInterectorProtocol? {get set};
    var router: LanguagePresenterToRouterProtocol? {get set}
    
    func setArabicLanguage()
    func setEnglishLanguage()
    func changeWindow()
    func viewDidLoad()
    func cancelPage()
}

protocol LanguagePresenterToRouterProtocol: class {
    
    var presenter:LanguageViewToPresenterProtocol?{get set}
    static func createModule(view:LanguageViewController);
    func returnToFirst()
    func insertMyDetailsViewController(controllerName:String , index:Int , indexOfPage:Int)
    // func dismissViewController()
}
