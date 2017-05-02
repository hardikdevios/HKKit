//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension String {
    public func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    static var uniqueGUID:String {
        get {
            return UUID().uuidString
        }
    }
    
    public var toJsonDict: Dictionary<String,AnyObject>?{
        return (try? JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8, allowLossyConversion: false)!, options: JSONSerialization.ReadingOptions.allowFragments)) as? Dictionary<String,AnyObject>
        
    }
    
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    public func toRange()->NSRange{
     
        let range = self.range(of: self)
        
       return NSMakeRange(self.characters.distance(from: self.startIndex, to: range!.lowerBound),self.characters.count)

    }
    
    
}
extension String {
    
    
    public func trimWhiteSpace()->String?{
        
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
        
    }
}
