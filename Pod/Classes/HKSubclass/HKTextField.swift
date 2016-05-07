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

public class HKTextField: UITextField,UITextFieldDelegate {
    let padding = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 5);
    public var needBottomBorder:Bool = false
    var objDelegate:HKTextFieldDelegate = HKTextFieldDelegate()
    public var textChanged:clouser?{
        
        didSet{
            
            objDelegate.textChangedClouser = textChanged

        }
    }
    public var textEditigStart:clouser2?{
        
        didSet{
            
            objDelegate.textEditingStartClouser = textEditigStart
            
        }
    }
    public var textEditingEnd:clouser2?{
        
        didSet{
            
            objDelegate.textEditingStopClouser = textEditingEnd
            
        }
    }
    override public func awakeFromNib() {
        self.keyboardAppearance = .Default
        objDelegate.delegate = self.delegate
        super.delegate = objDelegate
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if needBottomBorder == true {
            self.addBottomBorderWithColor(UIColor.lightGrayColor(), width: 0.5)
        }
    }
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        if self.text?.isEmpty == true || self.clearButtonMode == .Never{
            return self.newBounds(bounds,extraPadding:0.0)

        }
        return self.newBounds(bounds)
    }
    
    override public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return self.newBounds(bounds,extraPadding:0.0)
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        if self.text?.isEmpty == true || self.clearButtonMode == .Never{
            return self.newBounds(bounds,extraPadding:0.0)
            
        }
        return self.newBounds(bounds)
    }
    
    private func newBounds(bounds: CGRect,extraPadding:CGFloat = 25.0) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += padding.left + (self.leftView?.frame.size.width ?? 0)  + (self.rightView?.frame.size.width ?? 0)
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right + (self.leftView?.frame.size.width ?? 0) + (self.rightView?.frame.size.width ?? 0) + extraPadding

        return newBounds
    }
    
    
    
  

    
   
}


public class HKTextFieldDelegate:NSObject,UITextFieldDelegate {
    
    var textChangedClouser:clouser?
    var textEditingStartClouser:clouser2?
    var textEditingStopClouser:clouser2?

    var delegate:UITextFieldDelegate?
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            return textChangedClouser?(textField as! HKTextField,textField.text!.stringByReplacingCharactersInRange(range.toRange(textField.text!),withString: string),string) ??
            delegate?.textField?(textField, shouldChangeCharactersInRange: range, replacementString: string) ?? true
       
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        guard let clouser = textEditingStopClouser else{
            delegate?.textFieldShouldBeginEditing?(textField)
            return
        }
        clouser(textField as! HKTextField)
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        if !textField.isFirstResponder() {
            textField.text = ""
            return false
        }
        return delegate?.textFieldShouldClear?(textField) ?? true
    }
    func enableTextField(textField:UITextField){
        textField.userInteractionEnabled = true
    }
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
      
        return delegate?.textFieldShouldReturn?(textField) ?? true
    }
    public func textFieldDidBeginEditing(textField: UITextField) {
        delegate?.textFieldDidBeginEditing?(textField)

    }
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
       return delegate?.textFieldShouldEndEditing?(textField) ?? true

    }
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return textEditingStartClouser?(textField as! HKTextField) ?? delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
}
