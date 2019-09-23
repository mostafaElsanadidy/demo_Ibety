//
//  FourTabViewController.swift
//  IBety
//
//  Created by Mohamed on 7/16/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class FourTabViewController: UIViewController {

    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var save_cancelStackView: UIStackView!
//    @IBOutlet weak var productAddStackView: UIStackView!
    @IBOutlet weak var demoView: UIView!
    var presenter:FourTabViewToPresenterProtocol!
    var displayMyProject=projectCreationData(){
        didSet{
            titleLabel.text = self.displayMyProject.name!
        }
    }
    
    var isProInfo = true
    var iscommunicateInfo = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FourTabRouter.createModule(view: self)
         presenter?.viewDidLoad()
    }
    
    
    
    @IBAction func action() {
        
        
    }
    
        override func viewDidLayoutSubviews() {
    
            super.viewDidLayoutSubviews()
            if isProInfo{
                
            infoLabel.text = "Project Info".localized
            presenter?.moveBttnToPage(index: 1)
            }
            else if iscommunicateInfo{
            
                infoLabel.text = "Communication Info".localized
                presenter?.moveBttnToPage(index: 3)
            }
            else{
                
                infoLabel.text = "Project Products".localized
                presenter?.moveBttnToPage(index: 2)
            }
    }
    
   
    
    
    @IBAction func cancelPage() {
   
            presenter?.cancelPage()
        
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

extension FourTabViewController:FourTabPresenterToViewProtocol{
    func displayMyProject(with data: projectCreationData) {
        self.displayMyProject = data
    }
}
