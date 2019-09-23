//
//  ProductAdditionProtocols.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol ProductAdditionPresenterToViewProtocol: class {
    
    func showNetworkError()
    func showNetworkError(with text:String)
    func changePhotoImageView(with image:UIImage)
    func updateViews(with productData:displayedProductData)
    func displayProductImage(with data:Data)
    func showUpdateAlert()
    }

protocol ProductAdditionInterectorToPresenterProtocol: class {
    
    func showNetworkError()
    func showNetworkError(with text:String)
    func updateViews(with productData:displayedProductData)
    func displayProductImage(with data:Data)
    func showUpdateAlert()
    func dismissViewController()
}

protocol ProductAdditionPresentorToInterectorProtocol: class {
    var presenter: ProductAdditionInterectorToPresenterProtocol? {get set} ;
    func displayProductService(with index:Int);
    func addNewProductService()
    func updateProductService(selectedIndex:Int)
}

protocol ProductAdditionViewToPresenterProtocol: class {
    var view: ProductAdditionPresenterToViewProtocol? {get set};
    var interector: ProductAdditionPresentorToInterectorProtocol? {get set};
    var router: ProductAdditionPresenterToRouterProtocol? {get set}
    
    func viewDidLoad()
    func displayProduct(with index:Int);
    func updateDictionanry(value:String,with key:String)
    func takeProductPhotos(with photoImageViewFrame:CGRect)
    func dismissViewController()
    func addNewProduct()
    func updateProduct(selectedIndex:Int)
}

protocol ProductAdditionPresenterToRouterProtocol: class {
    
    var presenter:ProductAdditionViewToPresenterProtocol? {get set}
    static func createModule(view:ProductAdditionViewController);
    func dismissViewController()
}


