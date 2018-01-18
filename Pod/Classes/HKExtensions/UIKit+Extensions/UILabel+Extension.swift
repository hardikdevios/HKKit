//
//  UILabel+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension UILabel{
    public func hk_setAppTextColor()->Void{
        self.textColor = HKConstant.sharedInstance.main_color
    }

    public func hk_setDefaultText(_ defaultText:String!)->Void{
        if self.text == "" ||  self.text == " " ||  self.text == nil{
            self.text = defaultText
        }
        
    }
    private func getHtmlStrign(_ string:String)->NSAttributedString{
        let attrStr = try! NSAttributedString(
            data: string.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        return attrStr
        
    }
    public func hk_setHtmlText(_ string:String){
    
        self.attributedText = self.getHtmlStrign(string)
    }
    
    private func hk_setHtmlTextWithFont(_ string:String,font:String? = "HelveticaNeue",fontSize:CGFloat? = 17){
        
        let modifiedStringFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(17)\">%@</span>",string)
        
        self.attributedText = self.getHtmlStrign(modifiedStringFont)
        
    }
    
    public func hk_setAttributeString(_ mainString:String,attributeString:String,attributes:[NSAttributedStringKey:Any]){
        
        let result = hk_getAttributeString(mainString, attributeString: attributeString, attributes: attributes)
        self.attributedText = result
        
    }
    
    
    public func hk_setAttributesString(_ mainString:String,attributeStrings:[String],total_attributes:[[NSAttributedStringKey:Any]]) {
        
        
        let result = hk_getMultipleAttributesString(mainString, attributeStrings: attributeStrings, total_attributes: total_attributes)
        self.attributedText = result
        
        
    }


}
