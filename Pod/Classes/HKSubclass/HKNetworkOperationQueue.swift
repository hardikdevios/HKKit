//
//  HKNetworkOperationQueue.swift
//  Genemedics
//
//  Created by Hardik Shah on 28/09/17.
//  Copyright © 2017 Praxinfo. All rights reserved.
//

import Foundation


class HKNetworkOperationQueue:OperationQueue {
    
    
    
    var onCompleteOperation:((HKOperation)->())?
    
    
}
