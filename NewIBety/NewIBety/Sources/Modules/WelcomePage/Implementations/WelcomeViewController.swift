//
//  WelcomeViewController.swift
//  IBety
//
//  Created by Mohamed on 7/10/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    var presenter:WelcomeViewToPresenterProtocol!
    
    @IBOutlet weak var skipBttn: UIButton!
    
    @IBOutlet weak var completeAsVisitorBttn: UIButton!
    
    @IBOutlet weak var logoutBttn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WelcomeRouter.createModule(view: self)
        
        skipBttn?.setTitle("Skip".localized, for: .normal)
        completeAsVisitorBttn?.setTitle("Complete as a visitor".localized, for: .normal)
        logoutBttn?.setTitle("sign out".localized, for: .normal)
        presenter?.updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        skipBttn?.layer.cornerRadius = 5
        logoutBttn?.layer.cornerRadius = 5
        completeAsVisitorBttn?.layer.cornerRadius = 5
    }
    
    @IBAction func logOutAction() {
        
        // UserDefaults.standard.removeObject(forKey: "UserRegisteration1")
        presenter?.logout()
    }
    
    
    @IBAction func skipWelcomePage() {
        
        presenter?.skipWelcomePage()
           }

}

