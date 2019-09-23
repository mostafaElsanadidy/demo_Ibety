//
//  ParentViewController.swift
//  IBety
//
//  Created by Mohamed on 6/24/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ParentViewController: UIViewController {
    
    
 //   @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoBttn: UIButton!
    @IBOutlet weak var productsBttn: UIButton!
    @IBOutlet weak var proDataBttn: UIButton!
    @IBOutlet weak var rightBttn: UIButton!
    @IBOutlet weak var leftBttn: UIButton!
    @IBOutlet weak var containerView: UIView!
    var presenter:ParentViewViewToPresenterProtocol!
    
    
    @IBAction func cancelAction() {
        
        presenter?.dismissViewController()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ParentViewRouter.createModule(view: self)
        infoBttn.layer.cornerRadius = 15.0
        productsBttn.layer.cornerRadius = 15.0
        proDataBttn.layer.cornerRadius = 15.0
        rightBttn.layer.cornerRadius = 15.0
        leftBttn.layer.cornerRadius = 15.0
   //     createAccount.layer.cornerRadius = 5
        leftBttn.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        
        presenter?.updateView(with: [infoBttn,productsBttn,proDataBttn],
                              titles: ["Project Info", "Project Products", "Communication Info"])
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func communicationInfoBttnAction() {
     //   titleLabel.text = "Communication Info".localized
        presenter?.moveToPage(with: 2)
    }
    
    @IBAction func productsBttnAction() {
      //  titleLabel.text = "Project Products".localized
        presenter?.moveToPage(with: 1)
    }
    
    @IBAction func projectInfoBttnAction() {
     //   titleLabel.text = "Project Info".localized
        presenter?.moveToPage(with: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.createBezierPath()
    }
    
    @IBAction func swipeMade(_ sender: UISwipeGestureRecognizer) {
        
        presenter?.swipeMade(sender)
    }
    
    @IBAction func cancelPage() {
        presenter?.dismissViewController()
    }
    
   
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension ParentViewController:ParentViewPresenterToViewProtocol{
   
    func selectBttn(bttn: UIButton, index: Int, title: String) {
        
        titleLabel.text = title.localized
        bttn.backgroundColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)
        bttn.setImage(UIImage(named: "active\(index)"), for: .normal)
    }

    func changeShadowPath(with shapeLayer: CAShapeLayer) {
        scrollView.layer.addSublayer(shapeLayer)
    }
    
    func deselectBttn(bttn: UIButton, index: Int) {
        
        bttn.backgroundColor = #colorLiteral(red: 0.9458244443, green: 0.9458244443, blue: 0.9458244443, alpha: 1)
        bttn.setImage(UIImage(named: "inactive\(index)"), for: .normal)
    }
    
}
