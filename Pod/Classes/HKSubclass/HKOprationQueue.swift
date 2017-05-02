//
//  HKoperationQueue.swift
//  Genemedics
//
//  Created by Plenar on 6/2/16.
//  Copyright © 2016 Plenar. All rights reserved.
//

import Foundation
open class ConcurrentOperation : Operation {
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    fileprivate var _executing: Bool = false
    override open var isExecuting: Bool {
        get {
            return _executing
        }
        set {
            if (_executing != newValue) {
                self.willChangeValue(forKey: "isExecuting")
                _executing = newValue
                self.didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    fileprivate var _finished: Bool = false;
    override open var isFinished: Bool {
        get {
            return _finished
        }
        set {
            if (_finished != newValue) {
                self.willChangeValue(forKey: "isFinished")
                _finished = newValue
                self.didChangeValue(forKey: "isFinished")
            }
        }
    }
    
    func completeOperation() {
        isExecuting = false
        isFinished  = true
    }
    
    override open func start() {
        
        
        if (isCancelled) {
            isFinished = true
            return
        }
        
        isExecuting = true
        main()
    }
}

