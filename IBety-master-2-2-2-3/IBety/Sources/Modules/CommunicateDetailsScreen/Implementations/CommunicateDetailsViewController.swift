//
//  CommunicateDetailsViewController.swift
//  IBety
//
//  Created by Mohamed on 7/16/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class CommunicateDetailsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var emailTextView: UITextView!
    
    var presenter:CommunicateDetailsViewToPresenterProtocol!
    
    var displayedProjectDetails=projectCreationDetails(){
        
        didSet{
            let projectData = self.displayedProjectDetails.data!
            
            addressTextView.text = projectData.address ?? ""
            phoneTextView.text = projectData.owner!.phone_number ?? ""
            emailTextView.text = projectData.owner!.email ?? ""
            view.hideSpinner(tag: 1001)
        }
    }
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        CommunicateDetailsRouter.createModule(view: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
     //  contentView.layer.shadowOffset = CGSize.init(width: 5.0, height: 5.0)
        //contentView.layer.shadowOffset = CGSize.init(width: -5.0, height: 0.0)
//        contentView.layer.shadowRadius = 4.0
//        
//       // let shadowRect = contentView.bounds.insetBy(dx: 0, dy: 2) // inset top/bottom
//        contentView.layer.shadowPath = createRectangle(with: contentView.bounds)
        
        contentView.layer.shadowRadius = 0.1
        contentView.layer.shadowPath = contentView.createRectangle()
        
       
    }
    
}

extension CommunicateDetailsViewController:CommunicateDetailsPresenterToViewProtocol{
    
    func updateTitleView(with displayedProjectDetails: projectCreationDetails) {
        self.displayedProjectDetails = displayedProjectDetails
    }
    
}
