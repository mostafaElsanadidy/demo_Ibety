//
//  AdvertisingInfoInterector.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class AdvertisingInfoInterector: AdvertisingInfoPresentorToInterectorProtocol {
    
    var presenter: AdvertisingInfoInterectorToPresenterProtocol?
    var applicationSettings = ApplicationSettings(){
        didSet{
            presenter?.changeViews(with: self.applicationSettings)
        }
    }
  
    func displayApplicationSettings() {
        
        if let data = UserDefaults.standard.data(forKey: "ApplicationSettings")
        {
            applicationSettings = try! JSONDecoder().decode(ApplicationSettings.self, from: data)}
    }
}
