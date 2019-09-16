//
//  NewPasswordViewController.swift
//  IBety
//
//  Created by Mohamed on 7/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view.viewWithTag(140){
            view.layer.cornerRadius = 10
            view.layer.shadowOpacity = 0.5
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
