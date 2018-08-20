//
//  Tile.swift
//  SmartWindows
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 17/5/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class Tile: UIButton {

    var isOpen = false
    public var coordinate = (0,0)
    
    
    public func Swap()
    {
        isOpen = !isOpen
        
        if isOpen
        {
            self.backgroundColor = UIColor.white
        }
        else
        {
            self.backgroundColor = UIColor.gray
        }
    }
    
    public func ForceOpen()
    {
        self.isOpen = true
        self.backgroundColor = UIColor.white
    }

}
