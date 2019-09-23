//
//  LanguagePresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class LanguagePresenter:LanguageViewToPresenterProtocol{
    
    var view: LanguageViewController?
    var interector: LanguagePresentorToInterectorProtocol?
    var router: LanguagePresenterToRouterProtocol?
    
    
    func viewDidLoad() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? LanguageViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    
    func changeWindow() {
        
       router?.returnToFirst()
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with:mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
        }) { (finished) -> Void in
        }
    }
    
    func setArabicLanguage() {
        
        L102Language.setAppleLAnguageTo(lang: "ar")
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        changeWindow()
    }
    
    func setEnglishLanguage() {
        
        L102Language.setAppleLAnguageTo(lang: "en")
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        changeWindow()
    }
    func cancelPage() {
        interector?.isBeforeLogin()
    }
   
}

extension LanguagePresenter:LanguageInterectorToPresenterProtocol{
    
    func insertMyDetailsViewController(index: Int, indexOfPage: Int) {
        router?.insertMyDetailsViewController(controllerName: "MyDetailsViewController", index: index, indexOfPage: indexOfPage)
    }
    
}
