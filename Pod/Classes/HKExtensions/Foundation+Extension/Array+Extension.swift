//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension Array {
    
    public var toJsonString: String?{
        return NSString(data:try! NSJSONSerialization.dataWithJSONObject(self as! AnyObject, options: NSJSONWritingOptions.PrettyPrinted), encoding:NSUTF8StringEncoding) as? String
        
    }
    
}