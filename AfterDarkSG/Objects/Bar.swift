import UIKit

public class Bar : NSObject{
    
    var name : String = ""
    var ID : Int = 0
    
    var discounts = [Discount]()
    var Images: [BarImage] = []
    
    //info
    var about : String = ""
    var price : String = ""
    var tags : String = ""
    var contact : String = ""
    var website : String = ""
    
    //location
    var loc_long : Double = 0
    var loc_lat : Double = 0
    var address_summary : String = ""
    var address_full : String = ""

    var totalReviewCount = 0

    
    
    //rating
    
    override init()
    {
        name = "Untitled"
        contact = ""
        website = ""
        ID = 0
    }
    
    init(_ dict : NSDictionary)
    {
        
        var errors = [String]();
        if let name = dict["name"] as? String
        {
            self.name = name
        }
        
        if let ID = dict["id"] as? Int64
        {
            self.ID = Int(ID)
        }
        
        if let about = dict["about"] as? String
        {
            self.about = about
        }
        
        if let price = dict["price"] as? String
        {
            self.price = price
        }
        
        if let contact = dict["contact"] as? String
        {
            self.contact = contact
        }
        
        if let website = dict["website"] as? String
        {
            self.website = website
        }
        
        if let tags = dict["tags"] as? String
        {
            self.tags = tags
        }
        
        if let loc_lat = dict["lat"] as? String
        {
            self.loc_lat = Double(loc_lat)!
        }
        else if let loc_lat = dict["lat"] as? Double
        {
            self.loc_lat = loc_lat
        }
        
        if let loc_long = dict["long"] as? String
        {
            self.loc_long = Double(loc_long)!
        }
        else if let loc_long = dict["long"] as? Double
        {
            self.loc_long = loc_long
        }
        
        if let addressSummary = dict["address_summary"] as? String
        {
            self.address_summary = addressSummary
        }
        
        if let address_full = dict["address_full"] as? String
        {
            self.address_full = address_full
        }


        else if let ratingCount = dict["ratingCount"] as? Int
        {
            self.totalReviewCount = ratingCount
        }
      
        if errors.count != 0
        {
            NSLog(errors.joined(separator: "\n"))
        }
        


    }
    
    
//
//
//    func SortDiscounts()
//    {
//        var exclusiveDisc = [Discount]()
//        var normalDisc = [Discount]()
//
//        for discount in discounts
//        {
//            if discount.exclusive
//            {
//                exclusiveDisc.append(discount)
//            }
//            else
//            {
//                normalDisc.append(discount)
//            }
//        }
//
//        self.discounts = exclusiveDisc
//        self.discounts.insert(contentsOf: normalDisc, at: exclusiveDisc.count)
//    }

    func DiscountAtIndex(_ index : Int) -> Discount?
    {
        if index >= 0 && index < discounts.count
        {
            return discounts[index]
        }
        else
        {
            return nil
        }
    }
    
    public func GetDisplayImage() -> BarImage?
    {
        if Images.count == 0
        {
            return nil
        }
        
        else
        {
            return Images[0]
        }
    }
    
    public func ShouldBeResult(withQuery : String) -> Int //0 = no, 1 = low priorirty, 2 = high priority, 3 = highest priority
    {
        let query = withQuery.lowercased()
        if name.lowercased().contains(query)
        {
            return 3
        }
        
        if address_full.lowercased().contains(query) || address_summary.lowercased().contains(query)
        {
            return 2
        }
        
        for discount in discounts
        {
            if let name=discount.name, let detail=discount.details
            {
                if name.lowercased().contains(query) || detail.lowercased().contains(query)
                {
                    return 1
                }
            }
        }
        
        return 0
    }
    
    
//
//    
//    func encodeWithCoder(aCoder : NSCoder)
//    {
//        aCoder.encode(self.name, forKey: "name")
//        aCoder.encode(self.ID, forKey: "ID")
//    }
//    
//    func decodeWithCoder(aDecoder : NSCoder)
//    {
//        if let name = aDecoder.decodeObject(forKey: "name") as? String
//        {
//            self.name = name
//        }
//        if let ID = aDecoder.decodeObject(forKey: "ID") as? String
//        {
//            self.ID = ID
//        }
//    }
}
