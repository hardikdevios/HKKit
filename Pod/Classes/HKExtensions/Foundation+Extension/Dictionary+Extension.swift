//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension Dictionary {
    
    public func removeNilFromDict(_ dict:inout Dictionary<NSObject,AnyObject?>) -> Dictionary<NSObject,AnyObject?>{
        
        
        for (key,name) in dict{
            if name == nil || name as? NSNull != nil{
                dict.updateValue("" as AnyObject?, forKey: key)
            }
        }
        return dict
    }
    
    
    public var toJsonString: String?{
            return NSString(data:try! JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted), encoding:String.Encoding.utf8.rawValue) as String?
            
    }
        

}
