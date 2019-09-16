//
//  AdvertisingInfoPresenter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
class AdvertisingInfoPresenter:AdvertisingInfoViewToPresenterProtocol {
    
    var interector: AdvertisingInfoPresentorToInterectorProtocol?
    var router: AdvertisingInfoPresenterToRouterProtocol?
    var view: AdvertisingInfoPresenterToViewProtocol?
    
    func updateView() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? AdvertisingInfoViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayApplicationSettings()
    }
    
    func createRectangle(with rect:CGRect){
        // Initialize the path.
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 5.0))
        
        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width, y: 5.0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height+5.0))
        path.addLine(to: CGPoint(x: 0.0, y: rect.height+3.0))
        
        view?.changeShadowPath(with: path.cgPath)
    }
}

extension AdvertisingInfoPresenter:AdvertisingInfoInterectorToPresenterProtocol{
    
    func changeViews(with applicationSettings: ApplicationSettings) {
        view?.changeViews(with: applicationSettings)
    }
}



