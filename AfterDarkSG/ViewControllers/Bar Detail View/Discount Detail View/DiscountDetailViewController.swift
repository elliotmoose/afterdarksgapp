//
//  DiscountDetailViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 20/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class DiscountDetailViewController: UIViewController {
    public static let singleton = DiscountDetailViewController(nibName: "DiscountDetailViewController", bundle: Bundle.main)

    @IBOutlet weak var addressDetailTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var barNameLabel: UILabel!
    @IBOutlet weak var addressSummaryLabel: UILabel!
    @IBOutlet weak var discountNameLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var addressDetailLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var addressDetailDisplayed = false
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DiscountDetailViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("DiscountDetailViewController", owner: self, options: nil)
        
        imageContainerView.layer.borderColor = ColorManager.theme.cgColor
        imageContainerView.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("No Implementation")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Reset()
    }
    
    public func Reset()
    {
        addressDetailDisplayed = false
        SetDisplayDetailAddress(false)
    }
    
    public func DisplayDiscount(_ discount : Discount)
    {
        amountLabel.text = discount.amount
        discountNameLabel.text = discount.name
        
        
        self.textView.text = discount.details
        self.imageView.image = discount.image
        
        if let bar_id = discount.bar_ID, let bar = BarManager.BarWithID(bar_id)
        {
            let attributeTitle = NSMutableAttributedString(string: bar.name)
            attributeTitle.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "AvenirNext-Bold", size: 15), range: NSMakeRange(0, attributeTitle.length))
            attributeTitle.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.patternDot.rawValue | NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, attributeTitle.length))
            attributeTitle.addAttribute(NSAttributedStringKey.underlineColor, value: ColorManager.theme, range: NSMakeRange(0, attributeTitle.length))
            attributeTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributeTitle.length))
            
            
            self.barNameLabel.text = bar.name
            self.nameButton.setAttributedTitle(attributeTitle, for: .normal)
            self.addressSummaryLabel.text = bar.address_summary
            self.addressDetailLabel.text = bar.address_full
        }
    }
    
    @IBAction func nameButtonPressed(_ sender: Any) {
        if addressDetailDisplayed
        {
            SetDisplayDetailAddress(false)
        }
        else
        {
            SetDisplayDetailAddress(true)
        }
    }
    
    @IBAction func claimButtonPressed(_ sender: Any) {
        
    }
    

    
    private func SetDisplayDetailAddress(_ displayed : Bool)
    {
        addressDetailDisplayed = displayed
        
        if displayed
        {
            addressDetailTopConstraint.constant = 8
            addressDetailLabel.alpha = 1
        }
        else
        {
            addressDetailTopConstraint.constant = -nameButton.frame.height
            addressDetailLabel.alpha = 0
        }
    }
}
