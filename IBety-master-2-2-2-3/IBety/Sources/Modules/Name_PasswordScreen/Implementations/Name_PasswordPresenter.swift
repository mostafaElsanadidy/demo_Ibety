//
//  Name_PasswordPresenter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Name_PasswordPresenter: NSObject,Name_PasswordViewToPresenterProtocol{
    
    var interector: Name_PasswordPresentorToInterectorProtocol?
    var router: Name_PasswordPresenterToRouterProtocol?
    var view: Name_PasswordPresenterToViewProtocol?
    
    var mainView = UIView()
    
    var mainViews: [UIView]?
    
    var indexOfSelectedStackView = 0
    var ownerLoginResult:OwnerLogin_Result!
    var indexOfSelectedView:Int = 0
    
    var phoneNumberText = ""
    var checkCodeResult:CheckCodeServiceResult!
    var codeText = ""
    var isCheckPassword=false
    
    weak var timer : Timer?
    var seconds = 30
    var indOfTextField = 1000
    var isFirsttime = true
    
    func receiveView(view:UIView , mainViews:[UIView]) {
        mainView = view
        self.mainViews = mainViews
        for tagOfTextField  in 1000...1003{
            
                            if let textField = view.viewWithTag(tagOfTextField) as? UITextField{
                                textField.delegate = self}
        }
    }
    
    func updateSendCodeView(with mainView: UIView, phoneText: String, newPassword: String, configPassword: String) {
        
        //    UIView.transition(from: phone_NumberView, to: demoView, duration: 0.3, options: .transitionFlipFromRight, completion: nil)
        
        // print(mainView.subviews.count)
        
        if indexOfSelectedView == 0{
            
            phoneNumberText = phoneText
            print(phoneNumberText)
            if phoneText == ""{
                
                view?.displayWritePhoneNumAlert()
            }
            else{
            
                interector?.forgetPasswordService(with: phoneText)
            }}
        
        if indexOfSelectedView == 1{
            let check_codeUrlStr = urlStr+"check-code"
            for tagOfTextField  in 1000...1003{
                
                if let textField = self.mainView.viewWithTag(tagOfTextField) as? UITextField{
                    codeText += textField.text!}
                
                if codeText == ""{
                    timer?.invalidate()
                }
            }
            print(phoneNumberText)
            interector?.checkCode(codeText: codeText, phoneNum: phoneNumberText)
            
            print(codeText)
            print("mklnakdjlcanjk")
        }
        
        if indexOfSelectedView == 2{
            interector?.createNewPassword(newPassword: newPassword, configPassword: configPassword)
        }
        
        if indexOfSelectedView<mainViews!.count-1{
            
            // print(UserDefaults.standard.data(forKey: "CheckPassword"))
            interector?.findUserDefaultValue(for: "CheckPassword")
            if (codeText == "" || isCheckPassword) && indexOfSelectedView == 1 {
                view?.showNetworkError()
                
            }else if phoneText != ""{
                UIView.transition(from: mainViews![self.indexOfSelectedView],
                                  to: mainViews![indexOfSelectedView+1],
                                  duration: 0.8,
                                  options: [.transitionFlipFromTop],
                                  completion: { _ in
                                    self.indexOfSelectedView = self.indexOfSelectedView+1
                                    print(self.indexOfSelectedView)
                                    self.view?.self.updateViews(with: self.indexOfSelectedView)
                                    if self.indexOfSelectedView == 1{
                                        
                                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                                                          selector: #selector(self.didTimeOut), userInfo: nil, repeats: true)
                                        print("\(self.timer!.description)")
                                        
                                        
                                        print("mosftyaftafvatg")//self.mainView.bringSubviewToFront(self.mainView.subviews[1])
                                    }
                })}}
        
    }
    
    func updateTime() {
        self.codeText = ""
        self.seconds = 30
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                          selector: #selector(self.didTimeOut), userInfo: nil, repeats: true)
    }
    
    func updateViews() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? Name_PasswordViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    func createTime() {
        if indexOfSelectedView == 1{
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(didTimeOut), userInfo: nil, repeats: true)
            print("\(timer!.description)")}
    }
    
    @objc func didTimeOut() {
        if seconds <= 0{
            timer?.invalidate()
            view?.showNetworkError()
        }
        view?.changeTimeLabel(with: "0:\(seconds)")
        seconds-=1
        print("*** Time out")}
    
    func forgetPasswordService() {
        interector?.forgetPasswordService(with: phoneNumberText)
        seconds = 30
    }
    
    func dismissViewController() {
        router?.dismissViewController()
    }
    
    
}

extension Name_PasswordPresenter:Name_PasswordInterectorToPresenterProtocol{
    
    
    func showNetworkError(with errorMessageText: String) {
        view?.showNetworkError(with: errorMessageText)
    }
    
    
    func presentIndexInTabBarController(index: Int) {
        
        router?.presentIndexInTabBarController(index: index)
    }
    
    func takeUserDefaultValue(data: Data) {
        isCheckPassword = (data==nil)
    }
    
    
    func insertThirdViewControllerInTabBar(controllerName: String, in index: Int, indexOfPage: Int) {
        router?.insertThirdViewControllerInTabBar(controllerName: controllerName, in: index, indexOfPage: indexOfPage)
    }
    
    func PerformSegue(with identifier: String) {
        router?.PerformSegue(with: identifier)
    }
    func insertViewControllerInTabBar(controllerName: String, in index: Int) {
        router?.insertViewControllerInTabBar(controllerName: controllerName, in: index)
    }
}



extension Name_PasswordPresenter:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  timer?.invalidate()
        textField.text! = ""
        indOfTextField = textField.tag
        //        indOfTextField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var oldText = textField.text! as NSString
        var newText = oldText.replacingCharacters(in: range, with: string)
        
        
        if textField == mainView.viewWithTag(indOfTextField){
            
            print("\(textField.text!),\(newText)")
            //            codeText = codeText+newText
            //            print(codeText)
            textField.text! = newText
            
            if (newText as NSString).length == 1{
                
                textField.resignFirstResponder()
                
                indOfTextField += 1
                
                print("mostafa elss")
                if let textField2 = mainView.viewWithTag(indOfTextField) {
                    print("\(indOfTextField)")
                    let _ = textField2.becomeFirstResponder()
                }
                
                if indOfTextField == 1004{
                    // isFirsttime = false
                    timer?.invalidate()
                    indOfTextField = 1000
                }
                
            }
        }
        return true
    }
}
