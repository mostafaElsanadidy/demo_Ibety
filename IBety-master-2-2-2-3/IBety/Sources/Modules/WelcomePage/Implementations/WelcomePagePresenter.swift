//
//  WelcomePagePresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class WelcomePresenter: WelcomeViewToPresenterProtocol {
    
    var view: WelcomeViewController?
    var interector: WelcomePresentorToInterectorProtocol?
    var router: WelcomePresenterToRouterProtocol?
    
    func updateViews() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? WelcomeViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: [1,2])}
        }
    }
    
    func logout() {
        interector?.updateOwnerUserDefaults()
        router?.moveToFirstViewController()
    }
    
    func skipWelcomePage() {
        
        interector?.isBeforeLogin()
    }
}

extension WelcomePresenter:WelcomeInterectorToPresenterProtocol{
    
    func updateTabBarViewController(using index: Int, indexOfPage: Int) {
        router?.updateTabBarViewController(using: index, indexOfPage: indexOfPage)
    }
    
}
