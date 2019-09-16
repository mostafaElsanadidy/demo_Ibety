//
//  UserDataViewController.swift
//  IBety
//
//  Created by Mohamed on 7/7/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class UserDataViewController: UITableViewController{

    var data : Data?
    var user : UserLoginReult?

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            data = UserDefaults.standard.data(forKey: "UserResult")
            self.user = try JSONDecoder().decode(UserLoginReult.self, from: data!)
            
        }catch{
            print("\(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)

        // Configure the cell...
        if let user = user, let data = user.data, let avatar_conversions = data.avatar_conversions{
           
            let keyText = Array(avatar_conversions.keys)[indexPath.row]
            //let keyText = avatar_conversions.keys[indexPath.row].description
            print("\(keyText) mostafa")
            cell.textLabel?.text = keyText
            cell.detailTextLabel?.text = avatar_conversions[keyText]
        }
        return cell
    }
    
}
