//
//  ProDetailsProtocols.swift
//  IBety
//
//  Created by 68lion on 9/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Segmentio

import UIKit

protocol ProDetailsPresenterToViewProtocol: class {
  
    func updateTitleView(with image:UIImage , name:String);
    func showNetworkError(with text : String)
    func updateView(with projectData:[DisplayedSearchedProductsData])
    func displayCellImage(with data:Data)
    func updateVertical_HorizentalView(with shapeLayer:CAShapeLayer)
}

protocol ProDetailsInterectorToPresenterProtocol: class {
    
    func showNetworkError(with text : String)
    func updateView(with projectData:[DisplayedSearchedProductsData])
    func updateTitleView(with image:UIImage , name:String);
    func displayCellImage(with data:Data)
    
}

protocol ProDetailsPresentorToInterectorProtocol: class {
    
    var presenter: ProDetailsInterectorToPresenterProtocol? {get set} ;
    func searchProject(with name:String)
    func displayCellImageService(with item: DisplayedSearchedProductsData)
    func alamofireDisplayedData(projectID:Int)
}

protocol ProDetailsViewToPresenterProtocol: class {
    
    var view: ProDetailsPresenterToViewProtocol? {get set};
    var interector: ProDetailsPresentorToInterectorProtocol? {get set};
    var router: ProDetailsPresenterToRouterProtocol? {get set}
    //func updateView();
    func searchProject(with name:String)
    func popViewController()
    func changeCellImage(with item: DisplayedSearchedProductsData)
    func updateViews(segmentioView: Segmentio , contentView:UIView , isVertical:Bool , vertical_horizentalView:UIView)
    func viewDidAppear()
    func instantiateViewController()
    func addChildViewController(with identifier:String , isVertical:Bool , in contentView:UIView)
    func addChildViewController(with identifier:String , in contentView:UIView)
    
    func displayProjectData(projectID:Int)
}

protocol ProDetailsPresenterToRouterProtocol: class {
   
    static func createModule(view:ProDetailsViewController)
    
    var presenter:ProDetailsViewToPresenterProtocol?{get set}
    func popViewController()
    func instantiateViewController()
    func addChildViewController(with identifier:String , isVertical:Bool , in contentView:UIView)
    func addChildViewController(with identifier:String , in contentView:UIView)
    func addViewController(childController: UIViewController, in parentController: UIViewController , in contentView:UIView)
}
