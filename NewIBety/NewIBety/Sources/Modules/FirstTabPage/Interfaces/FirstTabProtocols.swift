//
//  FirstTabProtocols.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol FirstTabPresenterToViewProtocol: class {
    
    func reloadCollectionViewByService(displayedCategories:CategoryResult)
    func show_Error(errorMessageText:String)
    func displayCellImage(for cell:MYPARTSCollectionViewCell, with data:Data)
}

protocol FirstTabInterectorToPresenterProtocol: class {
 
    func displayCellImage(for cell:MYPARTSCollectionViewCell, with data:Data)
    func reloadCollectionViewByService(displayedCategories:CategoryResult)
    func show_Error(errorMessageText:String)
    func performSegue(identifier:String)
  //  func postNotificationUsingCell(cell:MYPARTSCollectionViewCell)
}

protocol FirstTabPresentorToInterectorProtocol: class {
    var presenter: FirstTabInterectorToPresenterProtocol? {get set} ;
    func displayCategoriesService()
    func updatePageName_UserDefault(with value:String)
    func displayCellImageService(for cell:MYPARTSCollectionViewCell, with item: categoriesData)
    func displayCategoryProjectsService(identifier:String , with cell:MYPARTSCollectionViewCell , selectedCategoryIndex:Int)
}

protocol FirstTabViewToPresenterProtocol: class {
    var view: FirstTabPresenterToViewProtocol? {get set};
    var interector: FirstTabPresentorToInterectorProtocol? {get set};
    var router: FirstTabPresenterToRouterProtocol? {get set}
    //func updateView();
    func updateCollectionView();
    func updatePageName_UserDefault(with value:String)
    func changeCellImage(for cell:MYPARTSCollectionViewCell, with item: categoriesData)
    func dissmissViewController()
    func performSegueUsingService(identifier:String , with cell:MYPARTSCollectionViewCell , selectedCategoryIndex:Int)
}

protocol FirstTabPresenterToRouterProtocol: class {
    
    var presenter:FirstTabViewToPresenterProtocol?{get set}
    static func createModule(viewController:FirstTABViewController);
    func dissmissViewController()
    func performSegue(identifier:String)
    
}
