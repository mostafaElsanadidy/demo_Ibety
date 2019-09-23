//
//  CommunicationPresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class CommunicationPresenter: CommunicationViewToPresenterProtocol {
    
    var interector: CommunicationPresentorToInterectorProtocol?
    var router: CommunicationPresenterToRouterProtocol?
    var view: CommunicationPresenterToViewProtocol?
    
    func viewDidLoad() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? CommunicationViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: [1])}
        }
        interector?.displayApplicationSettings()
    }
    
    func createRectangle(with rect: CGRect) {
        // Initialize the path.
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0.0, y: 4.0))
        
        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height/2))
        print(rect.width)
        path.addLine(to: CGPoint(x: rect.width, y: 4.0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height+5.0))
        path.addLine(to: CGPoint(x: 0.0, y: rect.height+5.0))
        
        view?.updateShadowPath(with: path.cgPath)
    }
    
    func moveToFeedBackPage() {
        interector?.isBeforeLogin()
    }
}

extension CommunicationPresenter:CommunicationInterectorToPresenterProtocol{
    
    func updateViews(with applicationSettings: ApplicationSettingsData) {
        view?.updateViews(with: applicationSettings)
    }
    
    func updateTabBarViewController(with index: Int) {
        router?.updateTabBarViewController(with: index)
    }
}

