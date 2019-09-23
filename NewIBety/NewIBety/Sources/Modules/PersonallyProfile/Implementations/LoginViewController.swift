//
//  LoginViewController.swift
//  IBety
//
//  Created by Mohamed on 7/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

import Alamofire


class LoginViewController: UIViewController {
    
    
    var userProfileResult=User_ProfileData(){
        
        didSet{
            
            self.userNameTextField.text = self.userProfileResult.name!
            self.userImageView.showSpinner(tag: 1001)
            
            presenter?.updateUserImage(with: self.userProfileResult.avatar!)
            
        }
    }
    
    
    var presenter:ProfileViewToPresenterProtocol!
    @IBOutlet weak var editBttn: UIButton!
   // @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveBttn: UIButton!
    @IBOutlet weak var cancelBttn: UIButton!
   
    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileRouter.createModule(view: self)
        presenter?.updateView()
       // backImageView.transform = CGAffineTransform.init(rotationAngle: 4*3.14/180)
        print("\(CGFloat.pi)")
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func cancelPage() {
        
        presenter?.cancelPage()
            }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profileView.layer.shadowPath = profileView.createRectangle()
        editBttn.layer.cornerRadius = editBttn.frame.width/2
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.layer.borderColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        userImageView.layer.borderWidth = 4
        userImageView.layer.shadowOpacity = 0.5
        saveBttn?.layer.cornerRadius = 5
        cancelBttn?.layer.cornerRadius = 5
        userNameTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
             //   9740908054
       // profileView.layer.shadowRadius = 0.2
    }
    
    @IBAction func saveBttnDidClicked() {
        
        
        presenter?.saveData(userName: userNameTextField.text!, password: passwordTextField.text!, configPassword: passwordTextField.text!)
    }
    
    
    @IBAction func editImageBttnDidClicked() {
        presenter?.pickPhoto()
    }
    
}


extension LoginViewController:ProfilePresenterToViewProtocol{
   
    func showUpdateAlert() {
        
        let alert = UIAlertController(
            title: "congiratulation...",
            message:
            "Already you sent Update Profile Request successfully \n***Please wait Response to your request***",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func updateViews(with userData: User_ProfileData) {
        self.userProfileResult = userData
    }
    
    
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
    
    func displayUserImage(with data: Data) {
        
        self.userImageView.isHidden = false
        self.userImageView.hideSpinner(tag: 1001)
        self.userImageView.image = UIImage(data: data)
    }
    
    func showError(with text: String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showImage(image: UIImage) {
        
        self.userImageView.image = image.resized_Image(withBounds: self.userImageView.frame.size)
        self.userImageView.isHidden = false
    }
    
    
}
