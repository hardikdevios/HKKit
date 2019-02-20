//
//  UIColor+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience public init(hexString:String) {
        
        let r, g, b : CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count <= 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0xff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0xff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    public class func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    
    convenience public init(clearRed:CGFloat,clearGreen:CGFloat,clearBlue:CGFloat){
        
        self.init(red: clearRed/255.0, green: clearGreen/255.0, blue: clearBlue/255, alpha: 1)
    }
}
