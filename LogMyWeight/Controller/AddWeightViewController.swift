//
//  AddWeightViewController.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 8/27/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit
import RealmSwift

class AddWeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var weightInt = Array(100...600)
    var weightDecimal = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
    
    var realm = try! Realm()
    var weightLog = WeightLog()
    var lastWeight : Double?
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var weight: UIPickerView!
    @IBOutlet weak var dateAdded: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weight.delegate = self
        weight.dataSource = self
        
        
        if lastWeight != nil {
            weightLog.weight = lastWeight!
        }// Previously Captured Weight
        
        if let i = weightInt.index(of: Int(weightLog.weight)){
            weight.selectRow(i, inComponent: 0, animated: true)
            print(weightLog.weight )
            
            let x = weightLog.weight.truncatingRemainder(dividingBy: 1.0).roundToDecimal(1)
            
            if let j = weightDecimal.index(of: x){  
                weight.selectRow(j, inComponent: 1, animated: true)
            }
        }else{
            weight.selectRow(150, inComponent: 0, animated: true)
        }
        


        
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        
//        self.navigationController?.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
        //Save Data
        do{
            try realm.write {

                weightLog.dateAdded = dateAdded.date
                realm.add(weightLog)
            }

        }catch{
            print("Error while saving the data,\(error)")
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
           return String(weightInt[row])
        }else{
           return String(weightDecimal[row])
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return weightInt.count
        }else{
            return weightDecimal.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            weightLog.weight = Double(weightInt[row])
        }else{
            weightLog.weight = weightLog.weight + weightDecimal[row]
        }
    }
    

}

extension Double{
    func roundToDecimal(_ fractionDigits: Int)-> Double{
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
