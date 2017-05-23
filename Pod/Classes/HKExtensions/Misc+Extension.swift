//
//  Misc+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 20/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

extension Alamofire.SessionManager
{
    fileprivate func cancelTasksByUrl(_ tasks: [URLSessionTask], url: String)
    {
        
        for task in tasks
        {
            guard let string = task.currentRequest?.url?.description else{
                continue
            }
            if string.hasPrefix(MAIN_URL + url)
            {
                task.cancel()
            }
        }
    }
    
    func cancelRequests(_ url: String)
    {
        self.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
                
                self.cancelTasksByUrl(dataTasks     as [URLSessionTask], url: url)
                self.cancelTasksByUrl(uploadTasks   as [URLSessionTask], url: url)
                self.cancelTasksByUrl(downloadTasks as [URLSessionTask], url: url)
        }
    }
}

extension RangeReplaceableCollection where Iterator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
}



public func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedSame
}

public func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}

public func >(lhs: Date, rhs: Date) -> Bool {
    return lhs.compare(rhs) == .orderedDescending
}

func += <KeyType, ValueType> (left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}














