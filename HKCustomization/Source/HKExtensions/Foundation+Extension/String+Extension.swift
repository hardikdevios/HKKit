//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension String {
    func toBool() -> Bool {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    static var uniqueGUID:String {
        get {
            return NSUUID().UUIDString
        }
    }
    
    var toJsonDict: Dictionary<String,AnyObject>?{
        return (try? NSJSONSerialization.JSONObjectWithData(self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, options: NSJSONReadingOptions.AllowFragments)) as? Dictionary<String,AnyObject>
        
    }
    
}
