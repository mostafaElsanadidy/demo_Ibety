//
//  UserProductsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit

class UserProductsPresenter:UserProductsViewToPresenterProtocol {
    var view: UserProductsPresenterToViewProtocol?
    
    var interector: UserProductsPresentorToInterectorProtocol?
    
    var router: UserProductsPresenterToRouterProtocol?
    func changeCellImage(for cell: ProductCollectionViewCell, with item: product_Data_) {
        interector?.displayCellImageService(for: cell, with: item)
    }
    
    func showNetworkError(errorMessageText: String) {
        view?.showNetworkError(errorMessageText: errorMessageText)
    }
    func updateCollectionView() {
        interector?.displayedProjectDetails()
    }
    
    func updateCollectionViewUseingService() {
        
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? UserProductsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayUserProductsService()
    }
    
    func reloadCollectionView(displayProjectDetails: projectCreationDetails) {
        view?.reloadCollectionView(displayProjectDetails: displayProjectDetails)
    }
    
    func reloadCollectionViewByService(displayProductsDetails: [product_Data_]) {
        view?.reloadCollectionViewByService(displayProductsDetails: displayProductsDetails)
    }
    
    
}

extension UserProductsPresenter:UserProductsInterectorToPresenterProtocol{
    
    
    func displayCellImage(for cell: ProductCollectionViewCell, with data: Data) {
        view?.displayCellImage(for: cell, with: data)
    }
    
    
    
}
