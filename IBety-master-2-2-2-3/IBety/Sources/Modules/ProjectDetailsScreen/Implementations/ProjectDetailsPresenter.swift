//
//  ProjectDetailsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class ProjectDetailsPresenter: ProjectDetailsViewToPresenterProtocol{
    
    var interector: ProjectDetailsPresentorToInterectorProtocol?
    var router: ProjectDetailsPresenterToRouterProtocol?
    var view: ProjectDetailsPresenterToViewProtocol?
    
    func displayProjectImage(with urlStr: String) {
        interector?.displayProjectImage(with: urlStr)
    }
    
    func adjustUITextViewHeight(arg: UITextView, by views: [UIView]) {
        let frame = arg.frame
        let scrollView = views[2] as! UIScrollView
        let contentView = views[3]
        
        arg.sizeToFit()
        
        arg.isScrollEnabled = false
        arg.frame.size = CGSize(width: frame.width, height: arg.contentSize.height)
       
        if arg.tag == 505{
            views[0].frame.origin.y += arg.frame.size.height - frame.height
            views[1].frame.origin.y += arg.frame.size.height - frame.height
        }
        
        let frame2 = contentView.frame
        contentView.sizeToFit()
        
        contentView.frame.size = CGSize.init(width: frame2.width, height: contentView.frame.height)
      //  scrollView.frame.size.height += arg.frame.height - frame.height
    }
    
    func viewWillAppear() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ProjectDetailsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayProjectDetails()
    }
}

extension ProjectDetailsPresenter:ProjectDetailsInterectorToPresenterProtocol{
    
    
    func updateView(with displayedProjectDetails: projectCreationData) {
        view?.updateView(with: displayedProjectDetails)
    }
    
    func updateProjectImage(with data: Data) {
        view?.updateProjectImage(with: data)
    }
    
    
}
