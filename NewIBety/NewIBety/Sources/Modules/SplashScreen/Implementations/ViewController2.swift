//
//  ViewController2.swift
//  IBety
//
//  Created by Mohamed on 6/17/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit


struct slide{
    
    var photoName:String!
    var title:String!
    var description:String!
}

class ViewController2: UIViewController{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var splashImageView: UIImageView!
    @IBOutlet weak var description_TextView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var presenter:SplashViewToPresenterProtocol!

    @IBOutlet weak var scrollView: UIScrollView!

   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
    
    // Do any additional setup after loading the view.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear(with: splashImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(pageControl)
        SplashRouter.createModule(view: self)
        presenter?.viewDidLoad()
    }
}

extension ViewController2:SplashPresenterToViewProtocol{
    
    func updateView(with slide:slide , index:Int) {
        if let image = UIImage.init(named: "\(slide.photoName!)"){
            self.splashImageView.image = image
            self.titleLabel.text = slide.title!.localized
            self.description_TextView.text = slide.description!.localized
            self.pageControl.currentPage = index
            print("\(slide.photoName!)")}
    }
}
