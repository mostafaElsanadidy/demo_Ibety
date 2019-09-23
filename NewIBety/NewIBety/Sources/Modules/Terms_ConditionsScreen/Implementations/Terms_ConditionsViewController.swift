//
//  Terms and Conditions Terms and Conditions Terms_ConditionsViewController.swift
//  IBety
//
//  Created by Mohamed on 7/10/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit



class Terms_ConditionsViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var termsAgreeBttn: UIButton!
    
    var presenter:Terms_ConditionsViewToPresenterProtocol?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Terms_ConditionsRouter.createModule(view: self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        termsAgreeBttn.layer.cornerRadius = 5.0
        presenter?.updateViews()
    }
    
    @IBAction func cancelAction() {
        presenter?.dismissViewController()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalIndicator = scrollView.subviews.last as? UIImageView
        print("mostafa")
         let view = UIImageView(frame: verticalIndicator!.frame)
            scrollView.addSubview(view)
        verticalIndicator?.backgroundColor = UIColor.red
        verticalIndicator?.frame.size.height = 0.5
        scrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: textView.frame.width-8)
        print("\(verticalIndicator?.frame.height) \(textView.frame.width)")
           }

    @IBAction func isAgreeBttnAction() {
        
        presenter?.isAgreeBttnClicked()
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
