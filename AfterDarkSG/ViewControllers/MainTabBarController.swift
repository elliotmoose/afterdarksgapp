//
//  MainTabBarController.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    public static var singleton : MainTabBarController? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "MainTabBarController", bundle: Bundle.main)
        Bundle.main.loadNibNamed("MainTabBarController", owner: self, options: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        if MainTabBarController.singleton == nil
        {
            MainManager.Initialize()

            MainTabBarController.singleton = self
        }
        
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.unselectedItemTintColor = ColorManager.theme
        let itemCount = 4
        self.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: ColorManager.theme, size: CGSize(width:Sizing.ScreenWidth()/CGFloat(itemCount), height: tabBar.frame.height))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserManager.LoadWallet()
    }
   

}
