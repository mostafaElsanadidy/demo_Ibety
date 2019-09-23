//
//  MyProjectPartsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class MyProjectPartsPresenter: MyProjectPartsViewToPresenterProtocol {
    
    var interector: MyProjectPartsPresentorToInterectorProtocol?
    var router: MyProjectPartsPresenterToRouterProtocol?
    var view: MyProjectPartsPresenterToViewProtocol?
    
    
    func updateView() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? MyProjectPartsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: [1,2,3])}
        }
        interector?.updateView()
    }
    
    func moveBttnToPage(num: Int) {
        router?.moveBttnToPage(num: num)
    }
}

extension MyProjectPartsPresenter:MyProjectPartsInterectorToPresenterProtocol{
    
    
    func showNetworkError(with text: String) {
    
        view?.showNetworkError(with: text)
    }
    
    func changeTitleView(with title: String) {
        view?.changeTitleView(with: title)
    }
    
    func hideViews() {
        view?.hideViews()
    }
}
