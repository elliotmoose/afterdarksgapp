//
//  DiscountCollectionViewCell.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 22/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class DiscountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var veilView: UIView!
    
    @IBOutlet weak var unavailableLabel: UILabel!
    @IBOutlet weak var availCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderColor = ColorManager.theme.cgColor
        self.layer.borderWidth = 1
        
        unavailableLabel.layer.cornerRadius = 5
        unavailableLabel.clipsToBounds = true
    }
    
    public func DisplayDiscount(_ discount : Discount)
    {
        self.nameLabel.text = discount.name
        self.amountLabel.text = discount.amount
        self.availCountLabel.text = "\(discount.curAvailCount)/\(discount.maxAvailCount)"
        
        if discount.curAvailCount == 0
        {
            SetAvailable(false)
        }
        else
        {
            SetAvailable(true)
        }
    }
    
    public func SetAvailable(_ avail : Bool)
    {
        if avail
        {
            veilView.alpha = 0
        }
        else
        {
            veilView.alpha = 1
        }
    }

    
    
}
