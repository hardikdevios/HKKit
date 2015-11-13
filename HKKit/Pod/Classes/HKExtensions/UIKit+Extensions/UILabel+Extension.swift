//
//  UILabel+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension UILabel{
        func setAppTextColor()->Void{
            self.textColor = APP_COLOR_COMPUTED
        }
    
        func setDefaultText(defaultText:String!)->Void{
            if self.text == "" ||  self.text == " " ||  self.text == nil{
                self.text = defaultText
            }
            
        }
        func setHtmlText(string:String!){
            
            if string != nil {
                let encodedData = string.dataUsingEncoding(NSUTF8StringEncoding)!
                let attributedOptions : [String: AnyObject] = [
                    NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                    NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
                ]
                let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
                self.text = attributedString.string
                
            }
        
        }

}