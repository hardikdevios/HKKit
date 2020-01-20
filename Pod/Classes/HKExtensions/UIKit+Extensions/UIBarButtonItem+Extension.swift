//
//  UIBarButtonItem+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 20/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    open class func hk_getFlexibleButton()->UIBarButtonItem{
        
        
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
    }
    
    open class func hk_getFixedButton()->UIBarButtonItem{
        
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
    }
    
    
}
