//
//  ProductViewProtocols.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol ProductViewPresenterToViewProtocol: class {
 
    func updateSelectedImage(with image:UIImage)
}

protocol ProductViewInterectorToPresenterProtocol: class {
    
}

protocol ProductViewPresentorToInterectorProtocol: class {
    var presenter: ProductViewInterectorToPresenterProtocol? {get set} ;
    
}

protocol ProductViewViewToPresenterProtocol: class {
    var view: ProductViewPresenterToViewProtocol? {get set};
    var interector: ProductViewPresentorToInterectorProtocol? {get set};
    var router: ProductViewPresenterToRouterProtocol? {get set}
    func moveBttn()
    func updateViews()
    func uploadPhotos(with imageViewFrame:CGRect)
}

protocol ProductViewPresenterToRouterProtocol: class {
    
    var presenter:ProductViewViewToPresenterProtocol?{get set}
    static func createModule(view:ProductViewController);
    func instantiateViewController(with identifier:String) -> UIViewController
}

