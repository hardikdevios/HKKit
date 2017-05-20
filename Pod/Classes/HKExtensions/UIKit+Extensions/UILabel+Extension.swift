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

}
