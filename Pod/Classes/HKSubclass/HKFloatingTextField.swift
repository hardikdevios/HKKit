//
//  HKFloatingTextField.swift
//  Doctodoor
//
//  Created by Hardik on 19/09/15.
//  Copyright (c) 2015. All rights reserved.
//

import UIKit
public typealias clouserFloating = ((HKFloatingTextField,String,String)->Bool?)

open class HKFloatingTextField: UITextField {

    open let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    open var bottomBorder:CALayer?
    var objDelegate:HKTextFieldDelegate = HKTextFieldDelegate()
    open var textChanged:clouserFloating?{
        
        didSet{
            
            objDelegate.textChangedClouser = textChanged
            
        }
    }
    override open func awakeFromNib() {
        
        objDelegate.delegate = self.delegate
        super.delegate = objDelegate
    }
    
    

    let animationDuration = 0.3
    var title = UILabel()
    
    
    
    override open var placeholder:String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    override open var attributedPlaceholder:NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }
    
   
    
    @IBInspectable var hintYPadding:CGFloat = 0.0
    
    @IBInspectable var titleYPadding:CGFloat = 0.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }
 
  
    
    @IBInspectable var titleTextColour:UIColor = UIColor.gray {
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }
    
    @IBInspectable var titleActiveTextColour:UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }
    
    
     var titleFont:UIFont{
        get{
            
            title.font = UIFont.systemFont(ofSize: self.font!.pointSize - CGFloat(4))

            return title.font
        }

       
    }

   
    
  
    
    
}


//open class HKFloatingTextFieldDelegate:NSObject,UITextFieldDelegate {
//    
//    var textChangedClouser:clouserFloating?
//    var delegate:UITextFieldDelegate?
//    
//    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        let r = textField.text!.hk_range(from: range)
//
//        return textChangedClouser?(textField as! HKFloatingTextField,textField.text!.replacingCharacters(in:r!,with: string),string) ??
//            delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
//        
//    }
//    
//    open func textFieldDidEndEditing(_ textField: UITextField) {
//       let _ = delegate?.textFieldShouldBeginEditing?(textField)
//    }
//    
//    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        return delegate?.textFieldShouldClear?(textField) ?? true
//    }
//    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return delegate?.textFieldShouldReturn?(textField) ?? true
//    }
//    open func textFieldDidBeginEditing(_ textField: UITextField) {
//        delegate?.textFieldDidBeginEditing?(textField)
//        
//    }
//    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        return delegate?.textFieldShouldEndEditing?(textField) ?? true
//        
//    }
//    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return delegate?.textFieldShouldBeginEditing?(textField) ?? true
//    }
//}

