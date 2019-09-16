//
//  FirstTAB2ViewController.swift
//  IBety
//
//  Created by Mohamed on 7/11/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class FirstTAB2ViewController: UIViewController {

        @IBOutlet weak var backImageView: UIImageView!
        @IBOutlet weak var moreDetailsBttn: UIButton!
        @IBOutlet weak var advertisingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                backImageView.transform = CGAffineTransform.init(rotationAngle: 4*3.14/180)
                moreDetailsBttn.layer.borderWidth = 1.0
                moreDetailsBttn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                moreDetailsBttn.layer.cornerRadius = 10.0
       // self.advertisingBttn.imageView!.image = UIImage.init(named: "welcome")
        
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
