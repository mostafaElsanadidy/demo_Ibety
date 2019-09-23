//
//  TermsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class Terms_ConditionsPresenter:Terms_ConditionsViewToPresenterProtocol{
    
    var view: Terms_ConditionsViewController?
    var router: Terms_ConditionsPresenterToRouterProtocol?
    var delegate: Terms_ConditionsViewControllerDelegate?
    
    func updateViews() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? Terms_ConditionsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    func dismissViewController() {
        
        router?.dismissViewController()
    }
    
    func isAgreeBttnClicked() {
        
        delegate?.isAgreeONTerms_Conditions(self, isAgree: true)
        router?.dismissViewController()
    }
    
    
}
