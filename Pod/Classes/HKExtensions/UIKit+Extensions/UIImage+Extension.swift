//
//  UIImage+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension UIImage {
    
    public func hk_base64() -> String {
        let imageData = UIImageJPEGRepresentation(self, 1.0)
        
        return imageData!.base64EncodedString(options: [])
    }
}
extension UIImage {
    
    public func hk_resize(_ width:CGFloat,height:CGFloat)->UIImage?{
                
        var newSize:CGSize = CGSize(width: width, height: height)
        let widthRatio:CGFloat = newSize.width/self.size.width
        let heightRatio:CGFloat = newSize.height/self.size.height;
        
        if(widthRatio > heightRatio){
            newSize = CGSize(width: self.size.width*widthRatio,height: self.size.height*widthRatio)
            
        }else{
            newSize=CGSize(width: self.size.width*heightRatio,height: self.size.height*heightRatio)
        }
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
