//
//  HKQueue.swift
//  Genemedics
//
//  Created by Plenar on 1/24/16.
//  Copyright © 2016 Plenar. All rights reserved.
//

import Foundation


public protocol ExcutableQueue {
    var queue: DispatchQueue { get }
}

extension ExcutableQueue {
    public func execute(_ closure: @escaping () -> Void) {
        queue.async(execute: closure)
    }
    public func executeAfter(_ seconds:Double,closure: @escaping () -> Void){
        let delayTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: delayTime,execute: closure)
        
    }
}

public enum HKQueue: ExcutableQueue {
    case main
    case userInteractive
    case userInitiated
    case utility
    case background
    
    public var queue: DispatchQueue {
        switch self {
        case .main:
            return DispatchQueue.main
        case .userInteractive:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        case .userInitiated:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        case .utility:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
        case .background:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        }
    }
}
