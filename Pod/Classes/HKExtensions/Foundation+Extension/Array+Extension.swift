//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
import CoreData

extension Array {
    
    public var hk_toJsonString: String?{
        return NSString(data:try! JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted), encoding:String.Encoding.utf8.rawValue) as String?
        
    }
    
    
    public var hk_toDictArrayForManagedObject:[[AnyHashable: Any]]{
        
        var temp = [[AnyHashable: Any]]()
        for obj in self{
            
            guard let obj = obj as? NSManagedObject else{
                continue
            }
            
            temp.append(obj.hk_toDict)
        }
        
        return temp
        
    }
    
    public subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
