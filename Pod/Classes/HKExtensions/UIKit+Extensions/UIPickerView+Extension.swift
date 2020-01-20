
//
//  UIPickerView+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 23/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import UIKit
extension UIPickerView {
    
    public func hk_stopScrolling() {
        
        let delegate = self.delegate
        let dataSource = self.dataSource
        self.delegate = nil
        self.dataSource = nil
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    
    
}
