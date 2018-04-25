//
//  ImageManager.swift
//  AfterDarkSG
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 25/4/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import Foundation
import UIKit

public class ImageManager
{
    public static var barImages = [BarImage]()
    
    public static var didLoadABarImage = EventWithType<Int>()
    
    public static func Initialize()
    {
        BarManager.didLoadBars.addHandler {
            self.LoadBarImages()
        }
    }
    
    public static func LoadBarImages()
    {
        for bar in BarManager.GetList()
        {
            LoadBarImage(bar)
        }
    }
    
    private static func LoadBarImage(_ bar : Bar)
    {
        let url = Network.domain + "GetImageForBar/\(bar.ID)"
        
        Network.singleton.DataFromUrl(url) { (success, output) in
            do
            {
                guard let output = output else {throw NSError("no output")}
                if let image = BarImage(data: output)
                {
                    //init image
                    image.bar_id = bar.ID
                    barImages.append(image)
                    
                    bar.Images.removeAll() //if only got this one image
                    bar.Images.insert(image, at: 0)
                    
                    self.didLoadABarImage.raise(bar.ID)
                }
                    
                else if let responseDict = try JSONSerialization.jsonObject(with: output, options: .allowFragments) as? NSDictionary
                {
                    if let responseString = responseDict["output"] as? String
                    {
                        NSLog(responseString)
                    }
                }
            }
            catch let error as NSError
            {
                NSLog("\(error)")
            }
        }
    }
    
    private static func ImageWithBarID(_ id : Int) -> BarImage?
    {
        for image in barImages
        {
            if image.bar_id == id
            {
                return image
            }
        }
        
        return nil
    }
}

public class BarImage : UIImage
{
    public var bar_id : Int?
}
