//
//  ProductViewController.swift
//  IBety
//
//  Created by Mohamed on 6/25/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import BSImagePicker
import BSImageView
import Photos


class ProductViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var productName: UITextView!
    @IBOutlet weak var descriptionProduct: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
  //  @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter:ProductViewViewToPresenterProtocol!
    var selectedAssests = [PHAsset]()
    let sectionInsets = UIEdgeInsets(top: 0.0,
                                     left: 0.0,
                                     bottom: 0.0,
                                     right: 0.0)
    
    var itemsPerRow:CGFloat = 0

    
    @IBAction func moveProductBttnAction() {
        
        presenter?.moveBttn()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductViewRouter.createModule(view: self)
        
        productName.text = "Hand Products".localized
        descriptionProduct.text = "Type Product Description".localized
        
        productName.delegate = self
        descriptionProduct.delegate = self
        priceTextField.delegate = self
    }
    
    @IBOutlet weak var demoView: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.updateViews()
        demoView?.layer.shadowOpacity = 0.2
        demoView?.layer.shadowRadius = 5
        demoView?.layer.shadowPath = demoView?.createRectangle()
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func uploadPhotos() {
        
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 10
        vc.takePhotos = true
        userProject.productImages = []
        
        self.bs_presentImagePickerController(vc, animated: true,
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
                
                PHCachingImageManager.default().requestImage(for: self.selectedAssests[i], targetSize:self.imageView.frame.size, contentMode: .aspectFit, options: .none) { (result, _) in
                                        self.imageView.image = result
                    userProject.productImages.append((result?.pngData()?.base64EncodedString())!)
                                    }
                     }
            print("\(userProject.productImages.count) *****************")
//            self.collectionView.reloadData()
        }, completion: nil)
        
       
        //print(userProject.productImages.count)
    }
    
    var i = 0
    var j = 0
    var text = ""
    var text1 = ""
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        let nsstringNewText = newText as NSString
        
        
        if nsstringNewText.length > 0{
                userProject.productPrice = newText
        }
        
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == productName{
            if i == 0 {
                text = textView.text
                print("\(textView.text!)")
                //            text = textView.text
                textView.text = ""
                i = 1
            }
        }
        
        if textView == descriptionProduct{
            if j == 0 {
                text1 = textView.text
                print("\(textView.text!)")
                //            text = textView.text
                textView.text = ""
                j = 1
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count>0{
           // if textView.text != text{
                if textView == productName{
                    userProject.productName = textView.text!}
                if textView == descriptionProduct{
                    userProject.productDescription = textView.text!
                }
            //}
        }
        
        print("\(userProject.productName) , \(userProject.productDescription)")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        //        if textView.text.count>0{
        //
        //        }
        if textView == productName{
            
            if i == 1 ,  textView.text.count == 0{
                textView.text = text
                i = 0
            }}
        if textView == descriptionProduct{
            
            if j == 1 , textView.text.count == 0{
                textView.text = text1
                j = 0
            }}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension ProductViewController: UICollectionViewDataSource{
//
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//            return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        itemsPerRow = 2
//        return Int(itemsPerRow)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath)
//        if let imageView = cell.viewWithTag(200) as? UIImageView{
//            print("kkkkkk")
//            if selectedAssests.count > 0{
//                PHCachingImageManager.default().requestImage(for: selectedAssests[i], targetSize:imageView.frame.size, contentMode: .aspectFit, options: .none) { (result, _) in
//                    imageView.image = result
//                }
//            }}
//        return cell
//    }
//
//
//}
//
//extension ProductViewController: UICollectionViewDelegateFlowLayout{
//
//        //1
//
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            sizeForItemAt indexPath: IndexPath) -> CGSize {
//            //2
//            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//            let availableWidth = collectionView.frame.width - (paddingSpace+32)
//            let widthPerItem = availableWidth / itemsPerRow
//
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath)
////                print("************ mostafa ")
////                cell.sizeToFit()
////                cellHeight = cell.intrinsicContentSize.height
//           // print("\(co)")
//                return CGSize(width: widthPerItem, height: widthPerItem)
//        }
//
//        //3
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            insetForSectionAt section: Int) -> UIEdgeInsets {
//            return sectionInsets
//        }
//
//        // 4
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return sectionInsets.left
//        }
//
//
//    }

extension ProductViewController:ProductViewPresenterToViewProtocol{
    func updateSelectedImage(with image: UIImage) {
        
        self.imageView.image = image
    }
    
    
    
}
