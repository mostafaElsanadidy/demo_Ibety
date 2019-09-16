//
//  ParentViewInterector.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class ParentViewInterector: ParentViewPresentorToInterectorProtocol {
    
    var presenter: ParentViewInterectorToPresenterProtocol?
    func removeObjectFromUserDefaults(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
