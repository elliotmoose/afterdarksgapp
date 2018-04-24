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
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DiscountDetailViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("DiscountDetailViewController", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("No Implementation")
    }
    
    public func DisplayDiscount(_ discount : Discount)
    {
        
    }
}
