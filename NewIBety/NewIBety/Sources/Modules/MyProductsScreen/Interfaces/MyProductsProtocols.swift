//
//  MyProductsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol MyProductsPresenterToViewProtocol:class {
    
    func changeSelectedIndexOfCell(with selectedIndex:Int)
    func changeTitleView(with displayedProjectDetails:projectCreationData)
    func changeCollectionView(with displayedProductsDetails:[product_Data_]?)
    func showNetworkError(with errorMessageText:String)
    func showNetworkError()
    func displayCellImage(cell:ProductCollectionViewCell,with data:Data)
    func receiveProjectID(value:Int)
    func showDeletionAlert()
}

protocol MyProductsInterectorToPresenterProtocol: class {
    
    func changeTitleView(with displayedProjectDetails:projectCreationData)
    func changeCollectionView(with displayedProductsDetails:[product_Data_]?)
    func showNetworkError(with errorMessageText:String)
    func showNetworkError()
    func displayCellImage(with data:Data)
    func receiveUserDefaultsValue(value:Int)
    func showDeletionAlert()
}

protocol MyProductsPresentorToInterectorProtocol: class {
    var presenter: MyProductsInterectorToPresenterProtocol? {get set} ;
    
    func displayMyProductsService()
    func changeCellImage(with imageUrlStr:String)
    func deleteProduct(with selectIndex:Int)
    func displayProducts()
}

protocol MyProductsViewToPresenterProtocol: class {
    var view: MyProductsPresenterToViewProtocol? {get set};
    var interector: MyProductsPresentorToInterectorProtocol? {get set};
    var router: MyProductsPresenterToRouterProtocol? {get set}
    var displayedProductsDetails:[product_Data_]?{get set}
    var selectedIndexOfCell:Int?{get set}
    
    func updateView();
    func cancelPage()
    func addGestureRecognizer(for collectionView:UICollectionView)
    func changeCellImage(cell:ProductCollectionViewCell,with imageUrlStr:String)
    func prepareForSegue(segue:UIStoryboardSegue)
    func performSegue(withIdentifier: String)
    func deleteProduct()
    func displayProducts()
}

protocol MyProductsPresenterToRouterProtocol: class {
    
    
    var presenter:MyProductsViewToPresenterProtocol?{get set}
    static func createModule(view:MyProductViewController);
    func cancelPage()
    func prepareForSegue(segue:UIStoryboardSegue)
    func performSegue(withIdentifier: String)
}
