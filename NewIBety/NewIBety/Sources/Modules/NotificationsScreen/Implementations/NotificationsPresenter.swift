//
//  NotificationsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class NotificationsPresenter: NotificationsViewToPresenterProtocol {
    
    var interector: NotificationsPresentorToInterectorProtocol?
    var router: NotificationsPresenterToRouterProtocol?
    var view: NotificationsPresenterToViewProtocol?
    
    func viewWillAppear() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? NotificationTableViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayNotificationsService()
    }
    
    
}

extension NotificationsPresenter:NotificationsInterectorToPresenterProtocol{
    
    func showError(with text: String) {
        view?.showError(with: text)
    }
    
    func updateViews(with notificationData: [NotificationsSettingsData]) {
        view?.reloadTableView(with: notificationData)
    }
}
