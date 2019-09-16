//
//  RequiredViewController.swift
//  IBety
//
//  Created by Mohamed on 7/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class RequiredViewController: UITableViewController{
    
    var numOfRow=0
    var placesPickerVisible = false
    var kitchenPickerVisible = false
    var arrOfGovernorate:[String] = []
    var arrOfRegions:[String] = []
    lazy var networkParsingVar : String? = {
        
        let url = rezervakwURL()
        if let jsonString = performStoreRequest(with: url) {
            return jsonString
        }
        showNetworkError()
        return nil
    }()
    
    
    @IBOutlet weak var placesCell: UITableViewCell!
    @IBOutlet weak var placesPicker: UIPickerView!
    @IBOutlet weak var kitchenTypoCell: UITableViewCell!
    @IBOutlet weak var kitchenTypoPicker: UIPickerView!
    
    @IBAction func placesBttn() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.tableFooterView = kitchenTypoPicker
        if let view = self.view.viewWithTag(100){
        if let text = view as? UITextField{
            text.inputView = placesPicker}}
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        
    }
    
    //    func hidePlacesPicker() {
    //        if placesPickerVisible{
    //            placesPickerVisible = false
    //            let indexPathPicker = IndexPath(row: 3, section: 0)
    //            tableView.deleteRows(at: [indexPathPicker], with: .fade)
    //        }
    //    }
    //
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if placesPickerVisible && kitchenPickerVisible{
            numOfRow = 7
        }
        else if placesPickerVisible || kitchenPickerVisible{
            numOfRow = 6
        }
        else{ numOfRow = 5 }
        
        //print("\(numOfRow)")
        return numOfRow
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellName=""
        
        switch indexPath.row {
            
        case 0:
            cellName="SearchNavCell"
            
        case 1:
            cellName="RestaurantNameCell"
            
        case 2:
            cellName="ChoosePlaceCell"
            
        case 3:
            if placesPickerVisible{
                return placesCell
            }
            cellName="KitchenTypeCell"
            
        case 4:
            if placesPickerVisible{
                cellName="KitchenTypeCell"
            }else{
                if kitchenPickerVisible{
                    return kitchenTypoCell
                }
                cellName="SearchButtonCell"
            }
            
        case 5:
            if kitchenPickerVisible && placesPickerVisible{
                return kitchenTypoCell
            }else{
                cellName = "SearchButtonCell"
            }
            
        default:
            cellName = "SearchButtonCell"
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var newIndexPath = indexPath
        if indexPath.section == 0 && indexPath.row == 5{
            newIndexPath = IndexPath(row: 0, section: indexPath.section)
        }
        if indexPath.section == 0 && indexPath.row == 6{
            newIndexPath = IndexPath(row: 1, section: indexPath.section)
        }
        return super.tableView(tableView,
                               indentationLevelForRowAt: newIndexPath)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        if let cell = tableView.cellForRow(at: indexPath){

            if cell.reuseIdentifier == "ChoosePlaceCell"{
                return indexPath
            }
            if cell.reuseIdentifier == "KitchenTypeCell"{
                if let text = (self.view.viewWithTag(100) as! UITextField).text{
                    if text.count > 0{
                        return indexPath
                    }
                }
            }
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath){

            if cell.reuseIdentifier == "ChoosePlaceCell"{

                if !placesPickerVisible{
                    if let jsonString = networkParsingVar{
                        networkParsing(jsonString: jsonString, row: -1)
                    }

                    showPlacesPicker()}
                else{
                    hidePlacesPicker()}

            }
            if cell.reuseIdentifier == "KitchenTypeCell"{

                if !kitchenPickerVisible && arrOfGovernorate.count>0 {
                    showKitchenTypoPicker()
                }else{
                    hideKitchenTypoPicker()
                }
            }
        }

    }
    
    // MARK : -
    
    
    
    @IBAction func textFieldDidBegin(_ sender: UITextField) {
        
        if sender.tag == 100{
            if !placesPickerVisible{
                showPlacesPicker()}
            else{
                hidePlacesPicker()
            }
        }
        else if sender.tag == 101{
            if !kitchenPickerVisible{
                showKitchenTypoPicker()}
            else{
                hideKitchenTypoPicker()
            }
        }
        
    }
    
}

extension RequiredViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    func showPlacesPicker() {
        placesPickerVisible = true
        let indexPathPicker = IndexPath(row: 3, section: 0)
        tableView.insertRows(at: [indexPathPicker], with: .fade)
    }
    
    func showKitchenTypoPicker() {
        kitchenPickerVisible = true
        var row = 0
        if placesPickerVisible{
            row = 5
        }
        else{ row = 4 }
        
        let indexPathPicker = IndexPath(row: row, section: 0)
        tableView.insertRows(at: [indexPathPicker], with: .fade)
    }
    
    func hidePlacesPicker() {
        if placesPickerVisible{
            placesPickerVisible = false
            let indexPathPicker = IndexPath(row: 3, section: 0)
            tableView.deleteRows(at: [indexPathPicker], with: .fade)
        }
    }
    
    func hideKitchenTypoPicker() {
        if kitchenPickerVisible{
            kitchenPickerVisible = false
            var row = 0
            if placesPickerVisible{
                row = 5
            }
            else{ row = 4 }
            
            let indexPathPicker = IndexPath(row: row, section: 0)
            tableView.deleteRows(at: [indexPathPicker], with: .fade)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == placesPicker {
            return arrOfGovernorate.count
        }
        return arrOfRegions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == placesPicker {
            return arrOfGovernorate[row]
        }
        return arrOfRegions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == placesPicker {
            
            (self.view.viewWithTag(100) as! UITextField).text = arrOfGovernorate[row]
            
            if let jsonString = networkParsingVar{
                networkParsing(jsonString: jsonString, row: row)
                kitchenTypoPicker.reloadAllComponents()
            }
            
        }
        if pickerView == kitchenTypoPicker {
            (self.view.viewWithTag(101) as! UITextField).text = arrOfGovernorate[1]
        }
    }
    
}

extension RequiredViewController{
    
    func networkParsing(jsonString: String, row: Int) {
        parse(json: jsonString, row: row)
        tableView.reloadData()
    }
    
    func rezervakwURL() -> URL {
        let urlString = String(format:
            "http://service.rezervakw.com/api/governorates")
        let url = URL(string: urlString)
        return url!}
    
    func performStoreRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url)
        } catch {
            print("\(error.localizedDescription)")
            print("Download Error: \(error)")
            return nil
        } }
    
    
    
    func parse(json: String, row: Int){
        guard let data = json.data(using: .utf8, allowLossyConversion: false)
            else { return }
        do {
            if let dictionary = try JSONSerialization.jsonObject(
                with: data, options: []) as? [String: Any]{
                if let array = dictionary["data"] as? [Any]{
                    
                    for item in array{
                        if let item = item as? [String:Any]{
                            if let str = item["name"] as? String{
                                arrOfGovernorate.append(str)
                                print(". ******************** ")}
                        }}
                    
                    if row >= 0{
                        arrOfRegions = []
                        if let dictionItem = array[row] as? [String:Any]{
                            
                            if let arr = dictionItem["areas"] as? [Any]{
                                for arrItem in arr{
                                    if let dictionItem = arrItem as? [String:Any]{
                                        if let str = dictionItem["name"] as? String{
                                            arrOfRegions.append(str)
                                            print(". ******************** ")}
                                    }
                                }
                            }
                        }}
                }
                //print("\(dictionary["data"].debugDescription)")
            } }catch {
                print("JSON Error: \(error)")
        }
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error reading from the iTunes Store. Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


