//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension Float{
    
    func getTwoDecimal() -> String{
        
        return String(format: "%.2f",self)
    }
    func getOneDecimal() -> String{
        
        return String(format: "%.f",self)
    }
}



