//
//  MyDetailsViewController.swift
//  IBety
//
//  Created by Mohamed on 7/1/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import SSCustomTabbar
import Alamofire

class MyDetailsViewController: UIViewController {

    @IBOutlet weak var projectStackView: UIStackView!
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var communicateStackView: UIStackView!
    @IBOutlet weak var advertisingStackView: UIStackView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logOutBttn: UIButton!
    
    var presenter:MyDetailsViewToPresenterProtocol!
    
    @IBOutlet weak var ownerView: UIView!
    @IBOutlet weak var languageVisitorView: UIView!
    var indexOfPage:Int!
    @IBOutlet weak var profileCustomerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //indexOfPage = 0
        
        MyDetailsRouter.createModule(view: self)
        
        presenter?.displayApplicationSettings()
        if indexOfPage == 0{
            mainView.bringSubviewToFront(languageVisitorView)
        }
        if indexOfPage == 1
        {mainView.bringSubviewToFront(profileCustomerView)}
        if indexOfPage == 2{
            mainView.bringSubviewToFront(ownerView)
        }
        
        presenter?.updatePageName_UserDefault(with: "MyDetailsViewController")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBttnAction() {
        
        presenter?.cancelPage()
    }
    
    @IBAction func logOutAction() {
        
        presenter?.logout()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var frames:[CGRect]
        if indexOfPage == 0{
            frames = [
                projectStackView.frame
                , profileStackView.frame
                , languageStackView.frame
                , detailStackView.frame]
            
        }
        else if indexOfPage == 1{
            frames = [
                projectStackView.frame
                , profileStackView.frame
                , languageStackView.frame
                , detailStackView.frame
                , communicateStackView.frame
            ]
        }else{
            frames = [
                projectStackView.frame
                , profileStackView.frame
                , languageStackView.frame
                , detailStackView.frame
                , communicateStackView.frame
                , advertisingStackView.frame]
        }
        presenter?.drawPathLine(by: frames)
    }
    
    @IBAction func moveToMyProject() {
        
        presenter?.moveToMyProject()
    }
    
    
    @IBAction func moveToProfilePersonly() {
        presenter?.moveToProfilePersonly()
    }
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBAction func languageBttnAction() {
        
        presenter?.moveToPage(indexOfPage: 1)
    }
    
    
    
    @IBAction func aboutApplicationAction() {
       
        presenter?.moveToPage(indexOfPage: 2)
       }
    
    @IBAction func continueWithUsAction() {
        
        presenter?.moveToPage(indexOfPage: 3)
    }
    
    @IBAction func advertisingInfoBttnAction() {
        
        presenter?.moveToPage(indexOfPage: 4)
    }
    
    @IBAction func suggestionBttnAction() {
        
       presenter?.moveToPage(indexOfPage: 5)
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

extension MyDetailsViewController:MyDetailsPresenterToViewProtocol{
    
    func updateMainView(with shapeLayer: CAShapeLayer) {
        mainView.layer.addSublayer(shapeLayer)
    }
    
    func showNetworkError(witth text:String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
