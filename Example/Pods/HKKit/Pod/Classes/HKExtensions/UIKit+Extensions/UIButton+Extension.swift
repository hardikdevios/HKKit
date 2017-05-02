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
        self.backgroundColor = UIColor.lightGray
    }
    
    public func toggleOnOff()->Void{
        self.isSelected = !self.isSelected;
    }
    public func setDisableWithAlpha(_ isDisable:Bool){
        if isDisable {
            self.isEnabled = false
            self.alpha = 0.5
        }else{
            self.isEnabled = true
            self.alpha = 1.0
        }
    }
    
}
