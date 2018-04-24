//
//  Discount.swift
//  AfterDark
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 1/11/16.
//  Copyright © 2016 kohbroco. All rights reserved.
//

import Foundation

public class Discount
{
    var name : String?
    var details : String?
    var amount : String?
    var ID : Int?
    var bar_ID : Int?

    var curAvailCount : Int = 0
    var maxAvailCount : Int = 0
    
    init(dict : NSDictionary)
    {
        if let discName = dict["name"] as? String
        {
            name = discName
        }
        if let discDetails = dict["description"] as? String
        {
            details = discDetails
        }
        
        if let discID = dict["id"] as? Int64
        {
            ID = Int(discID)
        }
        
        if let barID = dict["bar_id"] as? Int64
        {
            bar_ID = Int(barID)
        }
        
        if let discAmount = dict["amount"] as? String
        {
            amount = discAmount
        }
        
        if let curAvailCount = dict["curAvailCount"] as? Int64
        {
            self.curAvailCount = Int(curAvailCount)
        }
        
        if let maxAvailCount = dict["maxAvailCount"] as? Int64
        {
            self.maxAvailCount = Int(maxAvailCount)
        }
        
    }
    
    init(name : String, details:String , amount : String, discountID : Int, bar_ID: Int)
    {
        self.name = name
        self.details = details
        self.amount = amount
        self.ID = discountID
        self.bar_ID = bar_ID
    }
}
