//
//  DiscountManager.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 19/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation
import UIKit

public class DiscountManager
{
    private static var discounts = [Discount]()
    
    public static let images = [#imageLiteral(resourceName: "image-bank-0"),#imageLiteral(resourceName: "image-bank-1"),#imageLiteral(resourceName: "image-bank-2"),#imageLiteral(resourceName: "image-bank-3"),#imageLiteral(resourceName: "image-bank-4"),#imageLiteral(resourceName: "image-bank-5"),#imageLiteral(resourceName: "image-bank-6"),#imageLiteral(resourceName: "image-bank-7"),#imageLiteral(resourceName: "image-bank-8"),#imageLiteral(resourceName: "image-bank-9")]
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
                        
                        var imageIndex = discounts.count
                        while imageIndex >= images.count
                        {
                            imageIndex = imageIndex - images.count
                        }
                        
                        discount.image = images[imageIndex]
                        
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
    
    public static func AddToWallet(discountID : Int)
    {
        
    }
    
    public static func Claim(discountID : Int, passcode : String, _ callback : @escaping (Bool,String)-> Void)
    {
        
        do
        {
            guard let user_id = UserManager.user_id else {throw NSError("No User ID")}
            guard let discount = GetDiscountWithID(discountID) else {throw NSError("Discount with id \(discountID) does not exist")}
            guard let barID = discount.bar_ID else {throw NSError("No bar ID")}
            guard let bar = BarManager.BarWithID(barID) else{throw NSError("No Bar with ID")}
            guard bar.passcode == passcode else {throw NSError("Wrong Passcode")}
            
            let url = Network.domain + "AddDiscountClaim"
            let postParam = "user_id=\(user_id)&discount_id=\(discountID)"
            
            Network.singleton.DataFromUrlWithPost(url, postParam: postParam) {
                (success, output) -> Void in
                
                do
                {
                    guard success else {throw NSError("Connect Error")}
                    guard let output = output, let dict = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary, let succ = dict["success"] as? String else {throw NSError("Invalid server response")}
                    
                    if succ == "true"
                    {
                        if let responseArray = dict["output"] as? [NSDictionary]
                        {
                            var discIDs = [Int64]()
                            for discDict in responseArray
                            {
                                if let id = discDict["id"] as? Int64
                                {
                                    discIDs.append(id)
                                }
                            }
                            
                            UserManager.SetWallet(walletIDs: discIDs)
                        }
                        
                        callback(true,"discount claimed")
                    }
                    else
                    {
                        if let detail = dict["output"] as? String
                        {
                            NSLog(detail)
                            callback(false,detail)
                        }
                        else
                        {
                            callback(false,"No details")
                        }
                        
                    }
                }
                catch let error as NSError
                {
                    NSLog(error.domain)
                    callback(false,error.domain)
                }
            }
        }
        catch let e as NSError
        {
            NSLog(e.domain)
            callback(false,e.domain)
        }
    }
    
    public static func AddToWallet(discountID : Int,_ callback : @escaping (Bool,String)-> Void)
    {
        do
        {
            guard let user_id = UserManager.user_id else {throw NSError("No User ID")}
            guard let discount = GetDiscountWithID(discountID) else {throw NSError("Discount with id \(discountID) does not exist")}
            
            let url = Network.domain + "AddDiscountToWalletForUser"
            let postParam = "user_id=\(user_id)&discount_id=\(discountID)"
            
            Network.singleton.DataFromUrlWithPost(url, postParam: postParam) {
                (success, output) -> Void in
                
                do
                {
                    guard success else {throw NSError("Connect Error")}
                    guard let output = output, let dict = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary, let succ = dict["success"] as? String else {throw NSError("Invalid server response")}
                    
                    if succ == "true"
                    {
                        guard let responseArray = dict["output"] as? [NSDictionary] else {throw NSError("Invalid Response - array");}
                        
                        var ids = [Int64]()
                        for dict in responseArray
                        {
                            if let id = dict["id"] as? Int64
                            {
                                ids.append(id)
                            }
                        }
                        
                        UserManager.SetWallet(walletIDs: ids)
                        discount.curAvailCount = discount.curAvailCount-1 //artificially change this
                        callback(true,"discount added")
                    }
                    else
                    {
                        if let detail = dict["output"] as? String
                        {
                            NSLog(detail)
                            callback(false,detail)
                        }
                        else
                        {
                            callback(false,"No details")
                        }
                    }
                }
                catch let error as NSError
                {
                    NSLog(error.domain)
                    callback(false,error.domain)
                }
            }
        }
        catch let e as NSError
        {
            NSLog(e.domain)
            callback(false,e.domain)
            
        }
    }
}
