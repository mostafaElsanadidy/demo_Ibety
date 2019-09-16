//
//  IbetyPresenter+AccountCreate.swift
//  IBety
//
//  Created by 68lion on 8/30/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class AccountCreatePresenter:AccountCreate_ViewToPresenterProtocol{
    var accountView: AccountCreate_PresenterToViewProtocol?
    
    var accountInterector: AccountCreate_PresentorToInterectorProtocol?
    
    var accountRouter: AccountCreate_PresenterToRouterProtocol?
    
    func passDataToAnotherView(segue: UIStoryboardSegue) {
        accountRouter?.passDataToAnotherView(segue: segue)
    }
    
    func updateUserDefaults(value: Any, key: String) {
        accountInterector?.insertUserDefaults(value: value, key: key)
    }
    
    
    
    func performSegue(identifier: String) {
            accountRouter?.performSegue(identifier: identifier)
    }
    
    func createAccount(n: String, e: String, m: String, c: Int, p: String, t: String){
            accountInterector?.createAccountService(n: n, e: e, m: m, c: c, p: p, t: t)
    }
    
    
    func updateCitiesBttn(){
            accountInterector?.default_CitiesService()
    }
    
    func hideKeyboardWhenTappedAround() {
        
        //let cancel_Tag = [1,2,3,4]
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = accountView as? AccountCreationViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        if let viewController = accountView as? UIViewController{
            viewController.view.addGestureRecognizer(tap)}
    }
    
    @objc func dismissKeyboard() {
        
        if let viewController = accountView as? UIViewController{
            viewController.view.endEditing(true)}
    }
    
    func dissmissViewController(){
            accountRouter?.dissmissViewController()}
}



extension AccountCreatePresenter:AccountCreate_InterectorToPresenterProtocol{
  
    
    func finishAccountCreate(type:String) {
        accountView?.presentAccountCreateAlert(type: type)
    }
    
   
    func showError(errorMessageText:String){
        accountView?.showError(errorMessageText: errorMessageText)
    }
    
    func updateDropDownData(with cities: [defaultCity]) {
        accountView?.updateDropDownData(with: cities)
    }
}

extension AccountCreatePresenter:Terms_ConditionsViewControllerDelegate{
    
    func isAgreeONTerms_Conditions(_ Terms_ConditionsPresenter: Terms_ConditionsViewToPresenterProtocol, isAgree: Bool) {
        
        accountView?.updateCheckBttn(isOn: isAgree)
    }
}
