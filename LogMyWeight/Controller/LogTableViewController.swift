//
//  LogTableViewController.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 8/26/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit
import RealmSwift

class LogTableViewController: UITableViewController {

    var realm = try! Realm()
    var weightArray: Results<WeightLog>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(realm.configuration.fileURL)
        
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
            cell.weight?.text = String(weight.weight)
            cell.dateAdded.text = formatter.string(from: (weight.dateAdded))
        }
        
        return cell
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddWeight", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddWeightViewController
        if let lastWeight = weightArray?[0]{
            destinationVC.lastWeight = lastWeight.weight
        }
    }
    
    func loadData(){
        weightArray = realm.objects(WeightLog.self).sorted(byKeyPath: "dateAdded", ascending: false)
    }
    
}
