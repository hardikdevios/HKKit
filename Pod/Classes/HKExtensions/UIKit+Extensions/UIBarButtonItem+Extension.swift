//
//  UIBarButtonItem+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 20/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation

extension UIBarButtonItem {
    
    class func getFlexibleButton()->UIBarButtonItem{
        
        
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
    }
    
    class func getFixedButton()->UIBarButtonItem{
        
        return UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
    }
    
    
}
