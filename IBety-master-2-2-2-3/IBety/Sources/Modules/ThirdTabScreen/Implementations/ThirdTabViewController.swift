//
//  ThirdTabViewController.swift
//  IBety
//
//  Created by Mohamed on 7/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class ThirdTabViewController: UIViewController {

   // @IBOutlet weak var additionalBttn: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var presenter:ThirdTabViewToPresenterProtocol!
    
    var indexOfPage:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles = ["",
                      "Language",
                      "About The Application",
                      "Continue With US",
                      "Advertising",
                      "Sending Message",
                      "Sending Message",
                      "Notifications"]
        
        ThirdTabRouter.createModule(view: self)
        titleLabel.text = titles[indexOfPage!].localized
        presenter?.viewDidLoad(with: indexOfPage!)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelPage() {
    
       presenter?.cancelPage()
    }

}
   
//        let viewController = storyboard!.instantiateViewController(withIdentifier: "MyDetailsViewController") as! MyDetailsViewController
//        if let data = UserDefaults.standard.data(forKey: "UserLoginResult"){
//            ownerLoginResult = try! JSONDecoder().decode(OwnerLogin_Result.self, from: data)
//            if ownerLoginResult.data!.type! == "owner"{
//                viewController.indexOfPage = 2
//            }
//            else if ownerLoginResult.data!.type! == "customer"{
//                viewController.indexOfPage = 1
//            }}else{
//            viewController.indexOfPage = 0
//        }
//
//        if let _ = UserDefaults.standard.data(forKey: "UserLoginResult"){
//
//
//        tabBarViewController.viewControllers![3] = viewController
//        tabBarViewController.selectedIndex = 3
//        tabBarViewController.viewControllers![3].tabBarItem!.image = UIImage(named: "Group 656")
//        tabBarViewController.viewControllers![3].tabBarItem!.selectedImage = UIImage(named: "Group-1")
//        tabBarViewController.viewControllers![3].tabBarItem!.title = ""
//        }else{
      //      dismiss(animated: true, completion: nil)
//        }
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


