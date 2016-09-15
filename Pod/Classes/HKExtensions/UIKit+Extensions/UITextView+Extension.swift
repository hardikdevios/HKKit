//
//  UITextView+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension UITextView{
    
    public func setDefaultText(_ defaultText:String!)->Void{
        if self.text == "" ||  self.text == " " ||  self.text == nil{
            self.text = defaultText
        }
        
    }
}
extension UITextView {
    public func isEmpty()->Bool{
        let whitespaceSet = CharacterSet.whitespaces
        if self.text.trimmingCharacters(in: whitespaceSet) != "" {
            return false
        }
        return true
    }
    
}
