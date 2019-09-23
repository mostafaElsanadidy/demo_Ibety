//
//  CommunicateDetailsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class CommunicateDetailsPresenter:CommunicateDetailsViewToPresenterProtocol {
    var interector: CommunicateDetailsPresentorToInterectorProtocol?
    var router: CommunicateDetailsPresenterToRouterProtocol?
    var view: CommunicateDetailsPresenterToViewProtocol?
 
    func viewWillAppear() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? CommunicateDetailsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayProjectService()
    }
}

extension CommunicateDetailsPresenter:CommunicateDetailsInterectorToPresenterProtocol{
    
    func updateTitleView(with displayedProjectDetails: projectCreationDetails) {
        view?.updateTitleView(with: displayedProjectDetails)
    }
}
