//
//  AboutApplicationInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class AboutApplicationInterector: AboutApplicationPresentorToInterectorProtocol {
    
    var applicationSettings:ApplicationSettings!
    
    var presenter: AboutApplicationInterectorToPresenterProtocol?
    
    func showDetailsAboutApplication() {
        
        if let data = UserDefaults.standard.data(forKey: "ApplicationSettings")
        {
            applicationSettings = try! JSONDecoder().decode(ApplicationSettings.self, from: data)
            presenter?.displayApplicationDetails(appSettings: applicationSettings.data!)
        }
    }
}
