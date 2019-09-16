//
//  TestViewController.swift
//  IBety
//
//  Created by Mohamed on 7/16/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 5
        view.layer.shadowPath = UIBezierPath.init(rect: view.bounds).cgPath
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        contentView.layer.cornerRadius = 10
//        contentView.layer.shadowOpacity = 0.6
//        contentView.layer.shadowRadius = 5
//        contentView.layer.shadowPath = UIBezierPath.init(rect: contentView.bounds) .cgPath
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
