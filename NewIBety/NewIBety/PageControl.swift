//
//  PageControl.swift
//  IBety
//
//  Created by Mohamed on 6/18/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//



import UIKit

class PageControl: UIPageControl {
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.v
//        pageControl.activeImage = UIImage(named: "active")!
//        pageControl.inactiveImage = UIImage(named: "inactive")!
//        pageControl.updateDots()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !subviews.isEmpty else { return }
        let spacing: CGFloat = 7
        let width: CGFloat = 25
        let height:CGFloat = 4
        var total: CGFloat = 0
        for view in subviews {
            view.layer.cornerRadius = 0.2
            view.frame = CGRect(x: total, y: frame.size.height / 2 - height / 2, width: width, height: height)
            total += width + spacing
        }
        total -= spacing
        frame.origin.x = frame.origin.x + frame.size.width / 2 - total / 2
        frame.size.width = total
    }
    
    
    
    
}

//enum ViewCategory : String {
//    case home = "home"
//    case info = "info"
//    case settings = "settings"
//    case interests = "interests"
//
//    func button() -> UIButton {
//        let button = UIButton()
//        button.setImage(UIImage(named:rawValue), for: .normal)
//
//        return button
//    }
//}
//
//protocol PageControlDelegate {
//    func selectedIndex(_ index:Int)
//}
//
//class PageControl : NSObject {
//
//    var scroll : UIScrollView?
//    var delegate : PageControlDelegate?
//
//    init(categories: [ViewCategory]) {
//        let array = categories.map({return $0.button()})
//
//        super.init()
//
//        array.forEach({ button in
//            button.addTarget(self, action: #selector(selected(sender:)), for: .touchUpInside)
//        })
//    }
//
//    func selectIndex(_ index:Int){
//        for button in (scroll?.subviews)! as! [UIButton] {
//            button.isSelected = true
//        }
//    }
//
//    @objc func selected(sender : UIButton){
//        for button in (scroll?.subviews)! as! [UIButton] {
//            button.isSelected = button == sender
//        }
//        delegate?.selectedIndex((scroll?.subviews.index(of: sender))!)
//    }
//
//}


