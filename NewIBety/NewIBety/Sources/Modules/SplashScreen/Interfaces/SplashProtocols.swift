//
//  SplashProtocols.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

protocol SplashPresenterToViewProtocol: class {
    func updateView(with slide:slide , index:Int)
}

protocol SplashViewToPresenterProtocol: class {
    var view: SplashPresenterToViewProtocol? {get set};
    var router: SplashPresenterToRouterProtocol? {get set}
    func viewDidAppear(with splashImageView:UIImageView);
    func viewDidDisappear()
    func viewDidLoad()
}

protocol SplashPresenterToRouterProtocol: class {
    
    var presenter:SplashViewToPresenterProtocol?{get set}
    static func createModule(view:ViewController2);
}
