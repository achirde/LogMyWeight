//
//  LogTableViewController.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 8/26/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import GoogleSignIn

class LogTableViewController: UITableViewController {
    
    var realm = try! Realm()
    var weightArray: Results<WeightLog>?
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(realm.configuration.fileURL)
        
        if defaults.string(forKey: "Unit") == nil{
            defaults.set("lb", forKey: "Unit")
        }
        
        tableView.rowHeight = 70
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weightArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("WeightLogCell", owner: self, options: nil)?.first as! WeightLogCell
        
        //let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        if let weight = weightArray?[indexPath.row] {
            cell.unit?.text = defaults.string(forKey: "Unit")
            
            if defaults.string(forKey: "Unit") == "kg" {
               cell.weight?.text = String((weight.weight * 0.453592 ).roundToDecimal(1) )
            }else{
               cell.weight?.text = String((weight.weight).roundToDecimal(1))
            }
            

            cell.dateAdded.text = formatter.string(from: (weight.dateAdded))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if let weightLog = self.weightArray?[indexPath.row] {
                
                do{
                    try self.realm.write{
                        self.realm.delete(weightLog)
                        self.tableView.reloadData()
                    }
                }catch{
                    print("Error in deleting the record,\(error)")
                }
            }
            
        }
        return [delete]
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddWeight", sender: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "goToAddWeight"{
            let destinationVC = segue.destination as! AddWeightViewController
            if weightArray?.count != 0 {
                if let lastWeight = weightArray?[0]{
                   destinationVC.lastWeight = lastWeight.weight
                }
            }
        }
    }
    
    func loadData(){
        weightArray = realm.objects(WeightLog.self).sorted(byKeyPath: "dateAdded", ascending: false)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("Signed Out")
        }catch{
            print("Error while sign out,\(error)")
        }
        
        GIDSignIn.sharedInstance()?.disconnect()
        GIDSignIn.sharedInstance()?.signOut()
        
    }
    
    
}

//extension Double{
//    func roundToDecimal(_ fractionDigits: Int)-> Double{
//        let multiplier = pow(10, Double(fractionDigits))
//        return Darwin.round(self * multiplier) / multiplier
//    }
//}
