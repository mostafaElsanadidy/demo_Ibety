//
//  ProDetailsPresenter.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Segmentio
import UIKit

class ProDetailsPresenter:ProDetailsViewToPresenterProtocol{
    
    
    var interector: ProDetailsPresentorToInterectorProtocol?
    var router: ProDetailsPresenterToRouterProtocol?
    var view: ProDetailsPresenterToViewProtocol?
    
    
    
    func updateViews(segmentioView: Segmentio, contentView: UIView, isVertical: Bool, vertical_horizentalStackView: UIStackView) {
        
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ProDetailsViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
        
        segmentioView.semanticContentAttribute = .forceLeftToRight
        var content = [SegmentioItem]()
        
        var tornadoItem = SegmentioItem(
            title: "Communication Info".localized,
            image: UIImage(named: "Wi-Fi"),
            selectedImage: UIImage(named: "inactive2")
        )
        
        content.append(tornadoItem)
        
        tornadoItem = SegmentioItem(
            title: "Project Products".localized,
            image: UIImage(named: "Picture"),
            selectedImage: UIImage(named: "inactive1")
        )
        content.append(tornadoItem)
        
        tornadoItem = SegmentioItem(
            title: "Project Info".localized,
            image: UIImage(named: "Portfolio"),
            selectedImage: UIImage(named: "inactive0")
        )
        
        content.append(tornadoItem)
        
        segmentioView.setup(
            content: content,
            style: .imageOverLabel,
            options: SegmentioOptions(
                backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                segmentPosition: .fixed(maxVisibleItems: 3),
                scrollEnabled: true,
                indicatorOptions: SegmentioIndicatorOptions(
                    type: .bottom,
                    ratio: 1,
                    height: 2,
                    color: #colorLiteral(red: 0.5460985303, green: 0.07448668033, blue: 0.2450374961, alpha: 1)
                ),
                horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                    type: SegmentioHorizontalSeparatorType.topAndBottom, // Top, Bottom, TopAndBottom
                    height: 0.5,
                    color: .lightGray
                ),
                verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0, // from 0.1 to 1
                    color: .gray
                ),
                imageContentMode: .center,
                labelTextAlignment: .center,
                segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .gray
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: #colorLiteral(red: 0.5755979419, green: 0.0773044005, blue: 0.2239712477, alpha: 0.557416524)
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),
                        titleFont: UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: .black
                    )
                )
            )
        )
        
        
        instantiateViewController()
        segmentioView.selectedSegmentioIndex = 0
        addChildViewController(with: "CommunicateDetailsViewController", in: contentView)
        
        vertical_horizentalStackView.isHidden = true
        
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            tornadoItem = content[segmentIndex]
            if segmentIndex == 1{
                
                vertical_horizentalStackView.isHidden = false
                self.addChildViewController(with: "UserProductsViewController", isVertical: isVertical, in: contentView)
            }
            else if segmentIndex == 0{
                
                //                    self.contentView.layer.cornerRadius = 20
                //                    self.contentView.layer.shadowOpacity = 0.3
                vertical_horizentalStackView.isHidden = true
                self.addChildViewController(with: "CommunicateDetailsViewController", in: contentView)
                
            }
            else if segmentIndex == 2{
                
                vertical_horizentalStackView.isHidden = true
                self.addChildViewController(with: "ProjectDetailsViewController", in: contentView)
            }
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
