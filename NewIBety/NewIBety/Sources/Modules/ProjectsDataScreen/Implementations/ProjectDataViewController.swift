//
//  ProjectDataViewController.swift
//  IBety
//
//  Created by Mohamed on 6/25/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ProjectDataViewController: UIViewController{

    @IBOutlet weak var projectPhoneTextField: UITextView!
    @IBOutlet weak var projectEmailTextField: UITextView!
    @IBOutlet weak var addressTextField: UITextView!
    @IBOutlet weak var demoView: UIView!
    
    var prsenter:ProjectDataViewToPresenterProtocol!
    var isPhoneFieldFirstTimeWritten = true
    var isEmailFieldFirstTimeWritten = true
    var placeholderText1 = ""
    var placeholderText2 = ""
    var isUpdateState:Bool = false
    
    var displayedProjectDetails = projectCreationDetails(){
        didSet{
        let projectData = self.displayedProjectDetails.data!
        self.projectPhoneTextField.text = projectData.owner?.phone_number!
        self.projectEmailTextField.text = projectData.owner!.email!
        let address = projectData.owner!.projects!.data!.address!
            self.addressTextField.text = address
        }
    }
  //   var ownerInfo:MyOwner_Info!
   // var dicOfProductDetails:[String:Any]!
    
    @IBAction func createAccountService() {
        
        prsenter?.createProject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //productDetails
        print(" *************** ")
        
    }
    
    @IBOutlet weak var saveBttn: UIButton!
    @IBOutlet weak var cancelBttn: UIButton!
    
    
    @IBAction func cancelBttn(_ sender: Any) {
        
        prsenter?.institiateViewController(with: "MyProjectPartsViewController", in: 3)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        //demoView.layer.shadowRadius = 0.1
        demoView?.layer.cornerRadius = 10
        demoView?.layer.shadowOpacity = 0.2
        demoView?.layer.shadowRadius = 5
        //ProjectInfoView.layer.shadowOffset = CGSize.init(width: 0, height: -3)
        //ProjectInfoView.layer.shouldRasterize = true
        demoView?.layer.shadowPath = demoView?.createRectangle()
        saveBttn?.layer.cornerRadius = 5
        cancelBttn?.layer.cornerRadius = 5
    }
    
//    @objc func updatProductByNotification(_ notification:Notification){
//        
//        print("**************** \(notification.userInfo!["productDetails"] as? [String:Any]) ***************")
//        dicOfProductDetails = notification.userInfo!["productDetails"] as? [String:Any]
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //NotificationCenter.default.addObserver(self, selector: #selector(updatProductByNotification), name: Notification.Name(rawValue: "productDetails"), object: nil)
        
        ProjectDataRouter.createModule(view: self)
        projectPhoneTextField.delegate = (prsenter as! UITextViewDelegate)
        projectEmailTextField.delegate = (prsenter as! UITextViewDelegate)
        // Do any additional setup after loading the view.
        
        prsenter?.updateViews(isUpdateState: isUpdateState)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func findYourLocationCoordinates() {
        
        prsenter?.findYourLocationCoordinates(isUpdateState: isUpdateState)
    }
    
    
    
    @IBAction func updateProject() {
        
        prsenter?.updateProject()
        
    }
}


//extension ProjectDataViewController : UITextViewDelegate{
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//
//        if textView == projectPhoneTextField{
//            if isPhoneFieldFirstTimeWritten {
//
//
//                //            text = textView.text
//                if !isUpdateState{
//                    placeholderText1 = projectPhoneTextField.text
//                    print("\(projectPhoneTextField.text!)")
//                    projectPhoneTextField.text = ""}
//
//                isPhoneFieldFirstTimeWritten = false
//            }
//
//
//        }
//
//        if textView == projectEmailTextField{
//            if isEmailFieldFirstTimeWritten == true {
//
//                //            text = textView.text
//                if !isUpdateState{
//                    placeholderText2 = projectEmailTextField.text
//                    print("\(projectEmailTextField.text!)")
//                    projectEmailTextField.text = ""}
//                isEmailFieldFirstTimeWritten = false
//            }
//        }
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//
//        if textView.text.count>0{
//            if textView.text != placeholderText1 || textView.text != placeholderText2{
//                if textView == projectPhoneTextField{
//                    print(projectPhoneTextField.text!)
//                    userProject.projectPhone = projectPhoneTextField.text!
//                    if isUpdateState{
//
//                        dicOfUpdateProject["phone"] =  projectPhoneTextField.text!
//                    }
//                }
//                if textView == projectEmailTextField{
//                    userProject.projectEmail = textView.text!
//
//                    if isUpdateState{
//                        dicOfUpdateProject["email"] = textView.text!
//                    }
//                }
//
//            }
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//
//        //        if textView.text.count>0{
//        //
//        //        }
//
//        if textView == projectPhoneTextField{
//
//            if !isPhoneFieldFirstTimeWritten ,  projectPhoneTextField.text.count == 0{
//                projectPhoneTextField.text = placeholderText1
//                isPhoneFieldFirstTimeWritten = true
//            }}
//        if textView == projectEmailTextField{
//
//            if !isEmailFieldFirstTimeWritten , projectEmailTextField.text.count == 0{
//                projectEmailTextField.text = placeholderText2
//                isEmailFieldFirstTimeWritten = true
//            }}
//    }
//}

extension ProjectDataViewController:ProjectDataPresenterToViewProtocol{
  
    
    func showAlertForProjectUpdate() {
        let alert = UIAlertController(
            title: "Tagged...",
            message:
            "Already you sent Update Project Request successfully \n*** Please wait Response to your request ***.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            
            _ in
            
            self.prsenter?.institiateViewController(with: "MyProjectPartsViewController", in: 3)
            
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    func showLocationServiceDeniedAlert(){
        
        let alert=UIAlertController(title: "Location Service Disables", message: "please enable location service for this app in settings", preferredStyle: .alert)
        let action=UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func updateProjectAddress(with address: String) {
        self.addressTextField.text = address
    }

    func displayProjectDetails(with displayedProjectDetails: projectCreationDetails) {
        self.displayedProjectDetails = displayedProjectDetails
    }
    
    
    func showNetworkError(with text: String) {
        
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text).. \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertForProjectCreation() {
        let alert = UIAlertController(
            title: "Thank You...",
            message:
            "you already have project on Ibety App.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        {_ in
            self.prsenter?.performSegue(withIdentifier: "welcomeToApp")
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
