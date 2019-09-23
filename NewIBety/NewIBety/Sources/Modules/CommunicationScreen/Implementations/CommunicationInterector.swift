//
//  CommunicationInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class CommunicationInterector:CommunicationPresentorToInterectorProtocol{
    
    var presenter: CommunicationInterectorToPresenterProtocol?
    
    var applicationSettings=ApplicationSettings(){
        
        didSet{
            presenter?.updateViews(with: self.applicationSettings.data!)
        }
    }
    
    func displayApplicationSettings() {
        
        if let data = UserDefaults.standard.data(forKey: "ApplicationSettings")
        {
            applicationSettings = try! JSONDecoder().decode(ApplicationSettings.self, from: data)
            
        }
    }
    
    func isBeforeLogin() {
        
        
        
        var index = 0
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            index = 3
        }else{
            index = 1
        }
        
        presenter?.updateTabBarViewController(with: index)
        
    }
}
