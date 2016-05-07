//
//  HKFloatingTextField.swift
//  Doctodoor
//
//  Created by Hardik on 19/09/15.
//  Copyright (c) 2015. All rights reserved.
//

import UIKit
public typealias clouserFloating = ((HKFloatingTextField,String,String)->Bool?)

public class HKFloatingTextField: UITextField {

    public let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    public var bottomBorder:CALayer?
    public var validationErrorColor:UIColor = UIColor.redColor().colorWithAlphaComponent(0.5)
    var objDelegate:HKFloatingTextFieldDelegate = HKFloatingTextFieldDelegate()
    public var textChanged:clouserFloating?{
        
        didSet{
            
            objDelegate.textChangedClouser = textChanged
            
        }
    }
    override public func awakeFromNib() {
        
        objDelegate.delegate = self.delegate
        super.delegate = objDelegate
    }
    
    

    let animationDuration = 0.3
    var title = UILabel()
    
    // MARK:- Properties
    override public var accessibilityLabel:String! {
        get {
            if text!.isEmpty {
                return title.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }
    
    override public var placeholder:String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    override public var attributedPlaceholder:NSAttributedString? {
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
 
  
    
    @IBInspectable var titleTextColour:UIColor = UIColor.grayColor() {
        didSet {
            if !isFirstResponder() {
                title.textColor = titleTextColour
            }
        }
    }
    
    @IBInspectable var titleActiveTextColour:UIColor! {
        didSet {
            if isFirstResponder() {
                title.textColor = titleActiveTextColour
            }
        }
    }
    
    
     var titleFont:UIFont{
        get{
            
            title.font = UIFont.systemFontOfSize(self.font!.pointSize - CGFloat(4))

            return title.font
        }

       
    }
    
    // MARK:- Init
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    // MARK:- Overrides
    override public func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder()
        if isResp && !text!.isEmpty {
            title.textColor = MAIN_COLOR
        } else {
            title.textColor = titleTextColour
        }
        // Should we show or hide the title label?
        if text!.isEmpty {
            // Hide
            hideTitle(isResp)
        } else {
            // Show
            showTitle(isResp)
        }
        
        if bottomBorder != nil {
            self.bottomBorder!.frame = CGRectMake(self.bottomBorder!.frame.origin.x, self.frame.size.height - self.bottomBorder!.frame.height, self.frame.width, self.bottomBorder!.frame.height)

        }
        
    }
    
    override public func textRectForBounds(bounds:CGRect) -> CGRect {
        var r = super.textRectForBounds(bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 0.0, 5.0, 0.0))
        }
        return CGRectIntegral(r)
    }
    
    override public func editingRectForBounds(bounds:CGRect) -> CGRect {
        var r = super.editingRectForBounds(bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 0.0, 5.0, 0.0))
        }
        return CGRectIntegral(r)
    }
    
    override public func clearButtonRectForBounds(bounds:CGRect) -> CGRect {
        var r = super.clearButtonRectForBounds(bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
        }
        return CGRectIntegral(r)
    }
    
    // MARK:- Public Methods
    
    // MARK:- Private Methods
    private func setup() {
        borderStyle = UITextBorderStyle.None
        titleActiveTextColour = tintColor
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let str = placeholder {
            if !str.isEmpty {
                title.text = str
                title.sizeToFit()
            }
        }
        
        self.addSubview(title)
    }
    
    private func maxTopInset()->CGFloat {
        return max(0, floor(bounds.size.height - font!.lineHeight - 4.0))
    }
    
    private func setTitlePositionForTextAlignment() {
        let r = textRectForBounds(bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.Center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.Right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
    }
    
    private func showTitle(animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animateWithDuration(dur, delay:0, options: [.BeginFromCurrentState, .CurveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
            }, completion:nil)
    }
    
    private func hideTitle(animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animateWithDuration(dur, delay:0, options: [.BeginFromCurrentState, .CurveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
            }, completion:nil)
    }
   
}


public class HKFloatingTextFieldDelegate:NSObject,UITextFieldDelegate {
    
    var textChangedClouser:clouserFloating?
    var delegate:UITextFieldDelegate?
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return textChangedClouser?(textField as! HKFloatingTextField,textField.text!.stringByReplacingCharactersInRange(range.toRange(textField.text!),withString: string),string) ??
            delegate?.textField?(textField, shouldChangeCharactersInRange: range, replacementString: string) ?? true
        
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        delegate?.textFieldShouldBeginEditing?(textField)
    }
    
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        return delegate?.textFieldShouldClear?(textField) ?? true
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
        return delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
}

