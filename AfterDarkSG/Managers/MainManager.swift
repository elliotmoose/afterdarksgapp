//
//  MainManager.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation

public class MainManager
{
    public static func Initialize()
    {
        BarManager.Initialize()
        DiscountManager.Initialize()
        ImageManager.Initialize()
    }
}
