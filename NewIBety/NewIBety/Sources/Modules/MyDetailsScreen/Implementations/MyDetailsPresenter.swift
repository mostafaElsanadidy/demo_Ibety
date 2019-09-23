//
//  MyDetailsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Foundation

class MyDetailsPresenter: MyDetailsViewToPresenterProtocol {
    
    var interector: MyDetailsPresentorToInterectorProtocol?
    var router: MyDetailsPresenterToRouterProtocol?
    var view: MyDetailsPresenterToViewProtocol?
    var indexOfPage = 0
    
    func displayApplicationSettings() {
        interector?.displayApplicationSettings()
    }
    
    func moveToPage(indexOfPage : Int) {
        
        self.indexOfPage = indexOfPage
        interector?.isBeforeLogin()
    }
    
    func logout() {
        interector?.updateOwnerUserDefaults()
        router?.moveToFirstViewController()
    }
    
    func cancelPage() {
       
        interector?.updatePageName_UserDefault(with: "FirstViewController")
        router?.moveToFirstViewController()
    }
    
    func moveToProfilePersonly() {
    
        interector!.displayProfilePersonly()
    }
    
    func updatePageName_UserDefault(with value: String) {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? MyDetailsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: [1,2,3,4])}
        }
        interector?.updatePageName_UserDefault(with: value)
    }
    
    func moveToMyProject() {
        interector?.displayMyProject()
    }
    
    func drawPathLine(by frames: [CGRect]) {
        
        let path = UIBezierPath()
        
        let x1 = frames[0].origin.x-12
        
        for frame in frames{
            
            let y1 = frame.origin.y+frame.height+10
            let x2 = x1+frame.width+10
            
            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x2, y: y1))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.8924478889, green: 0.8924478889, blue: 0.8924478889, alpha: 1)
        shapeLayer.fillColor = UIColor.brown.cgColor
        
        view?.updateMainView(with: shapeLayer)
    }
    
}

extension MyDetailsPresenter:MyDetailsInterectorToPresenterProtocol{
    
    func instantiateViewController(withIdentifier: String) {
        router?.instantiateViewController(withIdentifier: withIdentifier)
    }
    
    func showNetworkError(witth text: String) {
        view?.showNetworkError(witth: text)
    }
    
    func moveToProjectPartsPage() {
        router?.moveToProjectPartsPage()
    }
    
    func performSegue(withIdentifier: String) {
        router?.performSegue(withIdentifier: withIdentifier)
    }
    
    func updateTabBarViewController(with index: Int) {
        print(self.indexOfPage)
        router?.updateTabBarViewController(with: index, indexOpage: self.indexOfPage)
    }
}
