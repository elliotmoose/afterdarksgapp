//
//  BarTableViewCell.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func DisplayBar(_ bar : Bar)
    {
        self.nameLabel.text = bar.name
        self.locationLabel.text = bar.address_summary
        self.priceLabel.text = bar.price
        
        if let image = bar.GetDisplayImage()
        {
            self.backgroundImage.alpha = 0.55
            self.backgroundImage.image = image
        }
        else
        {
            self.backgroundImage.alpha = 0.1
            self.backgroundImage.image = #imageLiteral(resourceName: "Category_Pre-Drinks")
        }
    }
}
