//
//  SearchProjectsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

protocol SearchPresenterToViewProtocol: class {
    
    func showNetworkError(with text : String)
    func showNetworkError()
    func updateCollectionView(with projectData:[DisplayedSearchedProductsData])
   
}

protocol SearchInterectorToPresenterProtocol: class {
    
    
    func showNetworkError(with text : String)
    func showNetworkError()
    func performSegue(identifier:String)
    func updateCollectionView(with projectData:[DisplayedSearchedProductsData])
}

protocol SearchPresentorToInterectorProtocol: class {
    var presenter: SearchInterectorToPresenterProtocol? {get set} ;
    func searchProject(with name:String)
   // func displayCellImageService(with item: DisplayedSearchedProductsData)
    func displayCategoryProjects(with selectedIndex:Int,for  cell:MYPARTSCollectionViewCell)
    func changeCellImage(for cell:MYPARTSCollectionViewCell , with item:DisplayedSearchedProductsData)
}

protocol SearchViewToPresenterProtocol: class {
    var view: SearchPresenterToViewProtocol? {get set};
    var interector: SearchPresentorToInterectorProtocol? {get set};
    var router: SearchPresenterToRouterProtocol? {get set}
    
    func searchProject(with name:String)
    func popViewController()
    func changeCellImage(for cell:MYPARTSCollectionViewCell , with item:DisplayedSearchedProductsData)
    func displayCategoryProjects(with selectedIndex:Int,for  cell:MYPARTSCollectionViewCell)
    func updateViews()
}

protocol SearchPresenterToRouterProtocol: class {
    
    var presenter: SearchViewToPresenterProtocol?{get set}
    static func createModule(view:SearchProjectsViewController);
    func popViewController()
    func performSegue(identifier:String)
}

