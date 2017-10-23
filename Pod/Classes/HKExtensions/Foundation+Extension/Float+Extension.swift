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
        
        return self.hk_decimalPoint(2)
    }
    public func hk_getOneDecimal() -> String{
        
        return self.hk_decimalPoint(1)
    }
}



