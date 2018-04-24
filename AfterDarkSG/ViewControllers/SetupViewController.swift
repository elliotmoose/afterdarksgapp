//
//  SetupViewController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 24/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    public static let singleton = SetupViewController(nibName: "SetupViewController", bundle: Bundle.main)
    
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    var setupFinished = false
    @IBOutlet weak var tryAgainButton: UIButton!
    
    @IBAction func TryAgain(_ sender: Any) {
        UserManager.InitUser()
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SetupViewController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("SetupViewController", owner: self, options: nil)
        
        tryAgainButton.layer.borderColor = ColorManager.theme.cgColor
        tryAgainButton.layer.borderWidth = 2
        tryAgainButton.layer.cornerRadius = 5
        
        UserManager.didInitNewUser.addHandler {
            self.SetupFinished()
        }
        
        UserManager.didFailInitNewUser.addHandler {
            PopupManager.singleton.Popup(title: "Server Error", body: "The setup could not be completed at this time. Please try again later", presentationViewCont: self)
            
            DispatchQueue.main.async {
                self.tryAgainButton.alpha = 1
            }
        }
        
        UserManager.didFailConnect.addHandler {
            PopupManager.singleton.Popup(title: "Connection Error", body: "Could not connect to server. \n Please check your connection and try again", presentationViewCont: self)
            
            DispatchQueue.main.async {
                self.tryAgainButton.alpha = 1
            }
        }
        
        UserManager.userCreatedBefore.addHandler {
            PopupManager.singleton.Popup(title: "Hmm..", body: "The setup has already been done for this device. Attempting to retrieve user...", presentationViewCont: self)
            {
                //RETRIEVE
                UserManager.RetrieveUser()
            }

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(_ animated: Bool) {

        circleProgressView.Initialize(strokeColor: ColorManager.theme)
        
        BeginSetup()

    }
    
    func BeginSetup()
    {
        circleProgressView.progress = 0
        AnimateLabelToValue(0.3,from: 0,breakable:true,{
            self.setupFinished = false
            UserManager.InitUser()
        })
        
        circleProgressView.SetProgressValue(0.3)

        
    }
    
    func AnimateLabelToValue(_ value : Float,from : Float,breakable: Bool,_ callback: @escaping () -> Void)
    {
        if value == from
        {
            NSLog("AnimateLabelToValue: to and from same value")
            return
        }
        
        let currentValue = Int(floorf(from*100))
        let maxValue = Int(floorf(value*100))
        
        let animationTime = 9*100000; //0.9 seconds
        
        let animationInterval = animationTime/(maxValue-currentValue)
        
        DispatchQueue.global(qos: .default).async{
            for i in currentValue...maxValue
            {
                if self.setupFinished && breakable
                {
                    break;
                }
                
                usleep(useconds_t(animationInterval));
                DispatchQueue.main.async {
                    self.progressLabel.text = "\(i)%"
                }
            }
            
            callback()
        }
        
    }
    
    
    func SetupFinished()
    {
        setupFinished = true //this is to break previous animation
        
        DispatchQueue.main.async {
            self.circleProgressView.SetProgressValue(1)
            
            self.AnimateLabelToValue(1,from: 0.3,breakable:false,{
                DispatchQueue.main.async {
                    
                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                        window.rootViewController = mainStoryboard.instantiateInitialViewController()
                    }
                }
            })
        }
    }
    
    

}
