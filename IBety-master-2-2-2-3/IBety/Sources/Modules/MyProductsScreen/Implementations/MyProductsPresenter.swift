//
//  MyProductsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class MyProductsPresenter: MyProductsViewToPresenterProtocol {
    
    var router: MyProductsPresenterToRouterProtocol?
    var view: MyProductsPresenterToViewProtocol?
    var interector: MyProductsPresentorToInterectorProtocol?
    var collectionView:UICollectionView!
    var cell:ProductCollectionViewCell!
    
    var displayedProductsDetails: [product_Data_]?
    var selectedIndexOfCell: Int?
    
    func displayProducts() {
        interector?.displayProducts()
    }
    
    
    func deleteProduct() {
        interector?.deleteProduct(with: selectedIndexOfCell!)
    }
    
    func performSegue(withIdentifier: String) {
        router?.performSegue(withIdentifier: withIdentifier)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue) {
        router?.prepareForSegue(segue: segue)
    }
    
    func updateView() {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? MyProductViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        interector?.displayMyProductsService()
    }
    
    func receiveUserDefaultsValue(value: Int) {
        view?.receiveProjectID(value: value)
    }
    
    func changeCellImage(cell: ProductCollectionViewCell, with imageUrlStr: String) {
        self.cell = cell
        interector?.changeCellImage(with: imageUrlStr)
    }
    
    func cancelPage() {
        router?.cancelPage()
    }
    
    func addGestureRecognizer(for collectionView: UICollectionView) {
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(selectIndexOfProductID))
        gestureRecognizer.cancelsTouchesInView = false
        self.collectionView = collectionView
        collectionView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectIndexOfProductID(_ gestureRecognizer: UIGestureRecognizer) {
        let point = gestureRecognizer.location(in: collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: point){
            // selectedIndexOfCell = (indexPath.section*Int(itemsPerRow))+(indexPath.row)
            
            selectedIndexOfCell = indexPath.row
            view?.changeSelectedIndexOfCell(with: selectedIndexOfCell!)
            print("\(indexPath.row) &&&&&&&&&&&&&&& ")
        }
    }
    
    
}

extension MyProductsPresenter:MyProductsInterectorToPresenterProtocol{
    
    func showDeletionAlert() {
    
        view?.showDeletionAlert()
    }
    
    func displayCellImage(with data: Data) {
        view?.displayCellImage(cell: cell, with: data)
    }
    
    func changeCollectionView(with displayedProductsDetails: [product_Data_]?) {
        self.displayedProductsDetails = displayedProductsDetails
        view?.changeCollectionView(with: displayedProductsDetails)
    }
    
    func changeTitleView(with displayedProjectDetails: projectCreationData) {
        view?.changeTitleView(with: displayedProjectDetails)
    }
    
    func showNetworkError(with errorMessageText: String) {
        view?.showNetworkError(with: errorMessageText)
    }
    
    func showNetworkError() {
        view?.showNetworkError()
    }
}
