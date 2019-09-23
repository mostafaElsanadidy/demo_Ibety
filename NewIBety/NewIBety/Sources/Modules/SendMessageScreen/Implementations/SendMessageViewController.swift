//
//  SendMessageViewController.swift
//  IBety
//
//  Created by Mohamed on 8/8/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire

class SendMessageViewController: UIViewController {

    @IBOutlet weak var emailTextView: UITextView!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sendMessageBttn: UIButton!
    
    var presenter:SendMessageViewToPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SendMessageRouter.createModule(view: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func sendMessage() {
        
        presenter?.sendFeebackMessage(with: nameTextView.text!, email: emailTextView.text!, message: messageTextView.text!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //
        //       // let shadowRect = contentView.bounds.insetBy(dx: 0, dy: 2) // inset top/bottom
        
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        
        presenter?.createRectangle(with: contentView.frame)
        sendMessageBttn.layer.cornerRadius = 5.0
        nameTextView.layer.cornerRadius = 5.0
        emailTextView.layer.cornerRadius = 5.0
        messageTextView.layer.cornerRadius = 5.0
        
        presenter?.updateViews()
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
extension SendMessageViewController:SendMessagePresenterToViewProtocol{
    
    
    func showNetworkError(with text: String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertForSendingFeedback() {
        let alert = UIAlertController(
            title: "Thank you...",
            message:
            "your opinion will arrive to admin.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.presenter?.updateTabBarController()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func changeShadowPath(with path: CGPath) {
        contentView.layer.shadowPath = path
    }
    
    
    
}
