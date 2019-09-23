//
//  ProjectDetailsInterector.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Alamofire

class ProjectDetailsInterector: ProjectDetailsPresentorToInterectorProtocol {
    
    var presenter: ProjectDetailsInterectorToPresenterProtocol?
    
    var displayedProjectDetails=projectCreationDetails(){
        didSet{
            
            presenter?.updateView(with: self.displayedProjectDetails.data!)
        }
    }
    
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleOfPage(_:)), name: NSNotification.Name(rawValue: "ChangeProjectData"), object: nil)
    }
    
    @objc func changeTitleOfPage(_ notification: Notification) {
        
        displayProjectDetails()
        
    }
    
    func displayProjectImage(with urlStr: String) {
        
        Alamofire.request(urlStr).responseData { (response) in
            if response.error == nil {
                print(response.result)
                // Show the downloaded image:
                if let data = response.data {
                    self.presenter?.updateProjectImage(with: data)
                }
            }
            
        }
    }
    
    func displayProjectDetails() {
        
        let data = UserDefaults.standard.data(forKey: "displayProject")
        self.displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data!)
    }
    
    
    
}
