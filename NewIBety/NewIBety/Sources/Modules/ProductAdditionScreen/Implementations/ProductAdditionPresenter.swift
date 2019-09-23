//
//  ProductAdditionPresenter.swift
//  IBety
//
//  Created by 68lion on 9/6/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Foundation
import Photos
import BSImageView
import BSImagePicker

class ProductAdditionPresenter: ProductAdditionViewToPresenterProtocol {
    
    var view: ProductAdditionPresenterToViewProtocol?
    var interector: ProductAdditionPresentorToInterectorProtocol?
    var router: ProductAdditionPresenterToRouterProtocol?
    
    
    var selectedAssests = [PHAsset]()
    
    
    init() {
        dicOfProductDetails = ["name":"",
                               "description":"",
                               "price":"",
                               "images[0]":""]
    }
    
    func viewDidLoad() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if let firstView = view as? ProductAdditionViewController{
                firstView.loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: firstView.view.subviews, cancelledTags: nil)}
        }
    }
    
    func displayProduct(with index: Int) {
        interector?.displayProductService(with: index)
    }
    
    
    func addNewProduct() {
        interector?.addNewProductService()
    }
    
    func updateProduct(selectedIndex: Int) {
        interector?.updateProductService(selectedIndex: selectedIndex)
    }
    
    
    func takeProductPhotos(with photoImageViewFrame: CGRect) {
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 10
        vc.takePhotos = true
        if let view = view as? UIViewController{
            view.bs_presentImagePickerController(vc, animated: true,
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
                    self.selectedAssests.append(assets[i])
                    
                    PHCachingImageManager.default().requestImage(for: self.selectedAssests[i], targetSize:photoImageViewFrame.size, contentMode: .aspectFit, options: .none) { (result, _) in
                        self.view?.changePhotoImageView(with: result!)
                        dicOfProductDetails.updateValue((result?.pngData()?.base64EncodedString())!, forKey: "images[\(i)]")
                        
                    }
                    
                    //                PHCachingImageManager.default().requestImageData(for: assets[i], options: .none){
                    //                    (data, str, orientation, info) in
                    ////                    print("\(data!.base64EncodedString())")
                    //                    userProject.productImages.append( data!.base64EncodedString() )
                    //                    //print("\(userProject.productImages[0]) &&&&&&&&&&&&&&&&&&")
                    //                    self.imageView.image = UIImage.init(data: userProject.productImages[i].data(using: .utf8)!)
                    //                }
                }
                //print("\(userProject.productImages.count) *****************")
                //            self.collectionView.reloadData()
            }, completion: nil)
        }
        
        //print(userProject.productImages.count)
    }
    
    
    
    func updateDictionanry(value: String, with key: String) {
        dicOfProductDetails.updateValue( value , forKey: key)
    }
    
    func dismissViewController() {
        router?.dismissViewController()
    }
    
    
}

extension ProductAdditionPresenter:ProductAdditionInterectorToPresenterProtocol{
    
    func showNetworkError(with text: String) {
        view?.showNetworkError(with: text)
    }
    
    func showNetworkError() {
        view?.showNetworkError()
    }
    
    func showUpdateAlert() {
        view?.showUpdateAlert()
    }
    
    func updateViews(with productData: displayedProductData) {
        view?.updateViews(with: productData)
    }
    
    func displayProductImage(with data: Data) {
        view?.displayProductImage(with: data)
    }
    
    
}
