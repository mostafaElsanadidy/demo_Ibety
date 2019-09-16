//
//  UserProductsViewController.swift
//  IBety
//
//  Created by Mohamed on 8/21/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import Alamofire
import UIKit

class UserProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var presenter:UserProductsViewToPresenterProtocol!
    var isVertical = true
    var selectedIndex = 0
    @IBOutlet weak var collectionView: UICollectionView!
  
    let sectionInsets = UIEdgeInsets(top: 5.0,
                                     left: 20.0,
                                     bottom: 0.0,
                                     right: 20.0)
   
    //var changedProjectDetail:project_Details!
    var displayedProductsDetails = [product_Data_](){
    didSet{
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
            }
        }
    
    //   var productsDetails = [product_Details]()
    //
    
    
    //    var imageURLStrArray:[String]!
    //    var productsNames:[String]!
    //    var productsDescriptions:[String]!
    //    var productsPrices:[String]!
    //    var productImagesUrlStr:[String]!
    
    //   var ProductIDs:[Int]!
    var indexOfProduct:Int = 0
    var selectedIndexOfCell = 0
    var ownerLoginResult:OwnerLogin_Result!
    var displayedProjectDetails:projectCreationDetails!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTitleOfPage(_:)), name: NSNotification.Name(rawValue: "ChangeProjectData"), object: nil)
    }
    
    @objc func changeTitleOfPage(_ notification: Notification) {
        
        view.showSpinner(tag: 1001)

        presenter?.updateCollectionView()
        
        view.hideSpinner(tag: 1001)
    }
    
    
    
    
    @IBAction func cancelPage() {
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "MyProjectPartsViewController") as! MyProjectPartsViewController
        
        
        tabBarViewController.viewControllers![3] = viewController
        tabBarViewController.viewControllers![3].tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Group 656"), tag: 1)
        tabBarViewController.selectedIndex = 3
        
    }
    
    
    @objc func selectIndexOfProductID(_ gestureRecognizer: UIGestureRecognizer) {
        let point = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point){
            // selectedIndexOfCell = (indexPath.section*Int(itemsPerRow))+(indexPath.row)
            
            selectedIndexOfCell = indexPath.row
            print("\(selectedIndexOfCell) &&&&&&&&&&&&&&& ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    tableView.estimatedRowHeight = 600
        
        UserProductsRouter.createModule(view: self)
        // self.logoImageView.image =
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(selectIndexOfProductID))
        gestureRecognizer.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(gestureRecognizer)
        
        
        //  print("\(productsDetails.count) **********************")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        //collectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("dasgfasd")
        
       presenter?.updateCollectionViewUseingService()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        print(" znvkjsdnvkjsdsd ")
    }
    
    
    //        if i == 1{
    //            print("\(availableWidth+10)")
    //            print("\(collectionView.frame.height)")
    //            return CGSize.init(width: availableWidth+10, height: 120)
    //        }
    
    
    
    
    //    func configureViewSize(subViews:[UIView]) ->  CGSize{
    //        var viewHeight:CGFloat = 0
    //        for view in subViews {
    //            let frame = view.frame
    //            view.sizeToFit()
    //            view.frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y)
    //        }
    //
    //
    //
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - UICollectionViewDataSource

extension UserProductsViewController{
    
    //fileprivate var
    
    //
    //        if let productsData = self.displayedProductsDetails.data{
    //            if isVertical {
    //                print("\(3*Int(itemsPerRow))")
    //
    //                return productsData.count
    //            }
    //            let countOfSections = (productsData.count/Int(itemsPerRow))
    //            if productsData.count % Int(itemsPerRow) != 0{
    //                return countOfSections+1
    //            }
    //            return countOfSections
    //        }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.displayedProductsDetails.count
        
    }
    
    //        if isVertical {
    //            return 1
    //        }
    //        let countOfSections = (productsData.count/Int(itemsPerRow))
    //        if productsData.count % Int(itemsPerRow) != 0{
    //            if section == countOfSections{
    //                return productsData.count % Int(itemsPerRow)
    //            }
    //        }
    //
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
        // print("")
        
            print(displayedProductsDetails[indexPath.row].name!)
            configure(for: cell, with: displayedProductsDetails[indexPath.row])
            //cell.imageView.image =  productImages[0]
            
            
            // let frame = cell.introductionLabel.frame
            // cell.introductionLabel.sizeToFit()
//            displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data2!)
//
//            if displayedProjectDetails.data!.id! != projectID{
//
//                cell.editButton.isHidden = true
//                cell.deleteButton.isHidden = true
//            }else{
//                cell.editButton.isHidden = false
//                cell.deleteButton.isHidden = false
//            }
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
//        cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
//        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        if item.media!.images!.count > 0{
            presenter?.changeCellImage(for: cell, with: item);
        }else{
            cell.imageView.hideSpinner(tag: 1000)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "editProduct"{
//            let viewController = segue.destination as! ProductAdditionViewController
//
//            viewController.indexOfSelectedProduct = displayedProductsDetails[selectedIndexOfCell].id!
//            viewController.isUpdateState = true
//
//        }
//        if segue.identifier == "AddProductSegue"{
//
//            let viewController = segue.destination as! ProductAdditionViewController
//            viewController.isUpdateState = false
//        }
//
//    }
    
//    @objc func editButtonTapped(){
//        
//        print(" mosvchgcvhg ")
//        
//        performSegue(withIdentifier: "editProduct", sender: nil)
//        
//    }
//    
//    @objc func deleteButtonTapped(){
//        
//        
//        
//        displayedProjectDetails = try! JSONDecoder().decode(projectCreationDetails.self, from: data2!)
//        
//        if displayedProjectDetails.data!.id! == projectID{
//            if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
//                ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
//                let headers = [
//                    "Authorization": "Bearer \(ownerLoginResult.token!)",
//                    "X-Accept-Language":"ar",
//                    "Accept":"application/json"
//                    
//                    // "Content-Type":"application/json"
//                ]
//                
//                let productsData = self.displayedProductsDetails.data!
//                
//                let urlUpdateProductStr = urlStr + "/\(projectID)/products/\(productsData[selectedIndexOfCell].id!)"
//                
//                alamofireFunction2(httpMethod: .delete, urlStr: urlUpdateProductStr, dicOfHeader: headers, dicOfBody: nil, userDefaultKey: "deletedProduct")
//                
//                //                delegate?.dicOfProductUpdate(viewController: self, dicOfProducts: dicOfProductDetails)
//                //                dismiss(animated: true, completion: nil)
//            }}else{
//            showNetworkError()
//        }
//    }
    
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
    
}

// MARK: - Collection View Flow Layout Delegate

extension UserProductsViewController : UICollectionViewDelegateFlowLayout {
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

extension UserProductsViewController:UserProductsPresenterToViewProtocol{
    
    func showNetworkError(errorMessageText: String) {
        showNetworkError()
    }
    
    func reloadCollectionView(displayProjectDetails: projectCreationDetails) {
        self.displayedProjectDetails = displayProjectDetails
    }
    
    func reloadCollectionViewByService(displayProductsDetails: [product_Data_]) {
        self.displayedProductsDetails = displayProductsDetails
    }
    
    func displayCellImage(for cell: ProductCollectionViewCell, with data: Data) {
        cell.imageView.hideSpinner(tag: 1000)
        cell.imageView.image = UIImage(data: data)
    }
    
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            
            print(" cgcfjhchchhjcjhchjcvjhchjcggttttt ")
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutIfNeeded()
        }
    }
    
//    func changeSelectIndexPath(selectedIndex: Int) {
//        self.selectedIndexOfCell = selectedIndex
//    }
    
    
    
}
