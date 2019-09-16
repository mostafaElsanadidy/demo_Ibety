//
//  FirstTABViewController.swift
//  IBety
//
//  Created by Mohamed on 7/11/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire


class FirstTABViewController: UIViewController, UICollectionViewDataSource {

    var timer = Timer()
  //  var isPartPage = false
    var i = 0
    var ind = 0
    var nameOfPhotos = ["welcome2", "welcome", "home", "home2"]

    @IBOutlet weak var navBttnItem: UIButton!
    @IBOutlet weak var advertisingBttn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var advertisingBttnView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter:FirstTabViewToPresenterProtocol!
    
    @IBOutlet weak var advertisingImageView: UIImageView!
    var displayedCategories=CategoryResult(){
        
        didSet{
            
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
                }}
    
    var itemsPerRow:CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 0.0,
                                     left: 5.0,
                                     bottom: 0.0,
                                     right: 5.0)
    
    @objc func didTimeOut() {

        UIView.transition(with: advertisingImageView, duration: 0.8, options: .transitionFlipFromLeft, animations: {
            if let image = UIImage.init(named: "\(self.nameOfPhotos[self.ind])"){
                self.advertisingImageView.image = image
              //  self.advertisingImageView.
                print("\(self.nameOfPhotos[self.ind])")}
        }, completion: nil)
       
        if i == 0{
            ind += 1}
        else{
            ind -= 1}
        if ind == nameOfPhotos.count-1{
            i = 1
        }
        if ind == 0{
            i = 0
        }
        
        //performSegue(withIdentifier: "projectDetails", sender: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstTabRouter.createModule(viewController: self)
        
        presenter?.updatePageName_UserDefault(with: "FirstTABViewController")
        collectionView.showSpinner(tag: 1000)
        
        
//        var categorisData:[Any] = []
        collectionView.dataSource = self
        collectionView.delegate = self
        
       presenter?.updateCollectionView()
    }
    
            // Do any additional setup after loading the view.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

            timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                         selector: #selector(didTimeOut), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func cancelAction() {
        
        timer.invalidate()
            presenter?.dissmissViewController()
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



// MARK: - UICollectionViewDataSource

extension FirstTABViewController{
    
    //fileprivate var
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return displayedCategories.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! MYPARTSCollectionViewCell
     //   var imageStr = "imageCELL\(indexPath.section)\(indexPath.row)"
        
        let categorData = displayedCategories.data![indexPath.row]
            print(categorData.name! )
            cell.nameLabel.text = categorData.name!
            cell.imageView.showSpinner(tag: 1001)
    
            self.presenter?.changeCellImage(for: cell, with: categorData)
            
        
        cell.layer.cornerRadius = 20.0
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let selectedCategoryID = displayedCategories.data![indexPath.row].id!
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MYPARTSCollectionViewCell{
        presenter?.performSegueUsingService(identifier: "showPartPage", with: cell, selectedCategoryIndex: selectedCategoryID)
            
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.nameLabel.textColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)
        }
        print("mostafa ABC")
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MYPARTSCollectionViewCell{
            cell.backgroundColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)
            cell.nameLabel.textColor = UIColor.white}
        if indexPath.row > displayedCategories.data!.count-1{
            return false
        }
        return true
        
    }
}


extension FirstTABViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = (collectionView.frame.width-20)
        let widthPerItem = availableWidth / itemsPerRow
        
        
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

extension FirstTABViewController:FirstTabPresenterToViewProtocol{
   
    
    func displayCellImage(for cell: MYPARTSCollectionViewCell, with data: Data) {
        cell.imageView.hideSpinner(tag: 1001)
        cell.imageView.image = UIImage(data: data)
    }
    
    
    func show_Error(errorMessageText: String) {
        
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(errorMessageText). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    
    func reloadCollectionViewByService(displayedCategories: CategoryResult) {
        collectionView.hideSpinner(tag: 1000)
        self.displayedCategories = displayedCategories
    }
    
}
