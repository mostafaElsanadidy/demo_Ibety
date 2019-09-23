//
//  ParentViewPresenter.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//


import UIKit

class ParentViewPresenter: ParentViewViewToPresenterProtocol {
   
    func addChildViewController(childViewController: UIViewController) {
        router?.addChildViewController(childViewController: childViewController)
    }
    
    var selectedIndex: Int = 0
    
    var isUpdateState: Bool?
    
   
    var infoBttn = UIButton()
    var productsBttn = UIButton()
    var proDataBttn = UIButton()
    var titles:[String] = []
    
    func updateView(with bttns: [UIButton], titles: [String]) {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ParentViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        interector?.removeObjectFromUserDefaults(for: "ProjectID")
        userProject = project_Details()
        infoBttn = bttns[0]
        productsBttn = bttns[1]
        proDataBttn = bttns[2]
        self.titles = titles
        selectedIndex = 0
        updateButtons2(mainBttns: bttns, selectedIndex: 0)
    }
    
    
    var interector: ParentViewPresentorToInterectorProtocol?
    var router: ParentViewPresenterToRouterProtocol?
    var view: ParentViewPresenterToViewProtocol?
    
    func moveToPage(with index: Int) {
        
        selectedIndex = index
        updateButtons2(mainBttns: [infoBttn, productsBttn, proDataBttn], selectedIndex: index)
        if let ProjectInfoViewController = self.router?.instantiateViewController(with: "ViewController\(selectedIndex)"){
            UIView.animate(withDuration: 0){
                    self.router?.addChildViewController(childViewController: ProjectInfoViewController)
            }
        }
    }
    
    func swipeMade(_ sender: UISwipeGestureRecognizer) {
        
        let mainBttns:[UIButton] = [infoBttn, productsBttn, proDataBttn]
        var ProjectInfoViewController:UIViewController?
        if (sender.direction == .left && L102Language.currentAppleLanguage() == "ar") ||
            (sender.direction == .right && L102Language.currentAppleLanguage() == "en"){
            selectedIndex -= 1
            if selectedIndex < 0{
                selectedIndex = mainBttns.count-1
            }
        }
        else if (sender.direction == .right && L102Language.currentAppleLanguage() == "ar") ||
            (sender.direction == .left && L102Language.currentAppleLanguage() == "en"){
            
            selectedIndex += 1
            if selectedIndex == mainBttns.count{
                selectedIndex = 0
            }
        }
        
        
        ProjectInfoViewController = router?.instantiateViewController(with: "ViewController\(selectedIndex)")
        
        switch selectedIndex {
        case 0:
            ProjectInfoViewController = ProjectInfoViewController as? InfoViewController
            
            if let pro = ProjectInfoViewController as? InfoViewController
            {
                print("mostafaaghfcvghcjvsfyfghjvm")
                pro.isUpdateState = false
            }
            
        // createAccount.titleLabel?.text = "متابعة"
        case 1:
            ProjectInfoViewController = ProjectInfoViewController as? ProductViewController
            //createAccount.titleLabel?.text = "متابعة"
            
        default:
            ProjectInfoViewController = ProjectInfoViewController as? ProjectDataViewController
            //createAccount.titleLabel?.text = "إنشاء حساب"
            if let pro = ProjectInfoViewController as? ProjectDataViewController
            {
                pro.isUpdateState = false
            }
            
        }
        
        if let _ = ProjectInfoViewController?.restorationIdentifier?.contains("\(selectedIndex)"){
            updateButtons2(mainBttns: mainBttns, selectedIndex: selectedIndex)
        }
        UIView.animate(withDuration: 0){
            
            if let ProjectInfoViewController = ProjectInfoViewController{
                self.router?.addChildViewController(childViewController: ProjectInfoViewController)}
        }
        
    }
    
    
    func updateButtons2(mainBttns:[UIButton], selectedIndex:Int){
        
        for i in 0 ..< mainBttns.count{
            if i == selectedIndex{

                view?.selectBttn(bttn: mainBttns[i], index: i, title: titles[i])
            }
            else{
                
                view?.deselectBttn(bttn: mainBttns[i], index: i)
            }
        }
    }
    
    func createBezierPath() {
        
        var frame1 = CGRect()
        var frame2 = CGRect()
        var frame3 = CGRect()
        
        if L102Language.currentAppleLanguage() == "ar"{
            
            frame1 = proDataBttn.frame
            frame2 = productsBttn.frame
            frame3 = infoBttn.frame
            
        }else if L102Language.currentAppleLanguage() == "en"{
            
            frame1 = infoBttn.frame
            frame2 = productsBttn.frame
            frame3 = proDataBttn.frame
        }
        
        let x1 = frame1.width+frame1.origin.x
        let y1 = frame1.origin.y+frame1.height/2
        let x2 = frame2.origin.x
        let x3 = frame2.width+frame2.origin.x
        let x4 = frame3.origin.x
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x1, y: y1))
        path.addLine(to: CGPoint(x: x2, y: y1))
        
        path.move(to: CGPoint.init(x: x3, y: y1))
        path.addLine(to: CGPoint(x: x4, y: y1))
        
        //        let path2 = UIBezierPath(roundedRect: view.bounds, cornerRadius: 15.0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.8924478889, green: 0.8924478889, blue: 0.8924478889, alpha: 1)
        shapeLayer.fillColor = UIColor.brown.cgColor
        view?.changeShadowPath(with: shapeLayer)
    }
    
    func dismissViewController() {
        router?.dismissViewController()
    }
    
    
}
