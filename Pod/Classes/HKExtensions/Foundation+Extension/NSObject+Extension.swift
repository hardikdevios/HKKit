//
//  NSObject+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 23/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

extension NSObject {
    
    open func updateCoreData(_ mainblock: @escaping () -> Void) {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (sucess, error) in
            mainblock()
        }
        
    }
    
    
    open func updateCoreData(_ mainblock: @escaping (Bool?,Error?) -> Void) {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (sucess, error) in
            if sucess {
                mainblock(sucess, nil)
            } else {
                mainblock(false, error)
            }
        }
        
    }
    open func updateCoreData() -> Void {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (sucess, error) in
        }
        
        
    }
}
