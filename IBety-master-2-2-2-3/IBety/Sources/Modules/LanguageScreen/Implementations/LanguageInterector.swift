//
//  LanguageInterector.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class LanguageInterector: LanguagePresentorToInterectorProtocol {


    var ownerLoginResult:OwnerLogin_Result!
    var presenter: LanguageInterectorToPresenterProtocol?

    func isBeforeLogin() {
        
        var indexOfPage = 0
        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
            
            self.ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
            print(self.ownerLoginResult.data!.type!)
            print(self.ownerLoginResult.data!.phone_number!)
            if self.ownerLoginResult.data!.type! == "owner" && ownerLoginResult.data!.verified!{
                indexOfPage = 2
            }
            else if self.ownerLoginResult.data!.type! == "customer" || !ownerLoginResult.data!.verified!{
                indexOfPage = 1
            }
            
            presenter?.insertMyDetailsViewController(index: 3, indexOfPage: indexOfPage)
        }
        else{
            presenter?.insertMyDetailsViewController(index: 1, indexOfPage: 0)
        }
        
    }
}
