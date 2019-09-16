//
//  ProjectDataProtocols.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

protocol ProjectDataPresenterToViewProtocol: class {
    
    func showNetworkError(with text:String)
    func showAlertForProjectCreation()
    func showAlertForProjectUpdate()
    func displayProjectDetails(with displayedProjectDetails:projectCreationDetails)
    func updateProjectAddress(with address:String)
    func showLocationServiceDeniedAlert()
}

protocol ProjectDataInterectorToPresenterProtocol: class {
 
    func showNetworkError(with text:String)
    func showAlertForProjectCreation()
    func showAlertForProjectUpdate()
    func displayProjectDetails(with displayedProjectDetails:projectCreationDetails)
}

protocol ProjectDataPresentorToInterectorProtocol: class {
    var presenter: ProjectDataInterectorToPresenterProtocol? {get set} ;
    func createProjectService()
    func updateProjectService()
    func displayProjectDetails()
}

protocol ProjectDataViewToPresenterProtocol: class {
    var view: ProjectDataPresenterToViewProtocol? {get set};
    var interector: ProjectDataPresentorToInterectorProtocol? {get set};
    var router: ProjectDataPresenterToRouterProtocol? {get set}
 
    func updateViews(isUpdateState:Bool)
    func createProject()
    func updateProject()
    func performSegue(withIdentifier:String)
    func institiateViewController(with identifier:String , in index:Int)
    func findYourLocationCoordinates(isUpdateState:Bool)
}

protocol ProjectDataPresenterToRouterProtocol: class {
    
    var presenter:ProjectDataViewToPresenterProtocol? {get set}
    static func createModule(view:ProjectDataViewController);
    func performSegue(withIdentifier:String)
    func institiateViewController(with identifier:String , in index:Int)
}
