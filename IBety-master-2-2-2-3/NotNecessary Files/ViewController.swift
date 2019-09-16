//
//  ViewController.swift
//  IBety
//
//  Created by Mohamed on 6/17/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let frame = segmentControl.frame
        segmentControl.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 2.0)
    }
    
    

    @IBAction func segmentChanged(_ sender:UISegmentedControl) {
        
//        switch  segmentControl.selectedSegmentIndex{
//        case 0:
//            imageView.image = UIImage(named: "1")
//        case 1:
//            imageView.image = UIImage(named: "3")
//        case 2:
//            imageView.image = UIImage(named: "1")
//        default:
//            
//        }
    }
    
}
    




