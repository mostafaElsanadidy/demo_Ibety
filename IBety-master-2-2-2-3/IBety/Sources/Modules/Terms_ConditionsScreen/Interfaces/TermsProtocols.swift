//
//  TermsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

protocol Terms_ConditionsViewToPresenterProtocol: class {
   
    var delegate:Terms_ConditionsViewControllerDelegate? {get set}
    var router:Terms_ConditionsPresenterToRouterProtocol? {get set}
    var view:Terms_ConditionsViewController? { get set }
    func updateViews()
    func isAgreeBttnClicked();
    func dismissViewController()
}

protocol Terms_ConditionsPresenterToRouterProtocol: class {
    
    var presenter:Terms_ConditionsViewToPresenterProtocol?{get set}
    func dismissViewController()
    static func createModule(view:Terms_ConditionsViewController);
}

protocol Terms_ConditionsViewControllerDelegate : class{
    func isAgreeONTerms_Conditions(_ Terms_ConditionsPresenter:Terms_ConditionsViewToPresenterProtocol , isAgree:Bool)
}
