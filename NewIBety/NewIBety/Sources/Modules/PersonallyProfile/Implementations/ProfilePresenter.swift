//
//  ProfilePresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class ProfilePresenter: NSObject,ProfileViewToPresenterProtocol {
    
    var interector: ProfilePresentorToInterectorProtocol?
    var router: ProfilePresenterToRouterProtocol?
    var view: ProfilePresenterToViewProtocol?
    var profileUpdateObj=ProfileUpdateObj()
    
    func updateView() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? LoginViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayProfileService()
    }
    
    func updateUserImage(with urlStr: String) {
        interector?.displayUserImage(with: urlStr)
    }
    
    func cancelPage() {
        interector?.isBeforeLogin()
    }
    
    func saveData(userName: String, password: String, configPassword: String) {
        
        profileUpdateObj.name = userName
        profileUpdateObj.password = password
        profileUpdateObj.password_confirmation = configPassword
        
        interector?.saveData(with: profileUpdateObj)
    }
}

extension ProfilePresenter:ProfileInterectorToPresenterProtocol{
    
    func receiveProfileDetails(data: User_ProfileData) {
        view?.updateViews(with: data)
    }
    
    func receiveUserImage(data: Data) {
        view?.displayUserImage(with: data)
    }
    
    func updateTabBarViewController(with index: Int, indexOfPage: Int) {
        router?.updateTabBarViewController(with: index, indexOfPage: indexOfPage)
    }
    
    func showError(with text: String) {
        view?.showError(with: text)
    }
    
    func showUpdateAlert() {
        view?.showUpdateAlert()
    }
}

extension ProfilePresenter:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        router?.displayImagePickerController(imagePicker: imagePicker)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
        {print(" yooo ooo ")
            show(image: image)
        }
        router?.dismissViewController()
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        router?.dismissViewController()
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        router?.displayImagePickerController(imagePicker: imagePicker)}
    
    func show(image: UIImage) {
        profileUpdateObj.avatar = (image.pngData()?.base64EncodedString())!
        view?.showImage(image: image)
    }
    
    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            view?.showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    
}
