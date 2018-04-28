//
//  PasscodeViewController.swift
//  AfterDark
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 5/2/17.
//  Copyright © 2017 kohbroco. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController,UIKeyInput{

    static let singleton = PasscodeViewController(nibName: "PasscodeViewController", bundle: Bundle.main)
    
    let numberOfDigits = 4
    var inputPass = ""
    var selectedDiscountID : Int?
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "PasscodeViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("PasscodeViewController", owner: self, options: nil)
        
        
        //add instruction label
        let labelFontSize : CGFloat = 40
        let label2FontSize : CGFloat = 14
        let padding : CGFloat = 40
        
        let instructLabel = UILabel(frame: CGRect(x: 0, y: padding, width: Sizing.ScreenWidth(), height: labelFontSize))
        instructLabel.text = "Enter \(numberOfDigits)-Digit Pin"
        instructLabel.textAlignment = .center
        instructLabel.font = UIFont(name: "Mohave-Bold", size: labelFontSize)
        self.view.addSubview(instructLabel)
        
        //add text views
        let textViewWidth : CGFloat = 50
        let textViewHeight : CGFloat = 200
        let textViewSpacing : CGFloat = (Sizing.ScreenWidth() - (CGFloat(numberOfDigits)*textViewWidth))/CGFloat(numberOfDigits+1)
        
        for i in 0...numberOfDigits-1
        {
            let textView = UITextView(frame: CGRect(x: textViewSpacing*CGFloat(i+1) + CGFloat(i)*textViewWidth, y: padding + labelFontSize, width: textViewWidth, height: textViewHeight))
            textView.tag = i+1
            self.view.addSubview(textView)
            
            
            //design
            textView.text = "-"
            textView.isScrollEnabled = false
            textView.isEditable = false
            textView.textAlignment = .center
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "Mohave", size: 150)
            textView.backgroundColor = UIColor.clear
            
        }
        
        let instructLabel2 = UILabel(frame: CGRect(x: 16, y: padding + textViewHeight, width: Sizing.ScreenWidth() - 32, height: label2FontSize*3))
        instructLabel2.numberOfLines = 3
        instructLabel2.text = "Let the staff key in the code"
        instructLabel2.textAlignment = .center
        instructLabel2.font = UIFont(name: "Montserrat", size: label2FontSize)
        instructLabel2.textColor = UIColor.gray
        self.view.addSubview(instructLabel2)


        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.resignFirstResponder()
        self.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.resignFirstResponder()
        
        //reset
        ResetFields()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //Need to calculate keyboard exact size due to Apple suggestions
        
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        
        let keyboardHeight = keyboardSize?.height
        buttonBottomConstraint.constant = keyboardHeight! - Sizing.tabBarHeight
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        
        buttonBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }

    
    func UpdateDisplay()
    {
        DispatchQueue.main.async {
            
            //for each text view
            for i in 0...self.numberOfDigits-1
            {
                if let thisTextView = self.view.viewWithTag(i+1) as? UITextView
                {
                    thisTextView.text.removeAll()
                    
                    //if this textView is suppose to have text
                    if i < self.inputPass.length
                    {
                        thisTextView.text = "•"
//                        thisTextView.text = self.inputPass[i]
                    }
                    else //remove
                    {
                        thisTextView.text = "-"
                    }
                }
            }
        }
    }
    
    //delegate functions
    override var canBecomeFirstResponder: Bool
    {
        return true
    }
    func insertText(_ text: String) {
        
        if inputPass.length < numberOfDigits
        {
            if text.length == 1
            {
                inputPass += text
                UpdateDisplay()
            }
        }
        
    }
    
    func deleteBackward() {
        
        if inputPass != ""
        {
            inputPass.removeLast()
            
            UpdateDisplay()
        }
        
    }
    var hasText: Bool
    {
        if inputPass != ""
        {
            return true
        }
        else
        {
            return false
        }
    }

    var keyboardType: UIKeyboardType = UIKeyboardType.numberPad

    @IBAction func confirmButtonPressed(_ sender: Any) {
        self.SubmitClaim()
    }
    
    
    func SubmitClaim()
    {
        if inputPass == "" || inputPass.length != numberOfDigits
        {
            PopupManager.singleton.Popup(title: "Invalid Input", body: "Please enter passcode", presentationViewCont: self)
            return
        }

        guard let discountID = selectedDiscountID else {
            PopupManager.singleton.Popup(title: "Hmm..", body: "No discount selected :X try again!", presentationViewCont: self)
            self.Dismiss()
            return
        }
        
        
        DiscountManager.Claim(discountID: discountID, passcode: inputPass,{
            (success,output) -> Void in
            
            if success
            {
                PopupManager.singleton.Popup(title: "Success!", body: "Discount validated! \n Enjoy:)", presentationViewCont: self){
                    self.Dismiss()
                }
            }
            else
            {
                if output == "Connect Error"
                {
                    PopupManager.singleton.ConnectionErrorPopup(self)
                }
                else if output == "Wrong Passcode"
                {
                    PopupManager.singleton.Popup(title: "Failed :(", body: "Incorrect passocde", presentationViewCont: self)
                }
                else
                {
                    PopupManager.singleton.Popup(title: "Failed :(", body: "There seems to be an issue.. Please try again later", presentationViewCont: self)
                }
            }
        })
    }
    
    func ResetFields()
    {
        selectedDiscountID = nil
        inputPass = ""
        for i in 0...self.numberOfDigits-1
        {
            if let thisTextView = self.view.viewWithTag(i+1) as? UITextView
            {
                thisTextView.text = "-"
            }
        }
    }
    
    func Dismiss()
    {
        DispatchQueue.main.async {
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
