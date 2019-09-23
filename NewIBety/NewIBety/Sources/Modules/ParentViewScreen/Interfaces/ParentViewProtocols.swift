//
//  ParentViewProtocols.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol ParentViewPresenterToViewProtocol: class {
 
    func selectBttn(bttn:UIButton , index:Int , title:String)
    func deselectBttn(bttn:UIButton , index:Int)
    func changeShadowPath(with shapeLayer:CAShapeLayer)
}

protocol ParentViewInterectorToPresenterProtocol: class {
    
}

protocol ParentViewPresentorToInterectorProtocol: class {
    var presenter: ParentViewInterectorToPresenterProtocol? {get set} ;
    func removeObjectFromUserDefaults(for key:String)
}

protocol ParentViewViewToPresenterProtocol: class {
    var view: ParentViewPresenterToViewProtocol? {get set};
    var interector: ParentViewPresentorToInterectorProtocol? {get set};
    var router: ParentViewPresenterToRouterProtocol? {get set}
    
    var selectedIndex:Int{get set}
    var isUpdateState:Bool?{get set}
    
    func updateButtons2(mainBttns:[UIButton], selectedIndex:Int)
    func updateView(with bttns:[UIButton], titles:[String]);
    func createBezierPath()
    func dismissViewController()
    func swipeMade(_ sender: UISwipeGestureRecognizer)
    func moveToPage(with index:Int)
    func addChildViewController(childViewController: UIViewController)
}

protocol ParentViewPresenterToRouterProtocol: class {
    var presenter:ParentViewViewToPresenterProtocol? {get set}
    static func createModule(view:ParentViewController);
    func dismissViewController()
    func instantiateViewController(with identifier:String) -> UIViewController
    func addChildViewController(childViewController: UIViewController)
}

