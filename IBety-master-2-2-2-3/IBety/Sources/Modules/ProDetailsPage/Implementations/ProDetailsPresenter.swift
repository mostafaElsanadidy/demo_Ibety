//
//  ProDetailsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//


import UIKit

class ProDetailsPresenter:ProDetailsViewToPresenterProtocol{
    
    
    var interector: ProDetailsPresentorToInterectorProtocol?
    var router: ProDetailsPresenterToRouterProtocol?
    var view: ProDetailsPresenterToViewProtocol?
    
    func updateViews() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ProDetailsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    func popViewController() {
        router?.popViewController()
    }
    
    func displayProjectData(projectID: Int) {
        interector?.alamofireDisplayedData(projectID: projectID)
    }
    
    func instantiateViewController() {
        router?.instantiateViewController()
    }
    
    func addChildViewController(with Identifier: String, isVertical: Bool, in contentView:UIView) {
        router?.addChildViewController(with: Identifier, isVertical: isVertical, in: contentView)
    }
    
    func addChildViewController(with Identifier: String, in contentView: UIView) {
        router?.addChildViewController(with: Identifier, in: contentView)
    }
    
    func searchProject(with name: String) {
        interector?.searchProject(with: name)
    }
    
    func changeCellImage(with item: DisplayedSearchedProductsData) {
        interector?.displayCellImageService(with: item)
    }
    
}

extension ProDetailsPresenter:ProDetailsInterectorToPresenterProtocol{
    
    
    func updateTitleView(with image: UIImage, name: String) {
        view?.updateTitleView(with: image, name: name)
    }
    
    func displayCellImage(with data: Data) {
        view?.displayCellImage(with: data)
    }
    
    func showNetworkError(with text: String) {
        view?.showNetworkError(with: text)
    }
    
    
    func updateView(with projectData: [DisplayedSearchedProductsData]) {
        view?.updateView(with: projectData)
    }
}
