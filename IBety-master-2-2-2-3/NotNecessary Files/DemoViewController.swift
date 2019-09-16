//
//  DemoViewController.swift
//  IBety
//
//  Created by Mohamed on 7/3/19.
//  Copyright © 2019 Mohamed. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!

    let anotherPicker = UIPickerView()
    
    var arrayOfCountries = ["India","USA","Germany","China", "France","Japan", "Australia", "Greece"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnotherPicker()
        
    }
    
    func createAnotherPicker()
    {
        let anotherPicker = UIPickerView()
        anotherPicker.delegate = self
        anotherPicker.delegate?.pickerView?(anotherPicker, didSelectRow: 0, inComponent: 0)
        textField1.inputView = anotherPicker
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfCountries[row]
    }
//
//    func createPickerView()
//    {
//        picker1.delegate = self
//        picker1.delegate?.pickerView?(picker1, didSelectRow: 0, inComponent: 0)
//        textField1.inputView = picker1
//        textField2.inputView = picker1
//        picker1.backgroundColor = UIColor.brown
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
