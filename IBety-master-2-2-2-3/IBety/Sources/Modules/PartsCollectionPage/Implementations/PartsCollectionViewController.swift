//
//  PartsCollectionViewController.swift
//  IBety
//
//  Created by 68lion on 8/13/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire

class PartsCollectionViewController: UIViewController, UICollectionViewDataSource{
    
    
    //  var isPartPage:Bool!
    @IBOutlet weak var cellNameLabel: UILabel!
    var presenter:PartsCollectionViewToPresenterProtocol!
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var categoryName:String?
    var categoryImage:UIImage?
    // @IBOutlet weak var advertisingView: UIView!
    //    @IBOutlet weak var advertisingCell: MYPARTSCollectionViewCell!
    
    var category_Projects:CategoryProjects!{
        didSet{
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
        }
    }
    
    var itemsPerRow:CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10.0,
                                     left: 5.0,
                                     bottom: 0.0,
                                     right: 5.0)
    
   // var changeTitleLabel_Image:((_ title:String, _ image:UIImage)->())!
    
    @IBAction func cancelAction(){
        presenter?.popViewController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PartsCollectionRouter.createModule(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter?.updateCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let categoryImage = categoryImage, let categoryName = categoryName{
            cellImageView.image = categoryImage
            cellNameLabel.text = categoryName
        }
    }
    
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

extension PartsCollectionViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return category_Projects?.data?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == category_Projects?.data?.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "advertisingCell", for: indexPath) as! MYPARTSCollectionViewCell
            cell.layer.cornerRadius = 20.0
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! MYPARTSCollectionViewCell
        var imageStr = "imageCELL\(indexPath.section)\(indexPath.row)"
        
        if let categoryData = category_Projects?.data{
            cell.nameLabel.text = categoryData[indexPath.row].name!
           cell.imageView.showSpinner(tag: 1001)
           
           presenter?.changeCellImage(for: cell, with: categoryData[indexPath.row])
        }
        cell.layer.cornerRadius = 20.0
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MYPARTSCollectionViewCell{
            cell.backgroundColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)
            cell.nameLabel.textColor = UIColor.white}
        
            let selectedCategoryID = category_Projects!.data![indexPath.row].id!
            
        // if let viewController = tabBarViewController.viewControllers![0] as? FirstTABViewController
        
        
        print("mostafa ABC")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MYPARTSCollectionViewCell{
            presenter?.displayCategoryProjects(with: selectedCategoryID,for: cell)
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLabel.textColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)}
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n you must login. \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        
        if indexPath.row >= category_Projects.data!.count{
            
            return false
        }
        return true
    }
}


extension PartsCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - 20
        let widthPerItem = availableWidth / itemsPerRow
    
            if indexPath.row == category_Projects.data!.count{
                print("\(availableWidth+10)")
                print("\(collectionView.frame.height)")
                return CGSize.init(width: availableWidth+10, height: 120)
            }
        
        return CGSize(width: widthPerItem, height: 120)
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

extension PartsCollectionViewController:PartsCollectionPresenterToViewProtocol{
  
    
    func updateCollectionView(with categoryProjects: CategoryProjects) {
        self.category_Projects = categoryProjects
    }
    
    func showError() {
        showNetworkError()
    }
    
    func updateTitleView(with image: UIImage, name: String) {
        categoryImage = image
        categoryName = name
    }
    
    func displayCellImage(for cell: MYPARTSCollectionViewCell, with data: Data) {
        cell.imageView.hideSpinner(tag: 1001)
        cell.imageView.image = UIImage(data: data)
    }
    
    
    
}
