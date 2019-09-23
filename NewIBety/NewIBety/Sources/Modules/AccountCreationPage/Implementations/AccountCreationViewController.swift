//
//  AccountCreationViewController.swift
//  IBety
//
//  Created by Mohamed on 7/10/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SSCustomTabbar
import DropDown
import FlagPhoneNumber

class AccountCreationViewController: UIViewController{

    @IBOutlet weak var userBttn: UIButton!
    @IBOutlet weak var managerBttn: UIButton!
    @IBOutlet weak var logoBttn: UIButton!
  //  @IBOutlet weak var cityStackView: UIStackView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var accountCreateBttn: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var emailTextView: UITextView!
   // @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var phoneNumberTextView: UITextView!
    @IBOutlet weak var cityTextView: UITextView!
    @IBOutlet weak var passwordTextView: UITextView!
    @IBOutlet weak var checkBttn: CheckboxButton!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var cityView: UIView!
    
    var presenter:AccountCreate_ViewToPresenterProtocol?
    
    var type="customer"
    var indexOfSelectedCity = 0
    
   var dropDown = DropDown()

    
    @IBAction func cancelAction(_ sender: Any) {
        
        presenter?.dissmissViewController()
    }

    
    @IBAction func agreeOnTerms(_ sender: Any) {
        
        if checkBttn.on{
            accountCreateBttn.isEnabled = true
        }else{
            accountCreateBttn.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            presenter?.passDataToAnotherView(segue: segue)
    }
    
    @IBAction func cityBttnAction() {
        
        presenter?.updateCitiesBttn()
    }
    
    @IBAction func accountCreateAction() {
        
        //registerDefaults()
        print("\(nameTextView.text!)")
       
            presenter?.updateUserDefaults(value: "MyDetailsViewController", key: "PAGENAME")
        presenter?.createAccount(n: nameTextView.text!, e: emailTextView.text!, m: phoneTextField.text!, c: indexOfSelectedCity, p: passwordTextView.text!, t: type)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextView.layer.cornerRadius = 3.0
        emailTextView.layer.cornerRadius = 3.0
        cityView.layer.cornerRadius = 5.0
        logoView.layer.cornerRadius = 5.0
        passwordTextView.layer.cornerRadius = 3.0
        accountCreateBttn.layer.cornerRadius = 4.0
        checkBttn.layer.cornerRadius = 2.0
        contentView.layer.cornerRadius = 5.0
        contentView.layer.shadowPath = contentView.createRectangle()
        managerBttn.layer.shadowPath = managerBttn.createRectangle()
        userBttn.layer.shadowPath = managerBttn.createRectangle()
        print("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccountRouter.createModule(viewController: self)
        accountCreateBttn.isEnabled = false
        self.presenter?.hideKeyboardWhenTappedAround()
        dropDown.anchorView = logoView
        dropDown.dataSource = [""]
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        userBttn.layer.shadowOpacity = 0.2
        userBttn.layer.cornerRadius = 5
        userBttn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userBttn.layer.borderWidth = 1
        
        managerBttn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        managerBttn.layer.borderWidth = 1
        managerBttn.layer.shadowOpacity = 0.2
        managerBttn.layer.cornerRadius = 5
       
        phoneTextField.setCountries(including: [.QA, .EG , .SA ])
        phoneTextField.placeholder = "Phone Number".localized
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func userBttnAction() {
        self.type = "customer"
        
        userBttn.updateBttn(with: #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1), imageName: "User-4", titleColor: .white)
        managerBttn.updateBttn(with: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), imageName: "Group 534", titleColor: .gray)
    }
    
    @IBAction func ownerBttnAction() {
        self.type = "owner"
        managerBttn.updateBttn(with: #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1), imageName: "Group 534", titleColor: .white)
        userBttn.updateBttn(with: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), imageName: "User-7", titleColor: .gray)
    }
    
}

extension AccountCreationViewController:AccountCreate_PresenterToViewProtocol{
   
    
    func presentAccountCreateAlert(type:String) {
        
        let alert = UIAlertController(
            title: "Thank You...",
            message:
            "you already have account on Ibety App.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            
            _ in
            
            if type == "owner"{
                self.presenter?.performSegue(identifier: "Create_ProjectSegue")
            }
            else if type == "customer"{
                self.presenter?.performSegue(identifier: "WelcomeCustomer")
            }
            
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func showError(errorMessageText:String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(errorMessageText). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func updateDropDownData(with cities: [defaultCity]) {
        
        var indexOfCities:[Int]=[]
        dropDown.anchorView = cityView
        dropDown.dataSource.removeAll()
        
        for defaultCity in cities{
            dropDown.dataSource.append(defaultCity.name!.description)
            indexOfCities.append(defaultCity.id!)
        }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.cityTextView.text = item
            self.indexOfSelectedCity = indexOfCities[index]
            
        }
        dropDown.show()
    }
    
    func updateCheckBttn(isOn: Bool) {
        
        checkBttn.on = isOn
        accountCreateBttn.isEnabled = isOn
    }
    
}

extension UIButton{
    
    func updateBttn(with backgroundColor:UIColor , imageName:String , titleColor:UIColor){
        self.backgroundColor = backgroundColor
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }
}

