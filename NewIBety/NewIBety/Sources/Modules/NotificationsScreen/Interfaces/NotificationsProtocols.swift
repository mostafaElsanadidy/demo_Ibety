//
//  NotificationsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationsPresenterToViewProtocol: class {
    
    func showError(with text:String);
    func reloadTableView(with notificationData:[NotificationsSettingsData])
}

protocol NotificationsInterectorToPresenterProtocol: class {
    
    func showError(with text:String);
    func updateViews(with notificationData:[NotificationsSettingsData])
}

protocol NotificationsPresentorToInterectorProtocol: class {
    var presenter: NotificationsInterectorToPresenterProtocol? {get set} ;
    func displayNotificationsService()
}

protocol NotificationsViewToPresenterProtocol: class {
    var view: NotificationsPresenterToViewProtocol? {get set};
    var interector: NotificationsPresentorToInterectorProtocol? {get set};
    var router: NotificationsPresenterToRouterProtocol? {get set}
    func viewWillAppear();
}

protocol NotificationsPresenterToRouterProtocol: class {
    
    var presenter:NotificationsViewToPresenterProtocol?{get set}
    static func createModule(view:NotificationTableViewController)
}
