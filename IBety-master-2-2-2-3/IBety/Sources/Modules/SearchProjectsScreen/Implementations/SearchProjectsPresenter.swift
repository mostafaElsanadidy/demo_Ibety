//
//  SearchProjectsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class SearchProjectsPresenter:NSObject,SearchViewToPresenterProtocol{
    
    var view: SearchPresenterToViewProtocol?
    var interector: SearchPresentorToInterectorProtocol?
    var router: SearchPresenterToRouterProtocol?
    
    var cell:MYPARTSCollectionViewCell!
    var imagesData = [Data]()
    var isFirstTimeWritten = true
    var placeholderText1 = ""
    
    func updateViews() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? SearchProjectsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        interector?.searchProject(with: "")
    }
    
    
    func changeCellImage(for cell: MYPARTSCollectionViewCell, with item: DisplayedSearchedProductsData) {
        interector?.changeCellImage(for: cell, with: item)
    }
    
    func searchProject(with name: String) {
        
        interector?.searchProject(with: name)
    }
    
    func popViewController() {
        router?.popViewController()
    }
    
    func displayCategoryProjects(with selectedIndex: Int, for cell: MYPARTSCollectionViewCell) {
        interector?.displayCategoryProjects(with: selectedIndex, for: cell)
      }
   }

extension SearchProjectsPresenter:SearchInterectorToPresenterProtocol{
    
    func showNetworkError() {
        view?.showNetworkError()
    }
    func updateCollectionView(with projectData: [DisplayedSearchedProductsData]) {
        view?.updateCollectionView(with: projectData)
    }
    
    func showNetworkError(with text: String) {
        view?.showNetworkError(with: text)
    }
    
    func performSegue(identifier: String) {
        router?.performSegue(identifier: identifier)
    }
}

extension SearchProjectsPresenter:UITextViewDelegate{
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isFirstTimeWritten {
            placeholderText1 = textView.text
            print("\(textView.text!)")
            textView.text = ""
            isFirstTimeWritten = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !isFirstTimeWritten ,  textView.text.count == 0{
            textView.text = placeholderText1
            isFirstTimeWritten = true
        }
    }
    
}
