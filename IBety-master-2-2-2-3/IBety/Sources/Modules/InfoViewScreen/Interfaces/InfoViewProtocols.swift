//
//  InfoViewProtocols.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol InfoViewPresenterToViewProtocol: class {
    
    func showNetworkError(with text:String)
    func showSuccessUpdateAlert()
    func changeDropDown(with defaultCities:[defaultCity])
    func change_DropDown(with defaultCities:[categoriesData])
    func showProjectDetails(with displayedProject:projectCreationDetails)
    func displayImage(wit data:Data)
    func showImageView(with image:UIImage)
    func displayShadowPath(with path:CGPath)
    func showPhotoMenu()
}

protocol InfoViewInterectorToPresenterProtocol: class {
    
    func finishUpdate()
    func showNetworkError(with text:String)
    func changeDropDown(with defaultCities:[defaultCity])
    func change_DropDown(with defaultCities:[categoriesData])
    func showProjectDetails(with displayedProject:projectCreationDetails)
    func displayImage(wit data:Data)
}

protocol InfoViewPresentorToInterectorProtocol: class {
    var presenter: InfoViewInterectorToPresenterProtocol? {get set} ;
    
    func updateProject()
    func showDefault_CitiesService()
    func showCategoriesService()
    func category_defaultCitiesService()
    func displayProjectService()
    func showProjectImage(with urlStr:String)
}

protocol InfoViewViewToPresenterProtocol: class {
    var view: InfoViewPresenterToViewProtocol? {get set};
    var interector: InfoViewPresentorToInterectorProtocol? {get set};
    var router: InfoViewPresenterToRouterProtocol? {get set}
    
    func cancelUpdate()
    func updateProject()
    func moveBttn()
    func showDefault_Cities()
    func showCategories()
    func updateViews()
    func updateView(isUpdateState:Bool)
    func showProjectImage(with urlStr:String)
    func createRectangle(with rect:CGRect)
    func pickPhoto()
    func takePhotoWithCamera()
    func choosePhotoFromLibrary()
}

protocol InfoViewPresenterToRouterProtocol: class {
    
    var presenter:InfoViewViewToPresenterProtocol? {get set}
    static func createModule(view:InfoViewController);
    func cancelUpdate()
    func instantiateViewController(with identifier:String) -> UIViewController
    func dismissViewController()
    func displayImagePickerController(viewCotroller:UIImagePickerController)
}
