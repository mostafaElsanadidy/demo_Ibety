//
//  AdvertisingInfoViewController.swift
//  IBety
//
//  Created by Mohamed on 7/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class AdvertisingInfoViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var adminPhoneTextView: UITextView!
    @IBOutlet weak var responsibleTextView: UITextView!
    @IBOutlet weak var emailTextView: UITextView!
    var presenter:AdvertisingInfoViewToPresenterProtocol!
    
    var applicationSettings = ApplicationSettings(){
        
        didSet{
            adminPhoneTextView.text = self.applicationSettings.data!.phone1!
            responsibleTextView.text = self.applicationSettings.data!.phone2!
            emailTextView.text = self.applicationSettings.data!.email!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        AdvertisingInfoRouter.createModule(view: self)
        if let view = self.view.viewWithTag(130){
            view.layer.cornerRadius = 10
            view.layer.shadowOpacity = 0.5
        }
        
        presenter?.updateView()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        contentView.layer.shadowRadius = 1.0
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        
        presenter?.createRectangle(with: contentView.bounds)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        contentView.layer.shadowRadius = 1.0
//        //
//        //       // let shadowRect = contentView.bounds.insetBy(dx: 0, dy: 2) // inset top/bottom
//        contentView.layer.shadowPath = createRectangle(with: contentView.bounds)
//       // sendMessageBttn.layer.cornerRadius = 5.0
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

extension AdvertisingInfoViewController:AdvertisingInfoPresenterToViewProtocol{
  
    func changeShadowPath(with path: CGPath) {
        contentView.layer.shadowPath = path
    }
    
    func changeViews(with applicationSettings: ApplicationSettings) {
        self.applicationSettings = applicationSettings
    }
    
    
}
