//
//  PartsCollectionPresenter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class PartsCollectionPresenter:PartsCollectionViewToPresenterProtocol{
    
    var view: PartsCollectionPresenterToViewProtocol?
    var router: PartsCollectionPresenterToRouterProtocol?
    var interector: PartsCollectionPresentorToInterectorProtocol?
    
    func displayCategoryProjects(with selectedIndex: Int, for cell: MYPARTSCollectionViewCell) {
        interector?.displayCategoryProjects(with: selectedIndex, for: cell)
    }
    
    func updateCollectionView() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? PartsCollectionViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        interector?.updateCollectionView()
    }
    
    
    func popViewController() {
        
        router?.popViewController()
    }
    
    func changeCellImage(for cell: MYPARTSCollectionViewCell, with item: CategoryProjectsData) {
        interector?.displayCellImageService(for: cell, with: item)
    }
    
    func displayCellImage(for cell: MYPARTSCollectionViewCell, with data: Data) {
        view?.displayCellImage(for: cell, with: data)
    }
}



extension PartsCollectionPresenter:PartsCollectionInterectorToPresenterProtocol{
    
    
    func showError() {
        view?.showError()
    }
    
    
    func updateCollectionView(with categoryProjects: CategoryProjects) {
        view?.updateCollectionView(with: categoryProjects)
    }
    
    func updateTitleView(with image: UIImage, name: String) {
        view?.updateTitleView(with: image, name: name)
    }
    
    func performSegue(identifier: String) {
        router?.performSegue(identifier: identifier)
    }
}
