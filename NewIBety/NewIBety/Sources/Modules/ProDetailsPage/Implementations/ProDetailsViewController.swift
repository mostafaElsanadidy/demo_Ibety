//
//  ProDetailsViewController.swift
//  IBety
//
//  Created by Mohamed on 6/25/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Segmentio
import Alamofire
import DropDown

class ProDetailsViewController: UIViewController {

    var isVertical = false
    var categoryImage:UIImage?
    var categoryName:String?
    
    var displayedSearchProjectData = [DisplayedSearchedProductsData](){
        
        didSet{
            self.searchView.hideSpinner(tag: 1000)
            self.dropDown.anchorView = self.searchTextView
            self.dropDown.dataSource.removeAll()
            
            for project_Data in self.displayedSearchProjectData{
                print(project_Data.name!.description)
                print("@@@@@@@@@@@@@@@@@@@@@@@@@")
                self.dropDown.dataSource.append(project_Data.name!.description)
            }
            
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.searchTextView.text = item
                self.projectName.text = item
                self.searchView.isHidden = true
                
                self.projectImage.showSpinner(tag: 1000)
                
                
                self.presenter?.changeCellImage(with: self.displayedSearchProjectData[index])
                //userProject.projectCity_Id = index
                
                    print("&&&&&&&&&&&&&& \(self.displayedSearchProjectData[index].id!) &&&&&&&&&&&&&&&&&")
                self.presenter?.displayProjectData(projectID: self.displayedSearchProjectData[index].id!)
                
            }
            self.dropDown.show()
        }
    }
    let dropDown = DropDown()
    
    var presenter:ProDetailsViewToPresenterProtocol!
    
    
    @IBOutlet weak var vertical_horizentalView: UIView!
    
    
    @IBOutlet weak var searchBttn: UIButton!
    
    @IBOutlet weak var verticalCollectionBttn: UIButton!
    @IBOutlet weak var horizentalCollectionBttn: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentioView: Segmentio!
    
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    
    @IBOutlet weak var searchTextView: UITextView!
    @IBOutlet weak var searchView: UIView!
    
    
    @IBOutlet weak var vertical_horizentalStackView: UIStackView!
    
    @IBAction func verticalBttnAction() {
        self.isVertical = true
        presenter?.instantiateViewController()
        presenter?.addChildViewController(with: "UserProductsViewController", isVertical: true , in: contentView)
    }
    
    
    @IBAction func horizentalBttnAction() {
        
        self.isVertical = false
        presenter?.instantiateViewController()
        presenter?.addChildViewController(with: "UserProductsViewController", isVertical: false , in: contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ProDetailsRouter.createModule(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.updateViews(segmentioView: segmentioView, contentView: contentView, isVertical: isVertical, vertical_horizentalView: vertical_horizentalView)
        
//        contentView.layer.shadowOpacity = 0
//        contentView.layer.cornerRadius = 0
        
        dropDown.anchorView = searchTextView
        dropDown.dataSource = [""]
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func done(){
    searchView.hud(inView: self.view, animated: true)
        searchView.isHidden = false
        
        searchView.showSpinner(tag: 1000)
          //  searchTextView.isHidden = false
            let name = searchTextView.text!.fixedArabicURL!
        
        presenter?.searchProject(with: name)
            //name.strre
            
            //     alamofireFunction2(httpMethod: .get, urlStr: encodeurlstr, dicOfHeader: dicOfHeader, dicOfBody: nil, userDefaultKey: "displaySearchedProject")
        
    }
    
    
    @IBAction func cancelAction(){
    
        presenter?.popViewController()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
  //      print(categoryName)
//        print(categoryImage!.pngData())
        if let categoryName = categoryName , let categoryImage = categoryImage{
        projectName.text = categoryName
        projectImage.image = categoryImage
        }
        
        presenter?.viewDidAppear()
        
    }
    
//    func addChildViewController(childViewController: UIViewController){
//
//        childViewController.willMove(toParent: self)
//
//        // Add to containerview
//        contentView.addSubview(childViewController.view)
//        addChild(childViewController)
//        childViewController.view.frame = contentView.bounds
//        childViewController.didMove(toParent: self)
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension ProDetailsViewController:ProDetailsPresenterToViewProtocol{
   
    
    func displayCellImage(with data: Data) {
        self.projectImage.hideSpinner(tag: 1000)
        self.projectImage.image = UIImage(data: data)
    }
    
    func updateVertical_HorizentalView(with shapeLayer: CAShapeLayer) {
        
        vertical_horizentalView.layer.addSublayer(shapeLayer)
        vertical_horizentalView.layer.borderWidth = 1
        vertical_horizentalView.layer.borderColor = #colorLiteral(red: 0.8924478889, green: 0.8924478889, blue: 0.8924478889, alpha: 1)
        
        segmentioView.layer.shadowPath = segmentioView.createRectangle()

    }
    
    func updateView(with projectData: [DisplayedSearchedProductsData]) {
        
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
    
    
    
    
    func updateTitleView(with image: UIImage, name: String) {
        categoryImage = image
        categoryName = name
    }
}
