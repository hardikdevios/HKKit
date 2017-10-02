//
//  HKMultiCastDelegate.swift
//  HKKit
//
//  Created by Hardik Shah on 02/10/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
open class HKMulticastDelegate <T> {
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    public func add(delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    public func remove(delegate: T) {
        for oneDelegate in delegates.allObjects.reversed() {
            if oneDelegate === delegate as AnyObject {
                delegates.remove(oneDelegate)
            }
        }
    }
    
    public func invoke(invocation: (T) -> ()) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
}

public func += <T: AnyObject> (left: HKMulticastDelegate<T>, right: T) {
    left.add(delegate: right)
}

public func -= <T: AnyObject> (left: HKMulticastDelegate<T>, right: T) {
    left.remove(delegate: right)
}
