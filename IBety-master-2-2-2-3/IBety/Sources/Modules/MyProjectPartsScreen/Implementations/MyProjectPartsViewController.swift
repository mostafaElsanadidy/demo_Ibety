//
//  MyProjectPartsViewController.swift
//  IBety
//
//  Created by Mohamed on 7/15/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import SSCustomTabbar
import Alamofire
import DropDown
import SwiftyJSON

class MyProjectPartsViewController: UIViewController {

    @IBOutlet weak var projectInfoBttn: UIButton!
    @IBOutlet weak var projectProductsBttn: UIButton!
    @IBOutlet weak var communicateInfoBttn: UIButton!
    @IBOutlet weak var searchTextView: UITextView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    var presenter:MyProjectPartsViewToPresenterProtocol!
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyProjectPartsRouter.createModule(view: self)
        dropDown.anchorView = searchTextView
        dropDown.dataSource = [""]
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        searchTextView.isHidden = true
        projectInfoBttn.layer.shadowOpacity = 0.1
        projectInfoBttn.layer.cornerRadius = 5
        projectInfoBttn.layer.shadowPath = projectInfoBttn.createRectangle()
        
        projectProductsBttn.layer.shadowOpacity = 0.09
        projectProductsBttn.layer.cornerRadius = 5
        
        communicateInfoBttn.layer.shadowOpacity = 0.09
        communicateInfoBttn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dicOfUpdateProject = [:]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        projectInfoBttn.layer.shadowPath = projectInfoBttn.createRectangle()
        communicateInfoBttn.layer.shadowPath = communicateInfoBttn.createRectangle()
        projectProductsBttn.layer.shadowPath = projectProductsBttn.createRectangle()
        presenter?.updateView()
    }
    
    
    @IBAction func projectInfoOnClicked() {
        
        presenter?.moveBttnToPage(num: 1)
    }
    
    @IBAction func projectProductsOnClicked() {
        
        presenter?.moveBttnToPage(num: 2)
    }
    
    @IBAction func comunicateInfoOnClicked() {
        
        presenter?.moveBttnToPage(num: 3)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelPage() {
        
        presenter?.moveBttnToPage(num: 0)
    }
    
}

extension MyProjectPartsViewController:MyProjectPartsPresenterToViewProtocol{
    
    
    func showNetworkError(with text: String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(errorMessageText). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func changeTitleView(with title: String) {
        
        self.projectInfoBttn.isHidden = false
        self.projectProductsBttn.isHidden = false
        self.communicateInfoBttn.isHidden = false
        self.view.hideSpinner(tag: 1000)
        self.projectNameLabel.text = title
    }
    
    
    func hideViews() {
        
        self.projectInfoBttn.isHidden = true
        self.projectProductsBttn.isHidden = true
        self.communicateInfoBttn.isHidden = true
        self.view.showSpinner(tag: 1000)
    }
    
    
    
}

extension String {
    var fixedArabicURL: String?  {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed
            .union(CharacterSet.urlPathAllowed)
            .union(CharacterSet.urlHostAllowed))
    } }
