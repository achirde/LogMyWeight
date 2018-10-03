//
//  WeightLogCell.swift
//  LogMyWeight
//
//  Created by Arkadipra De on 8/26/18.
//  Copyright © 2018 Achirangshu. All rights reserved.
//

import UIKit

class WeightLogCell: UITableViewCell {

    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var dateAdded: UILabel!
    @IBOutlet weak var unit: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
