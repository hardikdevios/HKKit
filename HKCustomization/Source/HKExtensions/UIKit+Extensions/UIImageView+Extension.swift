//
//  UIImage+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit
extension UIImageView {
    
    func makeOval(){
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

