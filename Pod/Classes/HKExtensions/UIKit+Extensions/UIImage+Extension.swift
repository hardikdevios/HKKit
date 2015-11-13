//
//  UIImage+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit
extension UIImage {
    
    public func base64() -> String {
        let imageData = UIImageJPEGRepresentation(self, 1.0)
        
        return imageData!.base64EncodedStringWithOptions([])
    }
}
extension UIImage {
    
    func resize(width:CGFloat,height:CGFloat)->UIImage?{
                
        var newSize:CGSize = CGSizeMake(width, height)
        let widthRatio:CGFloat = newSize.width/self.size.width
        let heightRatio:CGFloat = newSize.height/self.size.height;
        
        if(widthRatio > heightRatio){
            newSize = CGSizeMake(self.size.width*widthRatio,self.size.height*widthRatio)
            
        }else{
            newSize=CGSizeMake(self.size.width*heightRatio,self.size.height*heightRatio)
        }
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
