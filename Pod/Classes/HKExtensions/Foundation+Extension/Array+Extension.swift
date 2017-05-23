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
    
    public var toJsonString: String?{
        return NSString(data:try! JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted), encoding:String.Encoding.utf8.rawValue) as String?
        
    }
    
    
    var toDictArrayForManagedObject:[[AnyHashable: Any]]{
        
        var temp = [[AnyHashable: Any]]()
        for obj in self{
            
            guard let obj = obj as? NSManagedObject else{
                continue
            }
            
            temp.append(obj.toDict)
        }
        
        return temp
        
    }
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
