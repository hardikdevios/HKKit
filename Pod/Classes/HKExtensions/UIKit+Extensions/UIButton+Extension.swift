//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension UIButton{
    public func setAppBackGroundColor()->Void{
        self.backgroundColor = MAIN_COLOR
    }
    public func setAppDisableColor()->Void{
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    public func toggleOnOff()->Void{
        self.selected = !self.selected;
    }
    public func setDisableWithAlpha(isDisable:Bool){
        if isDisable {
            self.enabled = false
            self.alpha = 0.5
        }else{
            self.enabled = true
            self.alpha = 1.0
        }
    }
    
}