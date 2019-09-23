//
//  ProjectDetailsViewController.swift
//  IBety
//
//  Created by Mohamed on 7/16/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire


class ProjectDetailsViewController: UIViewController {

   // @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var projectIntroLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var IntroTextView: UITextView!
    
    
//    @IBOutlet weak var topConstraint: NSLayoutConstraint!
//    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
  //  @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    var presenter:ProjectDetailsViewToPresenterProtocol!
    
    var displayedProjectDetails=projectCreationData(){
        
        didSet{
            let projectData = self.displayedProjectDetails
        
            self.textView1.text = projectData.name!
            self.IntroTextView.text = projectData.description!
            
           presenter?.displayProjectImage(with: projectData.media!.image!.conversions!.thumb!)
    }
 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         ProjectDetailsPresenterRouter.createModule(view: self)
        scrollView.isScrollEnabled = false
        
//        self.view.layer.cornerRadius = 10
//        self.view.layer.shadowOpacity = 0.3
        logoImageView.layer.cornerRadius = 10
        textView1.layer.cornerRadius = 10
        textView1.layer.shadowOpacity = 0.3
        IntroTextView.layer.cornerRadius = 10
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true

        }
       // self.logoImageView.image
        
        
        // Do any additional setup after loading the view.
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        let views = [projectIntroLabel,IntroTextView,scrollView,contentView]
        
        presenter?.adjustUITextViewHeight(arg: textView1, by: views as! [UIView])
        presenter?.adjustUITextViewHeight(arg: IntroTextView, by: views as! [UIView])
        

        contentView.layer.shadowPath = contentView.createRectangle()
        
//            containerView.layer.cornerRadius = 10
//            containerView.layer.shadowOpacity = 0.3
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        containerView.layer.shadowOpacity = 0
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

extension ProjectDetailsViewController:ProjectDetailsPresenterToViewProtocol{
    
    
    func updateProjectImage(with data: Data) {
        
        self.logoImageView.isHidden = false
        self.logoImageView.image = UIImage(data: data)?.resized_Image(withBounds: self.logoImageView.bounds.size)
    }
    
    func updateView(with displayedProjectDetails: projectCreationData) {
        self.displayedProjectDetails = displayedProjectDetails
    }
    
    
    
}
