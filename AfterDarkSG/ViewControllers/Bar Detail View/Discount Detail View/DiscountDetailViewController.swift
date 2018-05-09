//
//  DiscountDetailViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 20/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

public enum DiscountDetailDisplayMode
{
    case windowShop
    case wallet
}

class DiscountDetailViewController: UIViewController {
    //public static let singleton = DiscountDetailViewController(nibName: "DiscountDetailViewController", bundle: Bundle.main)

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
    @IBOutlet weak var claimButton: UIButton!
    
    var addressDetailDisplayed = false
    var selectedDiscount : Discount?
    var mode : DiscountDetailDisplayMode = DiscountDetailDisplayMode.wallet
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
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if mode == .wallet
        {
            //check if user owns this discount
            var hasDiscount = false
            
            for discount in UserManager.wallet
            {
                if discount.ID == selectedDiscount?.ID
                {
                    hasDiscount = true
                }
            }
            
            if !hasDiscount
            {
                self.Dismiss()
            }
        }

        
        
    }
    
    public func Reset()
    {
        addressDetailDisplayed = false
        SetDisplayDetailAddress(false)
    }
    
    func SetMode(_ mode : DiscountDetailDisplayMode)
    {
        if mode == .wallet
        {
            claimButton.setTitle("Claim Now", for: .normal)
        }
        else
        {
            claimButton.setTitle("Add To Wallet", for: .normal)
        }
        
        self.mode = mode
    }
    
    public func DisplayDiscount(_ discount : Discount)
    {
        selectedDiscount = discount
        
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
        
        if mode == .wallet
        {
            PasscodeViewController.singleton.selectedDiscountID = selectedDiscount?.ID
            navigationController?.pushViewController(PasscodeViewController.singleton, animated: true)
        }
        else
        {
            if let id = selectedDiscount?.ID
            {
                DiscountManager.AddToWallet(discountID: id)
                {
                    success,output in
                    
                    if success
                    {
                        PopupManager.singleton.Popup(title: "Done!", body: "The discount has been added to your wallet :)", presentationViewCont: self)
                        {
                            self.Dismiss()
                        }
                    }
                    else
                    {
                        PopupManager.singleton.Popup(title: "Hmm..", body: "There has been an error: " + output, presentationViewCont: self)
                    }
                }
            }
            else
            {
                NSLog("DiscountDetailViewController: no discount id")
            }
        }
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
    
    func Dismiss()
    {
        DispatchQueue.main.async {
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
