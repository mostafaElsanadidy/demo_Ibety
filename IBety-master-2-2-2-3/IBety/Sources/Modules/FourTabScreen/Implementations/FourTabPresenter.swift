//
//  FourTabPresenter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class FourTabPresenter: FourTabViewToPresenterProtocol {
    
    var interector: FourTabPresentorToInterectorProtocol?
    var router: FourTabPresenterToRouterProtocol?
    var view: FourTabPresenterToViewProtocol?
    
    func viewDidLoad() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? FourTabViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayMyProjectService()
    }
    
    func moveBttnToPage(index: Int) {
        router?.moveBttnToPage(index: index)
    }
    
    func cancelPage() {
        router?.cancelPage()
    }
}

extension FourTabPresenter:FourTabInterectorToPresenterProtocol {
    
    func displayMyProject(with data: projectCreationData) {
        view?.displayMyProject(with: data)
    }
}
