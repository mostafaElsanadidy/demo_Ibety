//
//  ProductAdditionViewController.swift
//  IBety
//
//  Created by Mohamed on 7/16/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import BSImagePicker
import BSImageView
import Photos
import Alamofire

//protocol ProductAdditionViewControllerDelegate:class {
//    func dicOfProductAddition( viewController: ProductAdditionViewController, dicOfProducts: [String:String])
//    func dicOfProductUpdate( viewController: ProductAdditionViewController, dicOfProducts: [String:String])
//}

class ProductAdditionViewController: UIViewController , UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var productName: UITextView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!

   // var upadateProduct : ((_ productDetails: product_Details) -> ())!
    var indexOfSelectedProduct:Int!
    var isUpdateState:Bool = false
    
    var presenter:ProductAdditionViewToPresenterProtocol!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(" ********************* ")
    }
    
    @IBOutlet weak var add_editBttn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isUpdateState{
            titleLabel.text = "Product Update".localized
            add_editBttn.setTitle("Update".localized, for: .normal)
        }
        else{
            
            productName.text = "Hand Products".localized
            productDescription.text = "Type Product Description".localized
            titleLabel.text = "Product Addition".localized
            add_editBttn.setTitle("ADD".localized, for: .normal)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        contentView.layer.shadowRadius = 1.0
        //
        
        //       // let shadowRect = contentView.bounds.insetBy(dx: 0, dy: 2) // inset top/bottom
        contentView.layer.shadowPath = contentView.createRectangle()
        contentView.layer.cornerRadius = 10
        add_editBttn.layer.cornerRadius = 5.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductAdditionRouter.createModule(view: self)
        presenter?.viewDidLoad()
        productName.delegate = self
        productDescription.delegate = self
        priceTextField.delegate = self
        
        if isUpdateState{
            self.view.showSpinner(tag: 1000)
            presenter?.displayProduct(with: self.indexOfSelectedProduct)
        }
    }
    
    var isProductNameFieldFirstTimeWritten = true
    var isProductDescriptionFieldFirstTimeWritten = true
    var placeholderText1 = ""
    var placeholderText2 = ""
    
    
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            if textView == productName{
                if isProductNameFieldFirstTimeWritten {
                    placeholderText1 = productName.text
                    print("\(productName.text!)")
                    //            text = textView.text
                    
                    if !isUpdateState{
                        productName.text = ""}
                    isProductNameFieldFirstTimeWritten = false
                }
            }
            
            if textView == productDescription{
                if isProductDescriptionFieldFirstTimeWritten{
                    placeholderText2 = productDescription.text
                    print("\(productDescription.text!)")
                    //            text = textView.text
                    if !isUpdateState{
                        productDescription.text = ""}
                    isProductDescriptionFieldFirstTimeWritten = false
                }
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            if textView.text.count>0{
                if textView.text != placeholderText1 || textView.text != placeholderText2{
                    if textView == productName{
                       // userProject.projectPhone = Int(textView.text!)
                        presenter?.updateDictionanry(value: textView.text!, with: "name")
                        print("\(dicOfProductDetails["name"]) mostafa")
                    }
                    if textView == productDescription{
                      //  userProject.projectEmail = textView.text!
                        presenter?.updateDictionanry(value: textView.text!, with: "description")
                        print("\(dicOfProductDetails["description"]) mostafa")
                    }
                }
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            
            //        if textView.text.count>0{
            //
            //        }
            if textView == productName{
                
                if !isProductNameFieldFirstTimeWritten ,  textView.text.count == 0{
                    textView.text = placeholderText1
                    isProductNameFieldFirstTimeWritten = true
                }}
            if textView == productDescription{
                
                if !isProductDescriptionFieldFirstTimeWritten , textView.text.count == 0{
                    textView.text = placeholderText2
                    isProductDescriptionFieldFirstTimeWritten = true
                }}
        }
    
    @IBOutlet weak var priceTextField: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        let nsstringNewText = newText as NSString
        
        
        if nsstringNewText.length > 0{
            presenter?.updateDictionanry(value: newText, with: "price")
                print("\(dicOfProductDetails["price"])     12131")
        }
        
        print("\(dicOfProductDetails["price"])")
        return true
    }
    
    @IBAction func takeProductPhoto() {
        
        presenter?.takeProductPhotos(with: photoImageView.frame)
    }
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBAction func cancelAction() {
        
        presenter?.dismissViewController()
    }
    
    @IBAction func addNewProduct() {
        
        if !isUpdateState{
            presenter?.addNewProduct()
        }
        else{
            presenter?.updateProduct(selectedIndex: indexOfSelectedProduct)
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        view.hideSpinner(tag: 1000)
    }
}

extension ProductAdditionViewController:ProductAdditionPresenterToViewProtocol{
    
    
    func updateViews(with productData: displayedProductData) {
    
        self.view.hideSpinner(tag: 1000)
        self.productName.text = productData.name!
        self.productDescription.text = productData.description!
        self.priceTextField.text = productData.price_formated!
        self.photoImageView.showSpinner(tag: 1000)
    }

    func displayProductImage(with data:Data){
        
        self.photoImageView.hideSpinner(tag: 1000)
        self.photoImageView.image = UIImage(data: data)
    }
    
    func showNetworkError(with text:String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.presenter?.dismissViewController()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n you can't update this product. \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.presenter?.dismissViewController()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showUpdateAlert() {
        
        let alert = UIAlertController(
            title: "Tagged...",
            message:
            "Already you sent Update Product Request successfully \n*** Please wait Response to your request ***",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.presenter?.dismissViewController()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func changePhotoImageView(with image: UIImage) {
        self.photoImageView.image = image
    }
}
