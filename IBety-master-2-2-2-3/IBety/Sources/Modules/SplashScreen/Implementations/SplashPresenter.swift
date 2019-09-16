//
//  SplashPresenter.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class splashPresenter: SplashViewToPresenterProtocol {
    
    var router: SplashPresenterToRouterProtocol?
    var view: SplashPresenterToViewProtocol?
    
    var timer = Timer()
    var splashImageView:UIImageView!
    var i = 0
    var ind = 0
    
    var slides:[slide] = []
    
    @objc func didTimeOut() {
        
        UIView.transition(with: splashImageView, duration: 0.8, options: .transitionCrossDissolve, animations: {
            
            self.view?.updateView(with: self.slides[self.ind], index: self.ind)
            
        }, completion: nil)
        
        if i == 0{
            ind += 1}
        else{
            ind -= 1}
        if ind == slides.count-1{
            i = 1
        }
        if ind == 0{
            i = 0
        }
        
        //performSegue(withIdentifier: "projectDetails", sender: nil)
    }
    
    func createSlides(){
        
        slides = []
        let slide1 = slide.init(photoName: "index0", title: "Add Your Project", description: "Did you know that Winnie the chubby little cubby was based on a real, young bear in London")
        
        slides.append(slide1)
        
        let slide2 = slide.init(photoName: "index1", title: "Display Your Project", description: "Did you know that Winnie the chubby little cubby was based on a real, young bear in London")
        
        slides.append(slide2)
        
        let slide3 = slide.init(photoName: "index2", title: "Win Your Project", description: "Did you know that Winnie the chubby little cubby was based on a real, young bear in London")
        
        slides.append(slide3)
    }
    
    func viewDidLoad() {
        
        createSlides()
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ViewController2{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        view?.updateView(with: slides[0], index: 0)
    }
    
    func viewDidAppear(with splashImageView:UIImageView) {
        
        self.splashImageView = splashImageView
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                     selector: #selector(didTimeOut), userInfo: nil, repeats: true)
    }
    
    func viewDidDisappear() {
     
        timer.invalidate()
    }
}
