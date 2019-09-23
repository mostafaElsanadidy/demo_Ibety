//
//  AboutApplicationPresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class AboutApplicationPresenter: AboutApplicationViewToPresenterProtocol {
    
    var interector: AboutApplicationPresentorToInterectorProtocol?
    var view: AboutApplicationPresenterToViewProtocol?
    var router: AboutApplicationPresenterToRouterProtocol?
    
    func viewDidLoad() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? AboutApplicationViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.showDetailsAboutApplication()
    }
}

extension AboutApplicationPresenter:AboutApplicationInterectorToPresenterProtocol{
    
    func displayApplicationDetails(appSettings: ApplicationSettingsData) {
        view?.displayApplicationDetails(appSettings: appSettings)
    }
}
