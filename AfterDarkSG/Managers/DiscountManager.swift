//
//  DiscountManager.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation

public class DiscountManager
{
    private static var discounts = [Discount]()
    
    public static let didLoadDiscounts = Event()
    
    public static func Initialize()
    {
        BarManager.didLoadBars.addHandler {
            self.LoadDiscounts()
        }
    }
    
    public static func LoadDiscounts()
    {
        let url = Network.domain + "GetDiscounts"
        
        Network.singleton.DataFromUrl(url) { (success, output) in
            do
            {
                guard let output = output else {throw NSError("no output")}
                guard let response = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary else {throw NSError("invalid response")}
                guard let requestSuccess = response["success"] as? String else {throw NSError("Invalid Response");}
                guard let discountDicts = response["output"] as? [NSDictionary] else {throw NSError("Invalid Response");}
                
                if requestSuccess == "true"
                {
                    discounts.removeAll()
                    for discountDict in discountDicts
                    {
                        let discount = Discount(dict: discountDict)
                        discounts.append(discount)
                    }
                    
                    didLoadDiscounts.raise()
                }
                else
                {
                    throw NSError("Server failed to load data")
                }

            }
            catch let error as NSError
            {
                NSLog("Discount Manager: \(error)")
            }
        }
    }
    
    public static func GetDiscounts() -> [Discount]
    {
        return discounts
    }
    
    public static func GetDiscountWithID(_ ID : Int) -> Discount?
    {
        var output : Discount? = nil
        for discount in discounts
        {
            if discount.ID == ID
            {
                output = discount
            }
        }
        
        return output
    }
}
