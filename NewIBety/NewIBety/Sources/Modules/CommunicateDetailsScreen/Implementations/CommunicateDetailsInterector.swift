//
//  CommunicateDetailsInterector.swift
//  IBety
//
//  Created by 68lion on 9/4/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class CommunicateDetailsInterector: CommunicateDetailsPresentorToInterectorProtocol {
    
    var presenter: CommunicateDetailsInterectorToPresenterProtocol?
    var displayedProjectDetails = projectCreationDetails(){
        
        didSet{
            presenter?.updateTitleView(with: self.displayedProjectDetails)
        }
    }
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleOfPage(_:)), name: NSNotification.Name(rawValue: "ChangeProjectData"), object: nil)
    }
    
    @objc func changeTitleOfPage(_ notification: Notification) {
        
        let data = UserDefaults.standard.data(forKey: "displayProject")
        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
    }
    
    func displayProjectService() {
        let data = UserDefaults.standard.data(forKey: "displayProject")
        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
    }
    
}
