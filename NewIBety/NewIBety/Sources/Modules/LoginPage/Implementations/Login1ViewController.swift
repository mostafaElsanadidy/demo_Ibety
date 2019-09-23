//
//  Login1ViewController.swift
//  IBety
//
//  Created by Mohamed on 7/9/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import SSCustomTabbar
import Alamofire
//import DropDown
import FlagPhoneNumber

class Login1ViewController: UIViewController {

    @IBOutlet weak var isHaveAccountLabel: UILabel!
    @IBOutlet weak var isHaveStackView: UIStackView!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBttn: UIButton!
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var passwordView: UIView!
  //  @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: FPNTextField!
    var loginPresenter:LoginPageViewToPresenterProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)}
        
     @IBAction func cancelPage(_ sender: Any) {
        
       loginPresenter?.dissmissViewController()
    }
    
    
    @IBAction func sign_InBttnAction() {
      
        loginPresenter?.login(userName: phoneTextField.text!, password: passwordTextField.text!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        loginView.layer.shadowOpacity = 0.1
        loginView.layer.shadowPath = loginView.createRectangle()
        loginView.layer.cornerRadius = 10
        loginBttn.layer.cornerRadius = 5
        phoneNumberView.layer.cornerRadius = 5
        passwordView.layer.cornerRadius = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginRouter.createModule(viewController: self)
        loginPresenter?.updateView()
//        dropDown.anchorView = phoneNumberView
//        dropDown.dataSource = [""]
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        phoneTextField.setCountries(including: [.QA, .EG , .SA ])
        phoneTextField.placeholder = "Phone Number".localized
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            loginPresenter?.passDataToAnotherView(segue: segue)
    }

}

extension Login1ViewController:LoginPagePresenterToViewProtocol{
    func show_Error(errorMessageText: String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(errorMessageText). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
