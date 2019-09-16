//
//  FourTabInterector.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class FourTabInterector: FourTabPresentorToInterectorProtocol {
    
    var presenter: FourTabInterectorToPresenterProtocol?
    var displayMyProject=projectCreationDetails(){
        didSet{
            presenter?.displayMyProject(with: self.displayMyProject.data!)
        }
    }
    
    func displayMyProjectService() {
        
        if let data = UserDefaults.standard.data(forKey: "displayCreatedProject"){
            self.displayMyProject = try! JSONDecoder().decode(projectCreationDetails.self, from: data)
        }
        
    }
    
    
}
