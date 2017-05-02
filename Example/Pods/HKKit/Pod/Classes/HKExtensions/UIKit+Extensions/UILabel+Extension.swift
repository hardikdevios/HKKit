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
            
            if string != nil {
                let encodedData = string.data(using: String.Encoding.utf8)!
                let attributedOptions : [String: AnyObject] = [
                    NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType as AnyObject,
                    NSCharacterEncodingDocumentAttribute: String.Encoding.utf8 as AnyObject
                ]
                let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
                self.text = attributedString.string
                
            }
        
        }

}
