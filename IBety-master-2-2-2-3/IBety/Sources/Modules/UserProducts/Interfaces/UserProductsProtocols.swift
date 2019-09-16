//
//  UserProductsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

protocol UserProductsPresenterToViewProtocol: class {
    func reloadCollectionView(displayProjectDetails:projectCreationDetails)
    func reloadCollectionViewByService(displayProductsDetails:[product_Data_])
   // func changeSelectIndexPath(selectedIndex:Int)
    func displayCellImage(for cell:ProductCollectionViewCell, with data:Data)
    func showNetworkError(errorMessageText:String)
}

protocol UserProductsInterectorToPresenterProtocol: class {
    func reloadCollectionView(displayProjectDetails:projectCreationDetails)
    func reloadCollectionViewByService(displayProductsDetails:[product_Data_])
    func displayCellImage(for cell:ProductCollectionViewCell, with data:Data)
    func showNetworkError(errorMessageText:String)
}

protocol UserProductsPresentorToInterectorProtocol: class {
    var presenter:UserProductsInterectorToPresenterProtocol? {get set} ;
    func displayedProjectDetails()
    func displayUserProductsService()
    func displayCellImageService(for cell:ProductCollectionViewCell, with item: product_Data_)
}

protocol UserProductsViewToPresenterProtocol: class {
    var view: UserProductsPresenterToViewProtocol? {get set};
    var interector: UserProductsPresentorToInterectorProtocol? {get set};
    var router: UserProductsPresenterToRouterProtocol? {get set}
    func updateCollectionView();
    func updateCollectionViewUseingService()
 //   func findIndexPath(of gesture:UIGestureRecognizer,in collectionViw:UICollectionView)
    func changeCellImage(for cell:ProductCollectionViewCell, with item: product_Data_)
}

protocol UserProductsPresenterToRouterProtocol: class {
    var presenter:UserProductsViewToPresenterProtocol?{get set}
    static func createModule(view:UserProductsViewController);
}

