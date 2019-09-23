//
//  AboutApplicationViewController.swift
//  IBety
//
//  Created by Mohamed on 8/8/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class AboutApplicationViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    var presenter:AboutApplicationViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AboutApplicationRouter.createModule(viewController: self)
        presenter?.viewDidLoad()

    }
    
}

extension AboutApplicationViewController:AboutApplicationPresenterToViewProtocol{
    
    func displayApplicationDetails(appSettings: ApplicationSettingsData) {
        aboutTextView.text = appSettings.about!
    }
}
