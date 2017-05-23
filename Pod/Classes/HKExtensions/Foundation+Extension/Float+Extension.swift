//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension Float{
    
    public func hk_getTwoDecimal() -> String{
        
        return String(format: "%.2f",self)
    }
    public func hk_getOneDecimal() -> String{
        
        return String(format: "%.f",self)
    }
}



