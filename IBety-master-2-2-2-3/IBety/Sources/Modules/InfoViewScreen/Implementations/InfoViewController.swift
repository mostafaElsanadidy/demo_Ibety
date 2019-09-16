//
//  InfoViewController.swift
//  IBety
//
//  Created by Mohamed on 6/25/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import DropDown
import Alamofire


class InfoViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var ProjectInfoView: UIView!
 //   @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var PartChooseView: UIView!
   // @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var cancelBttn: UIButton!
    @IBOutlet weak var saveBttn: UIButton!
    @IBOutlet weak var addPhotoLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var projectName: UITextView!
    @IBOutlet weak var city_IDTextField: textField!
    @IBOutlet weak var category_IDTextField: textField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let dropDown = DropDown()
    var default_Cities=[defaultCity](){
        didSet{
            dropDown.anchorView = infoView
            dropDown.dataSource.removeAll()
            
                for countryData in self.default_Cities{
                    dropDown.dataSource.append(countryData.name!.description)
                }
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.city_IDTextField.text = item
                userProject.projectCity_Id = self.default_Cities[index].id!
                if self.isUpdateState{
                    //self.projectInfo.projectCity_ID = cities_ID[index]
                    dicOfUpdateProject["city_id"] = self.default_Cities[index].id!
                }
            }
            dropDown.show()

        }
    }
    
    var categoryResult = [categoriesData](){
        didSet{
            dropDown.anchorView = PartChooseView
            dropDown.dataSource.removeAll()
            
                for countryData in categoryResult{
                    dropDown.dataSource.append(countryData.name!.description)
                }
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.category_IDTextField.text = item
                userProject.projectCategory_Id = self.categoryResult[index].id!
                if self.isUpdateState{
                    //self.projectInfo.projectCategoryID = categories_ID[index]
                    dicOfUpdateProject["category_id"] = self.categoryResult[index].id!
                }
            }
            
            dropDown.show()
        }
    }
    
    var image : UIImage!
    
    var isUpdateState:Bool = false
//    var changedProjectDetail:project_Details!
    var displayedProjectDetails=projectCreationDetails(){
        didSet{
            
            let projectData = self.displayedProjectDetails.data!
            self.projectName.text = projectData.name!
            self.descriptionTextView.text = projectData.description!
            self.city_IDTextField.text = projectData.city!.name!
            self.category_IDTextField.text = projectData.category!.name
            let imageURLStr = projectData.owner!.projects!.data!.media!.image!.conversions!.thumb!
            self.logoImageView.showSpinner(tag: 1000)
            
           presenter?.showProjectImage(with: imageURLStr)
        }
    }
    
    //var projectInfo:project_Info!
  //  var numOfFilledView = 0
    
   // let dicOfBody:[String:String] = [:]
    var presenter:InfoViewViewToPresenterProtocol!
    
    
    @IBAction func cancelUpdate() {
        
       presenter?.cancelUpdate()
     
    }
    
    
    @IBAction func updateProject() {
        
        presenter?.updateProject()

    }

    
    @IBAction func moveBttnAction() {
        
          print("\(String(describing: logoImageView.image?.pngData()?.base64EncodedString()))")
        
        presenter?.moveBttn()
                }
    
    @IBAction func cityBttnClicked() {


        presenter?.showDefault_Cities()
        
            }
    
    @IBAction func categoryBttnClicked() {
    
        presenter?.showCategories()
        
    }
    
    var i = 0
    var j = 0
    var text = ""
    var text1 = ""
    func textViewDidBeginEditing(_ textView: UITextView) {
      
        if textView == projectName{
            if i == 0 {
                text = projectName.text
                print("\(projectName.text!)")
                //            text = textView.text
                if !isUpdateState{
                    projectName.text = ""}
                i = 1
            }
        }
        
        if textView == descriptionTextView{
            if j == 0 {
                text1 = descriptionTextView.text
                print("\(descriptionTextView.text!)")
                //            text = textView.text
                if !isUpdateState{
                    descriptionTextView.text = ""}
                j = 1
            }
        }
        }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count>0{
            if textView.text != text{
                if textView == projectName{
                    userProject.projectName = textView.text!
                    if isUpdateState{
                        //projectInfo.projectName = textView.text!
                        dicOfUpdateProject["name"] = textView.text!
                    }
                }
                
                if textView == descriptionTextView{
                    userProject.projectDescription = textView.text!
                    if isUpdateState{
                      //  projectInfo.projectDescription = textView.text!
                        dicOfUpdateProject["description"] = textView.text!
                    }
                }
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

//        if textView.text.count>0{
//
//        }
        if textView == projectName{
           
           if i == 1 ,  projectName.text.count == 0{
                projectName.text = text
                i = 0
                }}
        if textView == descriptionTextView{
    
            if j == 1 , descriptionTextView.text.count == 0{
                descriptionTextView.text = text1
                j = 0
            }}
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InfoViewRouter.createModule(view: self)
        presenter?.updateViews()
        saveBttn?.layer.cornerRadius = 5
        cancelBttn?.layer.cornerRadius = 5
        dropDown.anchorView = infoView
        dropDown.dataSource = [""]
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        projectName.delegate = self
        descriptionTextView.delegate = self
        logoImageView.isHidden = true
        projectName.text = "project name".localized
        descriptionTextView.text = "Type Product Description".localized
        
       presenter?.updateView(isUpdateState: isUpdateState)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        ProjectInfoView.layer.cornerRadius = 10
        ProjectInfoView.layer.shadowOpacity = 0.2
        ProjectInfoView.layer.shadowRadius = 5
        projectName.layer.cornerRadius = 5
        
        presenter?.createRectangle(with: ProjectInfoView.bounds)
        infoView.layer.cornerRadius = 5
        PartChooseView.layer.cornerRadius = 5
        descriptionTextView.layer.cornerRadius = 5
    }
    
    @IBAction func takePhoto() {
        presenter?.pickPhoto()
    }
    
   
}
    

extension InfoViewController:InfoViewPresenterToViewProtocol{
   
    
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil,
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        let takePhotoAction = UIAlertAction(title: "Take Photo",
                                            style: .default, handler: { _ in self.presenter?.takePhotoWithCamera()})
        alertController.addAction(takePhotoAction)
        let chooseFromLibraryAction = UIAlertAction(title:
            "Choose From Library", style: .default, handler: { _ in self.presenter?.choosePhotoFromLibrary()})
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }
    
  
    
    func showImageView(with image: UIImage) {
        logoImageView.image = image.resized_Image(withBounds: logoImageView.frame.size)
        logoImageView.isHidden = false
        //logoImageView.frame = CGRect(x: 93, y: 52, width: 24, height: 23)
        addPhotoLabel.isHidden = true
    }

    func displayShadowPath(with path: CGPath) {
        ProjectInfoView.layer.shadowPath = path
    }
    
    func showProjectDetails(with displayedProject: projectCreationDetails) {
        self.displayedProjectDetails = displayedProject
    }
    
    func displayImage(wit data: Data) {
        
        self.logoImageView.isHidden = false
        self.addPhotoLabel.isHidden = true
        self.logoImageView.hideSpinner(tag: 1000)
        self.logoImageView.image = UIImage(data: data)
    }
    
    func change_DropDown(with defaultCities: [categoriesData]) {
        self.categoryResult = defaultCities
    }
    
    func changeDropDown(with defaultCities: [defaultCity]) {
        self.default_Cities = defaultCities
    }
    
    
    func showNetworkError(with text: String) {
        
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showSuccessUpdateAlert() {
        
        let alert = UIAlertController(
            title: "Tagged...",
            message:
            "Already you sent Update Project Request successfully \n*** Please wait Response to your request ***.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
           self.presenter?.cancelUpdate()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
