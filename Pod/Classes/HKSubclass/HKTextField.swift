//
//  HKTextField.swift
//  Doctodoor
//
//  Created by Hardik on 19/09/15.
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit
public typealias clouser = ((HKTextField,String,String)->Bool?)
public typealias clouser2 = ((HKTextField)->Bool?)

open class HKTextField: UITextField,UITextFieldDelegate {
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10);
    open var needBottomBorder:Bool = false
    var objDelegate:HKTextFieldDelegate = HKTextFieldDelegate()
    open var textChanged:clouser?{
        
        didSet{
            
            objDelegate.textChangedClouser = textChanged

        }
    }
    open var textEditigStart:clouser2?{
        
        didSet{
            
            objDelegate.textEditingStartClouser = textEditigStart
            
        }
    }
    open var textEditingEnd:clouser2?{
        
        didSet{
            
            objDelegate.textEditingStopClouser = textEditingEnd
            
        }
    }
    override open func awakeFromNib() {
        self.keyboardAppearance = .default
        objDelegate.delegate = self.delegate
        super.delegate = objDelegate
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if needBottomBorder == true {
            let _ = self.addBottomBorderWithColor(UIColor.lightGray, width: 0.5)
        }
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if self.text?.isEmpty == true || self.clearButtonMode == .never{
            return self.newBounds(bounds,extraPadding:0.0)

        }
        return self.newBounds(bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds,extraPadding:0.0)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if self.text?.isEmpty == true || self.clearButtonMode == .never{
            return self.newBounds(bounds,extraPadding:0.0)
            
        }
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect,extraPadding:CGFloat = 25.0) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += padding.left + (self.leftView?.frame.size.width ?? 0)  + (self.rightView?.frame.size.width ?? 0)
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right + (self.leftView?.frame.size.width ?? 0) + (self.rightView?.frame.size.width ?? 0) + extraPadding

        return newBounds
    }
    
    
    
  

    
   
}


open class HKTextFieldDelegate:NSObject,UITextFieldDelegate {
    
    var textChangedClouser:clouser?
    var textEditingStartClouser:clouser2?
    var textEditingStopClouser:clouser2?

    var delegate:UITextFieldDelegate?
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let r = textField.text!.range(from: range)
            return textChangedClouser?(textField as! HKTextField,textField.text!.replacingCharacters(in: r!,with: string),string) ??
            delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
       
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        guard let clouser = textEditingStopClouser else{
            let _ = delegate?.textFieldShouldBeginEditing?(textField)
            return
        }
        let _ = clouser(textField as! HKTextField)
    }
    
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if !textField.isFirstResponder {
            textField.text = ""
            return false
        }
        return delegate?.textFieldShouldClear?(textField) ?? true
    }
    func enableTextField(_ textField:UITextField){
        textField.isUserInteractionEnabled = true
    }
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        return delegate?.textFieldShouldReturn?(textField) ?? true
    }
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing?(textField)

    }
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       return delegate?.textFieldShouldEndEditing?(textField) ?? true

    }
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return textEditingStartClouser?(textField as! HKTextField) ?? delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
}
