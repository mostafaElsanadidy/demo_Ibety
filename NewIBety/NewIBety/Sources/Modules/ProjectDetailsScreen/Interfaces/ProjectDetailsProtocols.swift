//
//  ProjectDetailsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

protocol ProjectDetailsPresenterToViewProtocol: class {
    
    func updateView(with displayedProjectDetails:projectCreationData);
    func updateProjectImage(with data:Data)
}

protocol ProjectDetailsInterectorToPresenterProtocol: class {
    
    func updateView(with displayedProjectDetails:projectCreationData);
    func updateProjectImage(with data:Data)
}

protocol ProjectDetailsPresentorToInterectorProtocol: class {
    var presenter: ProjectDetailsInterectorToPresenterProtocol? {get set} ;
    func displayProjectImage(with urlStr:String)
    func displayProjectDetails()
}

protocol ProjectDetailsViewToPresenterProtocol: class {
    var view: ProjectDetailsPresenterToViewProtocol? {get set};
    var interector: ProjectDetailsPresentorToInterectorProtocol? {get set};
    var router: ProjectDetailsPresenterToRouterProtocol? {get set}
    func displayProjectImage(with urlStr:String)
    func adjustUITextViewHeight(arg : UITextView,by views : [UIView])
    func viewWillAppear()
}

protocol ProjectDetailsPresenterToRouterProtocol: class {
    var presenter : ProjectDetailsViewToPresenterProtocol? {get set}
    static func createModule(view:ProjectDetailsViewController);
}
