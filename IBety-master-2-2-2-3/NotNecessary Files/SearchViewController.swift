//
//  SearchViewController.swift
//  IBety
//
//  Created by Mohamed on 7/2/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UITextFieldDelegate{

    var numOfRow=0
    var activeTextField = 0
    var row = -1
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
    
    var placesPicker = UIPickerView()
    let toolbar = UIToolbar()
    
    
    //
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let queue = DispatchQueue.global()
        queue.async {
            if let jsonString = self.networkParsingVar{
                self.parse(json: jsonString, row: 0)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 100 {
            if arrOfGovernorate.count == 0{
                return false
            }
        }
        
         if textField.tag == 101{
            if let view = self.view.viewWithTag(100){
                if let textField = view as? UITextField{
                    if textField.text?.count==0{
                        return false
                    }
                }
            }
        }
         return true
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
                self.createToolbar()
                self.createAnotherPicker()
        if textField.tag == 100 {
            activeTextField = 1
            if row >= 0{
                placesPicker.selectRow(row, inComponent: 0, animated: true)
            }
            else{
                placesPicker.selectRow(0, inComponent: 0, animated: true)
                textField.text = arrOfGovernorate[0]
            }
            if let view = self.view.viewWithTag(101){
                if let textField = view as? UITextField{
                    print("\(arrOfRegions[0]) ***********")
                    textField.text? = ""
                }}
            //placesPicker.delegate?.pickerView?(placesPicker, didSelectRow: 0, inComponent: 0)
        }
        else if textField.tag == 101{
            activeTextField = 2
            placesPicker.selectRow(0, inComponent: 0, animated: true)
            textField.text = arrOfRegions[0]
        }
//        placesPicker.reloadAllComponents()
        textField.inputView = placesPicker
        textField.inputAccessoryView = toolbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createAnotherPicker()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        }

    func createAnotherPicker()
    {
        placesPicker = UIPickerView()
        placesPicker.dataSource = self
        placesPicker.delegate = self
        //
        placesPicker.backgroundColor = UIColor.white
        
//        for i in 0..<2 {
//            if let view = self.view.viewWithTag(100+i){
//                if let text = view as? UITextField{
//                    text.inputView = placesPicker}}
//        }
    }
    
    
    func createToolbar()
    {
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.closePickerView))
        print("\(doneButton.width)")
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.closePickerView))
       // toolbar.setItems(<#T##items: [UIBarButtonItem]?##[UIBarButtonItem]?#>, animated: <#T##Bool#>)
        let paddingSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        paddingSpace.width = self.view.frame.width - 40
        toolbar.setItems([doneButton, paddingSpace, cancelButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
//        for i in 0..<2 {
//            if let view = self.view.viewWithTag(100+i){
//                if let text = view as? UITextField{
//                    text.inputAccessoryView = toolbar}}
//        }
        
    }
    
    
    @objc func closePickerView()
    {
        view.endEditing(true)  }
    
   
    
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
        
        numOfRow = 5
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
            cellName="KitchenTypeCell"
          
        default:
            cellName="SearchButtonCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        // Configure the cell...

        return cell
    }
    
//    override func tableView(_ tableView: UITableView,
//                            indentationLevelForRowAt indexPath: IndexPath) -> Int {
//        var newIndexPath = indexPath
//        if indexPath.section == 0 && indexPath.row == 5{
//            newIndexPath = IndexPath(row: 0, section: indexPath.section)
//        }
//        return super.tableView(tableView,
//                               indentationLevelForRowAt: newIndexPath)
//    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return nil
    }
    

    // MARK : -
    
    
    
}

    extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate{
        
        
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            if activeTextField == 1 {
                
                return arrOfGovernorate.count
            }
            print("\(arrOfRegions.count)")
            
            return arrOfRegions.count
        }
        
//        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//            if arrOfGovernorate.count == 0 {
//                return UIActivityIndicatorView.init(style: .gray)
//            }
//            return UILabel()
//        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            if activeTextField == 1 {
                
                return arrOfGovernorate[row]
            }
            print("\(arrOfRegions[row])")
            
            return arrOfRegions[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if activeTextField == 1 {

                print(" &&&&&&&&&&&&&&&&******* ")
                self.row = row
                (self.view.viewWithTag(100) as! UITextField).text = arrOfGovernorate[row]
                print("\(arrOfGovernorate[row])")

                if let jsonString = networkParsingVar{
                    networkParsing(jsonString: jsonString, row: row)
                    print("\(arrOfRegions[0])")
                 //   placesPicker.reloadAllComponents()
                }
            }
            if activeTextField == 2 {
                
                if let view = self.view.viewWithTag(100){
                    if let textField = view as? UITextField{
                        if textField.text?.count==0{
                            textField.isSelected = false
                            return
                        }
                    }
                }
                
                (self.view.viewWithTag(101) as! UITextField).text = arrOfRegions[row]
                
               
            }
        }
        
    }


    extension SearchViewController{
        
        func networkParsing(jsonString: String, row: Int) {
            self.parse(json: jsonString, row: row)
            self.tableView.reloadData()
        }
        
        func rezervakwURL() -> URL {
            let urlString = String(format:
                "http://service.rezervakw.com/api/governorates")
            let url = URL(string: urlString)
            return url!}
        
        func performStoreRequest(with url: URL) -> String? {
            do {
                print("\(try String(contentsOf: url))")
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
                arrOfGovernorate = []
                if let dictionary = try JSONSerialization.jsonObject(
                    with: data, options: []) as? [String: Any]{
                    if let array = dictionary["data"] as? [Any]{
                        
                        for item in array{
                            if let item = item as? [String:Any]{
                                if let str = item["name"] as? String{
                                    arrOfGovernorate.append(str)
                                    print(". ******************** ")}
                            }}
                        for item in arrOfGovernorate{
                            print("\(item)")}
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


