//
//  UITextView+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit

extension UITextView{
    
    func setDefaultText(defaultText:String!)->Void{
        if self.text == "" ||  self.text == " " ||  self.text == nil{
            self.text = defaultText
        }
        
    }
}
extension UITextView {
    func isEmpty()->Bool{
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        if self.text.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
            return false
        }
        return true
    }
    
}
