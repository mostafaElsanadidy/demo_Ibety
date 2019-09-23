//
//  MyProductViewController.swift
//  IBety
//
//  Created by Mohamed on 6/27/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire

class MyProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    

    var isVertical = true
    var selectedIndex = 0
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoLabel: UILabel!
     @IBOutlet weak var titleLabel: UILabel!
    
    var presenter:MyProductsViewToPresenterProtocol!

    var projectID:Int!
    
    //var itemsPerRow:CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 5.0,
                                    left: 20.0,
                                    bottom: 0.0,
                                    right: 20.0)
    
    
    @IBOutlet weak var addProductBttn: UIButton!
    var isUpdateState:Bool = true
    var isFirstTimeWritten = true
    
    //var changedProjectDetail:project_Details!
    var displayedProductsDetails:[product_Data_]! = [product_Data_](){
        
        didSet{
            DispatchQueue.main.async {
                
                print(" cgcfjhchchhjcjhchjcvjhchjcggttttt ")
                self.collectionView.hideSpinner(tag: 1000)
                self.collectionView.reloadData()
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
        
      
       
 //   var productsDetails = [product_Details]()
//        didSet{
//
//        }
//    }
    
    
//    var imageURLStrArray:[String]!
//    var productsNames:[String]!
//    var productsDescriptions:[String]!
//    var productsPrices:[String]!
//    var productImagesUrlStr:[String]!
    
 //   var ProductIDs:[Int]!
    var indexOfProduct:Int = 0
    var selectedIndexOfCell = 0
    var ownerLoginResult:OwnerLogin_Result!
    var displayedProjectDetails=projectCreationData(){
        
        didSet{
            titleLabel?.text = displayedProjectDetails.name!
        }
    }
    
    
    let data2 = UserDefaults.standard.data(forKey: "displayCreatedProject")
    
    @IBAction func cancelPage() {
       presenter?.cancelPage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        MyProductsRouter.createModule(view: self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter?.addGestureRecognizer(for: collectionView)
      }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            print("dasgfasd")
        self.collectionView.showSpinner(tag: 1000)
        presenter?.updateView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        collectionView.hideSpinner(tag: 1000)
        print(" znvkjsdnvkjsdsd ")
        
    }
    
}




// MARK: - UICollectionViewDataSource

extension MyProductViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      

        return self.displayedProductsDetails?.count ?? 0
    
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
       // print("")
        
            print(displayedProductsDetails[indexPath.row].name! )
            configure(for: cell, with: displayedProductsDetails[indexPath.row])
        //cell.imageView.image =  productImages[0]
           
        
       // let frame = cell.introductionLabel.frame
       // cell.introductionLabel.sizeToFit()
        
        print(displayedProjectDetails.id!)
        print(projectID)
        
        if displayedProjectDetails.id! != projectID{
            
            cell.editButton.isHidden = true
            cell.deleteButton.isHidden = true
        }else{
            cell.editButton.isHidden = false
            cell.deleteButton.isHidden = false
        }
        print("\(cell.frame.height) mmo")
//        cell.frame.size.height = cell.introductionLabel.frame.size.height+200
//        collectionView.reloadData()
        return cell
    }
    
    func configure(for cell:ProductCollectionViewCell, with item: product_Data_){
        
        print(item.name! )
        cell.nameLabel.text = item.name!
        cell.priceLabel.text = item.price!
        cell.introductionLabel.text = item.description!
        print("\(item.id!)")
        
        cell.imageView.showSpinner(tag: 1000)
        cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        if item.media!.images!.count > 0{
            
            presenter?.changeCellImage(cell: cell, with: item.media!.images![0].conversions!.thumb!)
        }else{
            cell.imageView.hideSpinner(tag: 1000)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        presenter?.prepareForSegue(segue: segue)
    }
    
    @objc func editButtonTapped(){
        
        print(" mosvchgcvhg ")

            presenter?.performSegue(withIdentifier: "editProduct")
        
    }
    
    
    @objc func deleteButtonTapped(){
        
        collectionView.showSpinner(tag: 1000)
        presenter?.deleteProduct()
    }
    
    
}

// MARK: - Collection View Flow Layout Delegate

extension MyProductViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        
        
        let paddingSpace = sectionInsets.left * 3
        let availableWidth = view.frame.width - (paddingSpace+32)
        let widthPerItem = availableWidth / 2
        
        if !isVertical{
            return CGSize(width: widthPerItem, height: 210)}
        else{
            return CGSize(width: availableWidth+10, height: 210)
        }
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension MyProductViewController:MyProductsPresenterToViewProtocol{
    func showDeletionAlert() {
        let alert = UIAlertController(
            title: "SUCCESS...",
            message:
            "Already you delete this product.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){
            
            _ in self.presenter?.displayProducts()
            
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func displayCellImage(cell: ProductCollectionViewCell, with data: Data) {
        cell.imageView.hideSpinner(tag: 1000)
        cell.imageView.image = UIImage(data: data)
    }
    
    func changeSelectedIndexOfCell(with selectedIndex: Int) {
        selectedIndexOfCell = selectedIndex
    }
    
    func changeTitleView(with displayedProjectDetails: projectCreationData) {
        self.displayedProjectDetails = displayedProjectDetails
    }
    
    func changeCollectionView(with displayedProductsDetails: [product_Data_]?) {
        self.displayedProductsDetails = displayedProductsDetails
    }
    
    func showNetworkError(with errorMessageText: String) {
        
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(errorMessageText). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n you can't delete this product. \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func receiveProjectID(value: Int) {
        projectID = value
    }
    
    
}
