//
//  NotificationTableViewController.swift
//  IBety
//
//  Created by Mohamed on 7/14/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit
import Alamofire


class NotificationTableViewController: UITableViewController {
    
    var presenter:NotificationsViewToPresenterProtocol!
    
    var notificationSettings=[NotificationsSettingsData](){
        didSet{
            print(self.notificationSettings)
           
            print(self.tableView.estimatedRowHeight)
            self.tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationsRouter.createModule(view: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.showSpinner(tag: 1002)
        presenter?.viewWillAppear()
        self.tableView.hideSpinner(tag: 1002)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationSettings.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)

        if let cell = cell as? NotificationCell{
            
            
            let createdTime = notificationSettings[indexPath.row].dates!.updated_at!.date!.split{$0 == " "}.map(String.init)
            cell.cellTitle.text = notificationSettings[indexPath.row].title
            cell.cellBody.text = notificationSettings[indexPath.row].body
            cell.createdDate.text = notificationSettings[indexPath.row].dates!.updated_at!.formated!
            cell.createdTime.text = createdTime[1]
        }
       
        // Configure the cell...

        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

extension NotificationTableViewController:NotificationsPresenterToViewProtocol{
   
    
    func reloadTableView(with notificationData: [NotificationsSettingsData]) {
        
        self.notificationSettings = notificationData
    }
    
    func showError(with text: String) {
    
        let alert = UIAlertController(
                title: "Whoops...",
                message:
                "There was an error \n \(text). \n Please try again.",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    
    
}
