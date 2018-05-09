//
//  UserManager.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 23/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation
import UIKit

public class UserManager
{
    public static var user_id : String?
    
    //Events
    public static let didInitNewUser = Event()
    public static let userCreatedBefore = Event()
    public static let didFailInitNewUser = Event()
    public static let didFailConnect = Event()
    public static let didUpdateWallet = Event()
    
    public static var wallet = [Discount]()
    public static var walletIDs = [Int64]()
    
    
    public static let test_reset_user_id_on_load = false
    
    public static func Initialize()
    {
        DiscountManager.didLoadDiscounts.addHandler {
            self.PopuplateWalletFromString()
        }
        
        Load()
    }
    
    public static func Save()
    {
        let ud = UserDefaults.standard
        
        ud.set(user_id, forKey: "user_id")
    }
    
    public static func Load()
    {
        let ud = UserDefaults.standard
        
        //test
        if test_reset_user_id_on_load
        {
            ud.removeObject(forKey: "user_id")
        }
        
        if let user_id = ud.value(forKey: "user_id") as? String
        {
            self.user_id = user_id
        }
    }
    
    //requests new identity
    public static func InitUser()
    {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        
        let url = Network.domain + "GenerateUser"
        let postParams = "uuid=\(uuid.AddPercentEncodingForURL(plusForSpace: true)!)"
        Network.singleton.DataFromUrlWithPost(url, postParam: postParams) {(success, output) in
            if !success {
                self.didFailConnect.raise()
                NSLog("Cant connect to server")
                return
            }
            
            do
            {
                guard let output = output else {throw NSError("No output");}
                guard let response = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary else {throw NSError("Invalid Response");}
                guard let requestSuccess = response["success"] as? String else {throw NSError("Invalid Response");}
                if let requestOutput = response["output"] as? NSDictionary
                {
                    if requestSuccess == "true"
                    {
                        if let id = requestOutput["insertId"] as? Int64
                        {
                            self.user_id = "\(id)"
                            self.Save()
                            self.didInitNewUser.raise()
                            return
                        }
                        else
                        {
                            self.didFailInitNewUser.raise()
                            throw NSError("Successfully created without ID response")
                            return
                        }
                    }
                    else
                    {
                        if let errorCode = requestOutput["code"] as? String
                        {
                            if errorCode == "ER_DUP_ENTRY"
                            {
                                self.userCreatedBefore.raise()
                                return
                            }
                            
                            throw NSError(errorCode)
                        }
                    }
                }
                else if let requestOutputString = response["output"] as? String
                {
                    NSLog(requestOutputString);
                }
                else {throw NSError("Invalid Response");}
            }
            catch let error as NSError
            {
                self.didFailInitNewUser.raise()
                NSLog("\(error)")
            }
        }
    }
    
    public static func RetrieveUser()
    {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        
        let url = Network.domain + "RetrieveUser"
        let postParams = "uuid=\(uuid.AddPercentEncodingForURL(plusForSpace: true)!)"
        Network.singleton.DataFromUrlWithPost(url, postParam: postParams) {(success, output) in
            if !success {
                self.didFailConnect.raise()
                NSLog("Cant connect to server")
                return
            }
            
            do
            {
                guard let output = output else {throw NSError("No output");}
                guard let response = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary else {throw NSError("Invalid Response - json serialization");}
                guard let requestSuccess = response["success"] as? String else {throw NSError("Invalid Response - success");}
                
                if requestSuccess == "true"
                {
                    guard let responseArray = response["output"] as? NSArray else {throw NSError("Invalid Response - array");}
                    guard responseArray.count > 0 else {throw NSError("Invalid Response - array length");}
                    guard let responseDict = responseArray[0] as? NSDictionary else {throw NSError("Invalid Response - dict");}
                    guard let id = responseDict["id"] as? Int64 else {throw NSError("Invalid Response - id");}
                    
                    NSLog("User retrieved successfully")
                    self.user_id = "\(id)"
                    self.Save()
                    self.didInitNewUser.raise()
                    return
                }
                else if let requestOutputString = response["output"] as? String
                {
                    NSLog(requestOutputString);
                }
            }
            catch let error as NSError
            {
                NSLog("\(error)")
            }
            
            self.didFailInitNewUser.raise()
        }
    }
    
    public static func LoadWallet()
    {
        guard let id = user_id else {NSLog("Cant load wallet without user id");return;}
        let url = Network.domain + "GetWalletForUser"
        
        let postParams = "id=\(id)"
        Network.singleton.DataFromUrlWithPost(url, postParam: postParams) {(success, output) in
            if !success {
                NSLog("Cant connect to server")
                return
            }
            
            do
            {
                guard let output = output else {throw NSError("No output");}
                guard let response = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary else {throw NSError("Invalid Response - json serialization");}
                guard let requestSuccess = response["success"] as? String else {throw NSError("Invalid Response - success");}
                
                if requestSuccess == "true"
                {
                    guard let responseArray = response["output"] as? [NSDictionary] else {throw NSError("Invalid Response - array");}
                    
                    var ids = [Int64]()
                    for dict in responseArray
                    {
                        if let id = dict["id"] as? Int64
                        {
                            ids.append(id)
                        }
                    }
                    
                    SetWallet(walletIDs: ids)
                    return
                }
                else if let requestOutputString = response["output"] as? String
                {
                    NSLog(requestOutputString);
                }
            }
            catch let error as NSError
            {
                NSLog("\(error)")
            }
        }
    }
    
    public static func SetWallet(walletIDs: [Int64])
    {
        self.walletIDs = walletIDs
        self.PopuplateWalletFromString()
    }
    
    private static func PopuplateWalletFromString()
    {
        guard DiscountManager.GetDiscounts().count > 0 else {NSLog("Discounts likely not loaded yet");return;}
        wallet.removeAll()
        
        for id in walletIDs
        {
            if let discount = DiscountManager.GetDiscountWithID(Int(id))
            {
                wallet.append(discount)
            }
        }
        
        didUpdateWallet.raise()
    }
}

