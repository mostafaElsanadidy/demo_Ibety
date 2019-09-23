//
//  ProductViewPresenter.swift
//  IBety
//
//  Created by 68lion on 9/5/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import UIKit
import BSImageView
import BSImagePicker
import Photos

class ProductViewPresenter: ProductViewViewToPresenterProtocol {

    var interector: ProductViewPresentorToInterectorProtocol?
    var router: ProductViewPresenterToRouterProtocol?
    var view: ProductViewPresenterToViewProtocol?
    
    func moveBttn() {
        
        if let ProjectInfoViewController = self.router?.instantiateViewController(with: "ViewController2"){
            UIView.animate(withDuration: 0){
                
                if let viewController = self.view as? UIViewController{
                    
                    if let  parentViewController = viewController.parent as? ParentViewController{ parentViewController.presenter?.addChildViewController(childViewController: ProjectInfoViewController)
                        parentViewController.presenter?.selectedIndex += 1
                        parentViewController.presenter?.updateButtons2(mainBttns: [parentViewController.infoBttn, parentViewController.productsBttn, parentViewController.proDataBttn], selectedIndex: 2)}
                }
            } }
        
    }
    
    
    func updateViews() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ProductViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    func uploadPhotos(with imageViewFrame: CGRect) {
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 10
        vc.takePhotos = true
        userProject.productImages = []
        var selectedAssests = [PHAsset]()
        if let viewController = view as? UIViewController{
            viewController.bs_presentImagePickerController(vc, animated: true,
                                                           select: { (asset) -> Void in
                                                            print("Selected: \(asset)")
                                                            
            }, deselect: { (asset) -> Void in
                print("Deselected: \(asset)")
            }, cancel: { (assets) -> Void in
                print("Cancel: \(assets)")
            }, finish: { (assets) -> Void in
                print("Finish: \(assets)")
                print(assets.count)
                for i in 0..<assets.count {
                    selectedAssests.append(assets[i])
                    
                    PHCachingImageManager.default().requestImage(for: selectedAssests[i], targetSize:imageViewFrame.size, contentMode: .aspectFit, options: .none) { (result, _) in
                        
                        self.view?.updateSelectedImage(with: result!); userProject.productImages.append((result?.pngData()?.base64EncodedString())!)
                    }
                    
                    //                PHCachingImageManager.default().requestImageData(for: assets[i], options: .none){
                    //                    (data, str, orientation, info) in
                    ////                    print("\(data!.base64EncodedString())")
                    //                    userProject.productImages.append( data!.base64EncodedString() )
                    //                    //print("\(userProject.productImages[0]) &&&&&&&&&&&&&&&&&&")
                    //                    self.imageView.image = UIImage.init(data: userProject.productImages[i].data(using: .utf8)!)
                    //                }
                }
                print("\(userProject.productImages.count) *****************")
                //            self.collectionView.reloadData()
            }, completion: nil)}
        
        
        //print(userProject.productImages.count)
    }
}


