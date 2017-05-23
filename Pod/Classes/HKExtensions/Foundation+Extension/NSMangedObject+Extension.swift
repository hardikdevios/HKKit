
//
//  NSMangedObject+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 23/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    
    public var hk_toDict:[AnyHashable: Any]{
        
        
        return self.dictionaryWithValues(forKeys: Array(self.entity.attributesByName.keys))
        
    }
}
