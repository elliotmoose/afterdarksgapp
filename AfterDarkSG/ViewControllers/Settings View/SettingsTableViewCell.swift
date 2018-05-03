//
//  SettingsTableViewCell.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 3/5/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
