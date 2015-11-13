//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension Dictionary {
    
    func removeNilFromDict(var dict:Dictionary<NSObject,AnyObject!>) -> Dictionary<NSObject,AnyObject!>{
        
        
        for (key,name) in dict{
            if name == nil || name as? NSNull != nil{
                dict.updateValue("", forKey: key)
            }
        }
        return dict
    }
    
    
}