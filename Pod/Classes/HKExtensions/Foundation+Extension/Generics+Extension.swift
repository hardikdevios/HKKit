
//
//  Generics+Extension.swift
//  HKKit
//
//  Created by Hardik Shah on 23/10/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit

public protocol DecimalConversion: FloatingPoint {
    func hk_decimalPoint(_ decimalPoint:Int)->String
    
}

extension DecimalConversion{
    
    public func hk_decimalPoint(_ decimalPoint:Int = 0)->String{
        
        guard let value = self as? NSNumber else {
            return "0"
        }
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = decimalPoint
        return formatter.string(from: value) ?? "0"
        
    }
    
    
    
}

extension Double : DecimalConversion {}
extension Float : DecimalConversion {}
