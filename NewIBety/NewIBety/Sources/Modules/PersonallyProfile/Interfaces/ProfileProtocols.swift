//
//  ProfileProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol ProfilePresenterToViewProtocol: class {
    
    func updateViews(with userData:User_ProfileData)
    func displayUserImage(with data:Data)
    func showError(with text:String)
    func showUpdateAlert()
    func showPhotoMenu()
    func showImage(image:UIImage)
}

protocol ProfileInterectorToPresenterProtocol: class {
    
    func receiveProfileDetails(data:User_ProfileData)
    func receiveUserImage(data:Data)
    func updateTabBarViewController(with index:Int, indexOfPage:Int)
    func showError(with text:String)
    func showUpdateAlert()
}

protocol ProfilePresentorToInterectorProtocol: class {
    var presenter: ProfileInterectorToPresenterProtocol? {get set} ;
    func displayProfileService()
    func displayUserImage(with urlStr:String)
    func isBeforeLogin()
    func saveData(with profileUpdateObj:ProfileUpdateObj)
}

protocol ProfileViewToPresenterProtocol: class {
    var view: ProfilePresenterToViewProtocol? {get set};
    var interector: ProfilePresentorToInterectorProtocol? {get set};
    var router: ProfilePresenterToRouterProtocol? {get set}
    func pickPhoto()
    func updateView();
    func updateUserImage(with urlStr:String)
    func cancelPage()
    func saveData(userName:String , password:String , configPassword:String)
    func takePhotoWithCamera()
    func choosePhotoFromLibrary()
}

protocol ProfilePresenterToRouterProtocol: class {
    var presenter: ProfileViewToPresenterProtocol?{get set}
    static func createModule(view:LoginViewController);
    func updateTabBarViewController(with index:Int, indexOfPage:Int)
    func displayImagePickerController(imagePicker: UIImagePickerController)
    func dismissViewController()
}
