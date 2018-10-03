//
//  SettingsTableViewController.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 10/2/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var unitSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    @IBAction func SaveButtonPressed(_ sender: Any) {
        
        if unitSwitch.isOn{
           defaults.set("lb", forKey: "Unit")
        }else{
           defaults.set("kg", forKey: "Unit")
        }

    navigationController?.popToRootViewController(animated: true)
    }
    

}
