//
//  CommunicationViewController.swift
//  IBety
//
//  Created by Mohamed on 8/8/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class CommunicationViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emailTextView: UITextView!
    @IBOutlet weak var sendMessageBttn: UIButton!
    @IBOutlet weak var phoneNumsTextView: UITextView!
    @IBOutlet weak var reportPhoneNumLabel: UILabel!
    @IBOutlet weak var emailSuggestTextView: UITextView!
    @IBOutlet weak var suggestPhoneNumsTextView: UITextView!
    
    var presenter:CommunicationViewToPresenterProtocol!
    
    var applicationSettings=ApplicationSettingsData(){
        didSet{
            
            phoneNumsTextView.text = "\(applicationSettings.phone1!)\n\n\(applicationSettings.phone2!)\n\n\(applicationSettings.phone3!)"
            emailTextView.text = applicationSettings.email!
            reportPhoneNumLabel.text = applicationSettings.report_phone!
            suggestPhoneNumsTextView.text = applicationSettings.suggest_phone!
            emailSuggestTextView.text = applicationSettings.email!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CommunicationRouter.createModule(view: self)
        presenter?.viewDidLoad()
        reportPhoneNumLabel.textAlignment = .center
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.layer.shadowRadius = 2.0
        //
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        //       // let shadowRect = contentView.bounds.insetBy(dx: 0, dy: 2) // inset top/bottom
        presenter?.createRectangle(with: contentView.bounds)
        sendMessageBttn.layer.cornerRadius = 5.0
    }
    
    @IBAction func sendMessageBttnAction() {
        
        print(view.bounds.width)
        presenter?.moveToFeedBackPage()
        
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

extension CommunicationViewController:CommunicationPresenterToViewProtocol{
   
    func updateShadowPath(with path: CGPath) {
        
        contentView.layer.shadowPath = path
    }
    
    func updateViews(with applicationSettings: ApplicationSettingsData) {
        self.applicationSettings = applicationSettings
    }

    
}
