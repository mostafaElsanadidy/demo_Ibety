//
//  SendMessagePresenter.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class SendMessagePresenter:SendMessageViewToPresenterProtocol{
    
    
    func updateViews() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? SendMessageViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    func createRectangle(with rect: CGRect) {
        // Initialize the path.
        let path = UIBezierPath()
        let size = rect.size
        
        path.move(to: CGPoint(x: 0.0, y: 3.0))
        
        path.addLine(to: CGPoint(x: size.width/2, y: size.height/2))
        path.addLine(to: CGPoint(x: size.width, y: 3.0))
        path.addLine(to: CGPoint(x: size.width, y: size.height+5.0))
        path.addLine(to: CGPoint(x: 0.0, y: size.height+5.0))
        
        view?.changeShadowPath(with: path.cgPath)
    }
    
    
    var interector: SendMessagePresentorToInterectorProtocol?
    var router: SendMessagePresenterToRouterProtocol?
    var view: SendMessagePresenterToViewProtocol?
    
    func sendFeebackMessage(with name: String, email: String, message: String) {
        interector?.sendFeebackMessage(with: name, email: email, message: message)
    }
    
    
    
    func updateTabBarController() {
        interector?.findLoginResult()
    }
}

extension SendMessagePresenter:SendMessageInterectorToPresenterProtocol{
    
    func showAlertForSendingFeedback() {
        view?.showAlertForSendingFeedback()
    }
    
    func insertMyDetailsViewController(controllerName: String, index: Int, indexOfPage: Int) {
        router?.insertMyDetailsViewController(controllerName: controllerName, index: index, indexOfPage: indexOfPage)
    }
    
    func showNetworkError(with text: String) {
        view?.showNetworkError(with: text)
    }
    
}
