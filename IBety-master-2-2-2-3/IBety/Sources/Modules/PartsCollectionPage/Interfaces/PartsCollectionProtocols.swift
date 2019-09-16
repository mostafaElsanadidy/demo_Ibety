//
//  PartsCollectionPresenter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

import UIKit

protocol PartsCollectionPresenterToViewProtocol: class {
    func showError();
    func updateTitleView(with image:UIImage , name:String);
    func updateCollectionView(with categoryProjects:CategoryProjects)
    func displayCellImage(for cell:MYPARTSCollectionViewCell, with data:Data)
}

protocol PartsCollectionInterectorToPresenterProtocol: class {
    //    func liveNewsFetched(news: LiveNewsModel);
    //    func liveNewsFetchedFailed();
    
    func showError();
    func updateTitleView(with image:UIImage , name:String);
    func updateCollectionView(with categoryProjects:CategoryProjects)
    func displayCellImage(for cell:MYPARTSCollectionViewCell, with data:Data)
    func performSegue(identifier:String)
}

protocol PartsCollectionPresentorToInterectorProtocol: class {
    var presenter: PartsCollectionInterectorToPresenterProtocol? {get set} ;
    //func updateTitleView();
    func updateCollectionView()
    func displayCategoryProjects(with selectedIndex:Int,for  cell:MYPARTSCollectionViewCell)
    func displayCellImageService(for cell:MYPARTSCollectionViewCell, with item: CategoryProjectsData)
}

protocol PartsCollectionViewToPresenterProtocol: class {
    var view: PartsCollectionPresenterToViewProtocol? {get set};
    var interector: PartsCollectionPresentorToInterectorProtocol? {get set};
    var router: PartsCollectionPresenterToRouterProtocol? {get set}
   // func updateTitleView();
    func popViewController()
    func updateCollectionView()
    func displayCategoryProjects(with selectedIndex:Int,for  cell:MYPARTSCollectionViewCell)
    func changeCellImage(for cell:MYPARTSCollectionViewCell, with item: CategoryProjectsData)
}

protocol PartsCollectionPresenterToRouterProtocol: class {
    
    var presenter:PartsCollectionViewToPresenterProtocol?{get set}
    static func createModule(view:PartsCollectionViewController)
    func popViewController()
    func performSegue(identifier:String)
}
