//
//  HKFunctions.swift
//  HKKit
//
//  Created by Hardik Shah on 24/05/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation


internal func hk_getAttributeString(_ mainString:String,attributeString:String,attributes:[NSAttributedStringKey:Any])->NSAttributedString{
    
    let value = mainString.range(of: attributeString, options: NSString.CompareOptions.caseInsensitive)
    let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
    
    guard let range = value else {
        return attrString
    }
    attrString.addAttributes(attributes, range: NSMakeRange((mainString.distance(from: mainString.startIndex, to: range.lowerBound)),attributeString.count))
    return attrString
        

}
internal func hk_getMultipleAttributesString(_ mainString:String,attributeStrings:[String],total_attributes:[[NSAttributedStringKey:Any]]) -> NSAttributedString{
    
    let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
    
    for (index,string) in attributeStrings.enumerated() {
        
        let range = mainString.range(of: string, options: NSString.CompareOptions.caseInsensitive)
        
        if range != nil {
            
            attrString.addAttributes(total_attributes[index], range: NSMakeRange((mainString.distance(from: mainString.startIndex, to: range!.lowerBound)),string.count))
            
            
        }else{
            continue
        }
        
    }
    
    return attrString
}

