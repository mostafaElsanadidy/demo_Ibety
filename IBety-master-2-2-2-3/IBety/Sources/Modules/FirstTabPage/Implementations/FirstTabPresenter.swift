//
//  FirstTabPresenter.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation

class FirstTabPresenter:FirstTabViewToPresenterProtocol {
    func performSegueUsingService(identifier: String, with cell: MYPARTSCollectionViewCell, selectedCategoryIndex: Int) {
        interector?.displayCategoryProjectsService(identifier: identifier, with: cell, selectedCategoryIndex: selectedCategoryIndex)
    }
    
    
    var interector: FirstTabPresentorToInterectorProtocol?
    var router: FirstTabPresenterToRouterProtocol?
    var view: FirstTabPresenterToViewProtocol?
    
    func updatePageName_UserDefault(with value: String) {
        interector?.updatePageName_UserDefault(with: value)
    }
    
    
    func updateCollectionView() {
        
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? FirstTABViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        interector?.displayCategoriesService()
    }
    
    func dissmissViewController() {
        router?.dissmissViewController()
    }
    
 
    func displayCellImage(for cell: MYPARTSCollectionViewCell, with data: Data) {
        view?.displayCellImage(for: cell, with: data)
    }
    
    func changeCellImage(for cell: MYPARTSCollectionViewCell, with item: categoriesData) {
        interector?.displayCellImageService(for: cell, with: item)
    }
    
}

extension FirstTabPresenter:FirstTabInterectorToPresenterProtocol{
    func show_Error(errorMessageText: String) {
        view?.show_Error(errorMessageText: errorMessageText)
    }
    
    func performSegue(identifier: String) {
        router?.performSegue(identifier: identifier)
    }
    
    func reloadCollectionViewByService(displayedCategories: CategoryResult) {
        view?.reloadCollectionViewByService(displayedCategories: displayedCategories)
    }
    
    
}
