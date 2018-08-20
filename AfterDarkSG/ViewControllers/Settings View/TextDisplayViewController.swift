//
//  TextDisplayViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 17/5/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class TextDisplayViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    public static let singleton = TextDisplayViewController(nibName: "TextDisplayViewController", bundle: Bundle.main)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "TextDisplayViewController", bundle: Bundle.main)
        
        Bundle.main.loadNibNamed("TextDisplayViewController", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("no implementation")
    }
    
    public func SetText(_ text : String)
    {
        textView.text = text
    }
}
