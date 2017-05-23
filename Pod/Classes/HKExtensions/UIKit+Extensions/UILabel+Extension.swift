//
//  UILabel+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension UILabel{
        public func setAppTextColor()->Void{
            self.textColor = MAIN_COLOR
        }
    
        public func setDefaultText(_ defaultText:String!)->Void{
            if self.text == "" ||  self.text == " " ||  self.text == nil{
                self.text = defaultText
            }
            
        }
        public func setHtmlText(_ string:String!){
            
            let attrStr = try! NSAttributedString(
                data: string.data(using: .unicode, allowLossyConversion: true)!,
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            
            self.attributedText = attrStr

    
        }
    
        private func setHtmlTextWithFont(_ string:String,font:String? = "HelveticaNeue",fontSize:CGFloat? = 17){
            
            let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(17)\">%@</span>",string)
            
            
            //process collection values
            let attrStr = try! NSAttributedString(
                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            
            self.attributedText = attrStr
            
        }
    
    func setAttributeString(_ mainString:String,attributeString:String,attributes:[String:Any]){
        
        let range = mainString.range(of: attributeString, options: NSString.CompareOptions.caseInsensitive)
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
        
        if range != nil {
            
            attrString.addAttributes(attributes, range: NSMakeRange((mainString.characters.distance(from: mainString.startIndex, to: range!.lowerBound)),attributeString.characters.count))
            self.attributedText = attrString
            
        }else{
            self.text = mainString
        }
        
    }
    
    
    func setAttributesString(_ mainString:String,attributeStrings:[String],total_attributes:[[String:Any]]) {
        
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string:mainString)
        
        for (index,string) in attributeStrings.enumerated() {
            
            let range = mainString.range(of: string, options: NSString.CompareOptions.caseInsensitive)
            
            if range != nil {
                
                attrString.addAttributes(total_attributes[index], range: NSMakeRange((mainString.characters.distance(from: mainString.startIndex, to: range!.lowerBound)),string.characters.count))
                
                
            }else{
                continue
            }
            
        }
        self.attributedText = attrString
        
    }


}
