//
//  AddWeightViewController.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 8/27/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit
import RealmSwift

struct weight {
    var weightKg: Double
    var weightLb: Double
}

class AddWeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var weightArray: [Int] = []
    var weightDecimal = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    
    var realm = try! Realm()
    var weightLog = WeightLog()
    var lastWeight : Double?
    //var lastweight: weight?
    
    let defaults = UserDefaults.standard
    let MULTIPLIER: Double = 0.453592
    
    
    @IBOutlet weak var weight: UIPickerView!
    @IBOutlet weak var dateAdded: UIDatePicker!
    @IBOutlet weak var unit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weight.delegate = self
        weight.dataSource = self
        
        initializeWeightArray()
        
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
        //Save Data
        
        saveData()

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {

            return String(weightArray[row])

        }else{
           return String(weightDecimal[row])
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return weightArray.count
        }else{
            return weightDecimal.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            weightLog.weight = Double(weightArray[row])
        }else{
            weightLog.weight = weightLog.weight + weightDecimal[row]
        }
        
    }
    
    // MARK: Custom Functions
    func initializeWeightArray(){
        
        let weightLb = Array(100...600)
        let weightKg = Array(10...200)
        
        if defaults.string(forKey: "Unit") == "kg"{
            weightArray = weightKg
        }else{
            weightArray = weightLb
        }
        
       
        weightLog.weight = lastWeight ?? 150

        if defaults.string(forKey: "Unit") == "kg"{
            weightLog.weight = (weightLog.weight * MULTIPLIER).roundToDecimal(1)
        }
        
        
        if let i = weightArray.index(of: Int(weightLog.weight)){
            weight.selectRow(i, inComponent: 0, animated: true)
            
//            let x = weightLog.weight.truncatingRemainder(dividingBy: 1.0).roundToDecimal(1)
//
//            if let j = weightDecimal.index(of: x){
//                weight.selectRow(j, inComponent: 1, animated: true)
//            }
        }
        
        unit.text = defaults.string(forKey: "Unit")
        
    }
    
    func saveData(){
        
        if defaults.string(forKey: "Unit") == "kg"{
            weightLog.weight = (weightLog.weight / MULTIPLIER).roundToDecimal(1)
        }
        
        do{
            try realm.write {
                
                weightLog.dateAdded = dateAdded.date
                realm.add(weightLog)
            }
        }catch{
            print("Error while saving the data,\(error)")
        }
    }

}

extension Double{
    func roundToDecimal(_ fractionDigits: Int)-> Double{
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
