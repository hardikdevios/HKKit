//
//  UINavigationController+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    public func setPlainBackGround(){
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any,barMetrics: UIBarMetrics.Default)
    }
    
    public func getNavigationBarHeightWithOutStausBar()->CGFloat{
        return self.navigationController?.navigationBar.frame.height ?? 0
    }
    public func getNavigationBarHeight()->CGFloat{

        return (self.navigationController?.navigationBar.frame.height ?? 0 ) + (UIApplication.sharedApplication().statusBarFrame.height ?? 0)
        
    }
}
