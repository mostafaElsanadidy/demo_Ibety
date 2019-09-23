//
//  Name&PasswordViewController.swift
//  IBety
//
//  Created by Mohamed on 7/8/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire




class Name_PasswordViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var codeStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    //var view:UIView!
    @IBOutlet weak var verificationCodeStackView: UIStackView!
  //  @IBOutlet weak var passwordStackView: UIStackView!
  //  @IBOutlet weak var userNameStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var demoView: UIView!
    @IBOutlet weak var phone_NumberView: UIView!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
//    @IBOutlet weak var verificationCodeView: UIView!
    @IBOutlet weak var sendBttn: UIButton!
    @IBOutlet weak var phoneNumberTextView: UITextView!
    @IBOutlet weak var newPasswordView: UIView!
    
    @IBOutlet weak var config_passwordTextView: UITextView!
    @IBOutlet weak var newPasswordTextView: UITextView!
    
    @IBOutlet weak var mainView: UIView!
    
    var presenter:Name_PasswordViewToPresenterProtocol!
    
//    @IBOutlet weak var passwordTextField1: UITextField!
//    @IBOutlet weak var passwordTextField2: UITextField!
//    @IBOutlet weak var passwordTextField3: UITextField!
//    @IBOutlet weak var passwordTextField4: UITextField!
    
    @IBAction func cancelAction() {
       
        presenter?.dismissViewController()
    }
    
    
    @IBAction func tryAgainAction() {
        
       presenter?.forgetPasswordService()

    }
    
    @IBAction func sendVerifiationCode() {
        
        presenter?.updateSendCodeView(with: view, phoneText: phoneNumberTextView.text!, newPassword: newPasswordTextView.text!, configPassword: config_passwordTextView.text!)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Name_PasswordRouter.createModule(view: self)
    
        mainView.bringSubviewToFront(phone_NumberView)
        presenter?.updateViews()
        
        codeStackView.semanticContentAttribute = .forceLeftToRight
        
        presenter?.receiveView(view: view , mainViews:  [phone_NumberView,demoView,newPasswordView])
        presenter?.createTime()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        newPasswordTextView.layer.cornerRadius = 5
        demoView.layer.cornerRadius = 8
        newPasswordView.layer.cornerRadius = 8
        phone_NumberView.layer.cornerRadius = 8
        mainView.layer.shadowPath = mainView.createRectangle()
        config_passwordTextView.layer.cornerRadius = 5
        sendBttn.layer.cornerRadius = 5
        phoneNumberTextView.layer.cornerRadius = 5
        phoneNumberTextView.layer.borderWidth = 5
        phoneNumberTextView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6664782072)
        
    }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension Name_PasswordViewController:Name_PasswordPresenterToViewProtocol{
 
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "You must write Verification Code . Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            
            self.presenter?.updateTime()
            //            let _ = Timer.scheduledTimer(timeInterval: 1, target: self,
            //                                         selector: #selector(self.didTimeOut), userInfo: nil, repeats: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func changeTimeLabel(with time: String) {
        timerLabel.text = time
    }
    
    func showNetworkError(with errorMessageText: String) {
     
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(errorMessageText).. \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func updateViews(with selectedIndexOfView: Int) {
        if selectedIndexOfView == 1{
           // self.titleLabel.text = "من فضلك اكتب كود التأكيد لو لم يرسل كود التاكيد"
        //    self.verificationCodeView.layer.cornerRadius = 10
          //  self.verificationCodeView.layer.shadowOpacity = 0.3
        }else if selectedIndexOfView == 2{
            
            self.sendBttn.setTitle("Update".localized, for: .normal)
          //  self.titleLabel.text = "من فضلك اكتب كلمة السر الجديدة"
        }
    }
    
   
    
    
    func displayWritePhoneNumAlert() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "You must write Phone Number . Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
