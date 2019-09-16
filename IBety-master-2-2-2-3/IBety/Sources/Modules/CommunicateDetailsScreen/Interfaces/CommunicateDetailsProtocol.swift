//
//  CommunicateDetailsProtocol.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol CommunicateDetailsPresenterToViewProtocol: class {
    
    func updateTitleView(with displayedProjectDetails:projectCreationDetails);
}

protocol CommunicateDetailsInterectorToPresenterProtocol: class {
 
    func updateTitleView(with displayedProjectDetails:projectCreationDetails);
    
}

protocol CommunicateDetailsPresentorToInterectorProtocol: class {
    var presenter: CommunicateDetailsInterectorToPresenterProtocol? {get set} ;
    func displayProjectService()
}

protocol CommunicateDetailsViewToPresenterProtocol: class {
    var view: CommunicateDetailsPresenterToViewProtocol? {get set};
    var interector: CommunicateDetailsPresentorToInterectorProtocol? {get set};
    var router: CommunicateDetailsPresenterToRouterProtocol? {get set}
 
    func viewWillAppear()
}

protocol CommunicateDetailsPresenterToRouterProtocol: class {
    
    var presenter:CommunicateDetailsViewToPresenterProtocol? {get set};
    static func createModule(view:CommunicateDetailsViewController)
}
