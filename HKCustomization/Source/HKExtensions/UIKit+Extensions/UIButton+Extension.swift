//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension UIButton{
    func setAppBackGroundColor()->Void{
        self.backgroundColor = APP_COLOR_COMPUTED
    }
    func setAppDisableColor()->Void{
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    func toggleOnOff()->Void{
        self.selected = !self.selected;
    }
    func setDisableWithAlpha(isDisable:Bool){
        if isDisable {
            self.enabled = false
            self.alpha = 0.5
        }else{
            self.enabled = true
            self.alpha = 1.0
        }
    }
    
}