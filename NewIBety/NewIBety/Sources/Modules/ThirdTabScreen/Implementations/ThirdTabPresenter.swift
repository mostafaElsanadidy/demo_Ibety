//
//  ThirdTabPresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ThirdTabPresenter: ThirdTabViewToPresenterProtocol {
    
    var interector: ThirdTabPresentorToInterectorProtocol?
    var router: ThirdTabPresenterToRouterProtocol?
    var view: ThirdTabViewController?
    var indexOfPage = 0
    
    
    func cancelPage() {
        
//        if indexOfPage == 1{
//            router?.dismissViewController()
//        }
//        else{
            interector?.isBeforeLogin()
//        }
     }
    
    func viewDidLoad(with indexOfPage: Int) {
        self.indexOfPage = indexOfPage
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ThirdTabViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        router?.addChildController(indexOfPage: indexOfPage)
    }
    
}

extension ThirdTabPresenter: ThirdTabInterectorToPresenterProtocol{

    
    func insertMyDetailsViewController(index: Int, indexOfPage: Int) {
        router?.insertMyDetailsViewController(controllerName: "MyDetailsViewController", index: index, indexOfPage: indexOfPage)
    }
    
}
