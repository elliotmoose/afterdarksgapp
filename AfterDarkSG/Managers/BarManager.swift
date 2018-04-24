//
//  BarManager.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation
import UIKit

public class BarManager
{
    private static var list = [Bar]()
    public static let didLoadBars = Event()
    
    public static func Initialize()
    {
        LoadBars()
        
        DiscountManager.didLoadDiscounts.addHandler {
            DistributeDiscounts()
        }
    }

    public static func DistributeDiscounts() {
        
        for bar in list
        {
            bar.discounts.removeAll()
        }
        
        for discount in DiscountManager.GetDiscounts()
        {
            var added = false
            if let ID = discount.bar_ID
            {
                if let bar = BarWithID(ID)
                {
                    bar.discounts.append(discount)
                    added = true
                }
            }
            
            if !added
            {
                NSLog("Discount failed to find a bar: \(discount.name) , ID: \(discount.bar_ID!)")
            }
        }
    }
    
    public static func LoadBars()
    {
        //let url = Network.domain + "GetBarNames"
        let url = Network.domain + "GetBarNames"
        Network.singleton.DataFromUrl(url) { (success, output) in
            
            do
            {
                guard let output = output else {throw NSError("no output")}
                guard let response = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary else {throw NSError("invalid response")}
                guard let requestSuccess = response["success"] as? String else {throw NSError("Invalid Response");}
                guard let barsDict = response["output"] as? [NSDictionary] else {throw NSError("Invalid Response");}
                
                if requestSuccess == "true"
                {
                    
                    list.removeAll()
                    for barDict in barsDict
                    {
                        //add bar to list
                        let bar = Bar(barDict)
                        list.append(bar)
                    }
                    
                    didLoadBars.raise()
                }
                else
                {
                    throw NSError("Server failed to load data")
                }

            }
            catch let error as NSError
            {
                NSLog("Bar Manager: \(error)")
            }
        }
    }
    
    public static func LoadBarImage(_ bar : Bar)
    {
        let url = Network.domain + "BarImage?ID=\(bar.ID)"
        
        Network.singleton.DataFromUrl(url) { (success, output) in
            do
            {
                guard let output = output else {throw NSError("no output")}
                guard let image = UIImage(data: output) else {throw NSError("invalid image")}
                
                bar.Images.insert(image, at: 0)
            }
            catch let error as NSError
            {
                NSLog("\(error)")

            }

        }
        
    }

    public static func LoadBarFull(_ bar : Bar)
    {
        let url = Network.domain + "BarDetail?ID=\(bar.ID)"
        
        Network.singleton.DataFromUrl(url) { (success, output) in
            do
            {
                guard let output = output else {throw NSError("no output")}
                guard let barDict = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary else {throw NSError("invalid response")}
                
                //discounts
                //images
                
                
            }
            catch let error as NSError
            {
                NSLog("\(error)")
            }

        }
    }
    
    
    //Retrival functions
    public static func GetList() -> [Bar]
    {
        return list
    }
    
    public static func BarAtIndex(_ index : Int) -> Bar?
    {
        if index >= 0 && index < list.count
        {
            return list[index]
        }
        else
        {
            return nil
        }
    }
    
    public static func BarWithID(_ ID : Int) -> Bar?
    {
        var output : Bar? = nil
        for bar in list
        {
            if bar.ID == ID
            {
                output = bar
            }
        }
        
        return output
    }
}
