//
//  Discount.swift
//  AfterDark
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 1/11/16.
//  Copyright © 2016 kohbroco. All rights reserved.
//

import Foundation
import UIKit

public class Discount
{
    var name : String?
    var details : String?
    var amount : String?
    var ID : Int?
    var bar_ID : Int?

    var expiry : TimeInterval = 0 //THIS IS FOR WALLET ONLY
    var curAvailCount : Int = 0
    var maxAvailCount : Int = 0
    
    var image : UIImage?
    
    
    init()
    {
        
    }
    
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
    
    public func ShouldBeResult(withQuery: String) -> Int
    {
        guard let name = name, let details = details else {return 0;}
        
        let query = withQuery.lowercased()
        if name.lowercased().contains(query)
        {
            return 3
        }
        
        if let id = ID, let bar = BarManager.BarWithID(id), bar.name.lowercased().contains(query)
        {
            return 2
        }

        
        
        return 0
    }
    
    public func SetExpiryDate(_ epoch: TimeInterval)
    {
        self.expiry = epoch
    }
}
