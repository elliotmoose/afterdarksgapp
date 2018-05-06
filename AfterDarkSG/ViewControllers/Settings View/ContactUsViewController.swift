//
//  ContactUsViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 5/5/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    public static let singleton = ContactUsViewController(nibName: "ContactUsViewController", bundle: Bundle.main)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ContactUsViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("ContactUsViewController", owner: self, options: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
