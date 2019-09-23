//
//  SearchProjectsViewController.swift
//  IBety
//
//  Created by 68lion on 9/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchProjectsViewController: UIViewController {

    var presenter:SearchViewToPresenterProtocol!
    var isDone = false
    var spinnerTag = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var displayedSearchProjectData = [DisplayedSearchedProductsData](){
        didSet{
            self.searchView.isHidden = true
            self.searchView.hideSpinner(tag: 1000)
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
        }
    }
    
    
    var itemsPerRow:CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10.0,
                                     left: 5.0,
                                     bottom: 0.0,
                                     right: 5.0)
    @IBOutlet weak var searchBttn: UIButton!
    @IBOutlet weak var searchTextView: UITextView!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Searching".localized
        SearchProjectsRouter.createModule(view: self)
        collectionView.dataSource = self
        collectionView.delegate = self
        searchTextView.delegate = presenter as! UITextViewDelegate
        searchTextView.layer.cornerRadius = 7.0
        searchTextView.text = "search for project".localized
        presenter?.updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func done(){
        
        if isDone{
            searchView.showSpinner(tag: 1000)
            //  searchTextView.isHidden = false
            let name = searchTextView.text!.fixedArabicURL!
            searchView.isHidden = true
            presenter?.searchProject(with: name)
            isDone = false
        }else{
            searchView.hud(inView: self.view, animated: true)
            searchView.isHidden = false
            isDone = true
        }
    }
    
    @IBAction func cancelAction(){
        
        presenter?.popViewController()
        
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

extension SearchProjectsViewController:UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayedSearchProjectData.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! MYPARTSCollectionViewCell
        
        let proData = displayedSearchProjectData
            cell.nameLabel.text = proData[indexPath.row].name!
        spinnerTag = indexPath.row
            cell.imageView.showSpinner(tag: 1002)
            presenter?.changeCellImage(for: cell, with: proData[indexPath.row])
            cell.imageView.hideSpinner(tag: 1002)
        
        cell.layer.cornerRadius = 20.0
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MYPARTSCollectionViewCell{
            cell.backgroundColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)
            cell.nameLabel.textColor = UIColor.white}
        
        let selectedCategoryID = displayedSearchProjectData[indexPath.row].id!
        
        // if let viewController = tabBarViewController.viewControllers![0] as? FirstTABViewController
        
        
        print("mostafa ABC")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MYPARTSCollectionViewCell{
            presenter?.displayCategoryProjects(with: selectedCategoryID,for: cell)
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLabel.textColor = #colorLiteral(red: 0.5687007308, green: 0.08060152084, blue: 0.267926693, alpha: 1)}
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
}


extension SearchProjectsViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - 20
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


extension SearchProjectsViewController:SearchPresenterToViewProtocol{
    
    
    func updateCollectionView(with projectData: [DisplayedSearchedProductsData]) {
        
        self.displayedSearchProjectData = projectData
    }
    

    func showNetworkError(with text: String) {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error \n \(text). \n Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
    
}
