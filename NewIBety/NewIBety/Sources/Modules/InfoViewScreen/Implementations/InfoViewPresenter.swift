//
//  InfoViewPresenter.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class InfoViewPresenter: NSObject , InfoViewViewToPresenterProtocol {
    
    var isUpdateState:Bool = false
    func createRectangle(with rect: CGRect) {
        // Initialize the path.
        let path = UIBezierPath()
        let size = rect.size
        
        path.move(to: CGPoint(x: 0.0, y: 5.0))
        
        path.addLine(to: CGPoint(x: size.width/2, y: size.height/2))
        path.addLine(to: CGPoint(x: size.width, y: 5.0))
        path.addLine(to: CGPoint(x: size.width, y: size.height+5.0))
        path.addLine(to: CGPoint(x: 0.0, y: size.height+5.0))
        
        view?.displayShadowPath(with: path.cgPath)
        }
    
    
    
    func showProjectImage(with urlStr: String) {
        interector?.showProjectImage(with: urlStr)
    }
    
    
    
    func updateView(isUpdateState: Bool) {
        
        self.isUpdateState = isUpdateState
        if isUpdateState {
            interector?.displayProjectService()
        }
    }
    
    
    func updateViews() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? InfoViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.category_defaultCitiesService()
        if userProject == nil{
            userProject = project_Details()
        }
    }
    
    func showDefault_Cities() {
        interector?.showDefault_CitiesService()
    }
    
    func changeDropDown(with defaultCities: [defaultCity]) {
        view?.changeDropDown(with: defaultCities)
    }
    
    func showCategories() {
        interector?.showCategoriesService()
    }
    
    func moveBttn() {
    
        if let ProjectInfoViewController = self.router?.instantiateViewController(with: "ViewController1"){
            UIView.animate(withDuration: 0){
                
                if let viewController = self.view as? UIViewController{
                   
                    if let  parentViewController = viewController.parent as? ParentViewController{ parentViewController.presenter?.addChildViewController(childViewController: ProjectInfoViewController)
                    parentViewController.presenter?.selectedIndex += 1
                        parentViewController.presenter?.updateButtons2(mainBttns: [parentViewController.infoBttn, parentViewController.productsBttn, parentViewController.proDataBttn], selectedIndex: 1)}
                }
            }
        }
    }
    
    
    var interector: InfoViewPresentorToInterectorProtocol?
    var router: InfoViewPresenterToRouterProtocol?
    var view: InfoViewPresenterToViewProtocol?
    
    func cancelUpdate() {
        router?.cancelUpdate()
    }
    
    func updateProject() {
        interector?.updateProject()
    }
    
}

extension InfoViewPresenter:InfoViewInterectorToPresenterProtocol{
    
    func displayImage(wit data: Data) {
        view?.displayImage(wit: data)
    }
    
    func showNetworkError(with text: String) {
        view?.showNetworkError(with: text)
    }
    
    func finishUpdate() {
        view?.showSuccessUpdateAlert()
    }
    
    func change_DropDown(with defaultCities: [categoriesData]) {
        view?.change_DropDown(with: defaultCities)
    }
    
    func showProjectDetails(with displayedProject: projectCreationDetails) {
        view?.showProjectDetails(with: displayedProject)
    }
}

extension InfoViewPresenter:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        router?.displayImagePickerController(viewCotroller: imagePicker)
        
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
        router?.displayImagePickerController(viewCotroller: imagePicker)}
    
    func show(image: UIImage) {
        
        userProject.projectImage = (image.pngData()?.base64EncodedString())!
        // print(image.pngData()?.base64EncodedString())
        if isUpdateState{
            // projectInfo.projectImageStr = image.pngData()?.base64EncodedString()
            //   print(projectInfo.projectImageStr)
            dicOfUpdateProject["image"] = (image.pngData()?.base64EncodedString())!
            print(dicOfUpdateProject["image"])
        }
        view?.showImageView(with: image)
    }
    
    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            view?.showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    

}
