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
    open var validationErrorColor:UIColor = UIColor.red.withAlphaComponent(0.5)
    var objDelegate:HKFloatingTextFieldDelegate = HKFloatingTextFieldDelegate()
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
    
    // MARK:- Properties
    override open var accessibilityLabel:String! {
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
    override open func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
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
            self.bottomBorder!.frame = CGRect(x: self.bottomBorder!.frame.origin.x, y: self.frame.size.height - self.bottomBorder!.frame.height, width: self.frame.width, height: self.bottomBorder!.frame.height)

        }
        
    }
    
    override open func textRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 0.0, 5.0, 0.0))
        }
        return r.integral
    }
    
    override open func editingRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top, 0.0, 5.0, 0.0))
        }
        return r.integral
    }
    
    override open func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
        }
        return r.integral
    }
    
    // MARK:- Public Methods
    
    // MARK:- Private Methods
    fileprivate func setup() {
        borderStyle = UITextBorderStyle.none
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
    
    fileprivate func maxTopInset()->CGFloat {
        return max(0, floor(bounds.size.height - font!.lineHeight - 4.0))
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
    }
    
    fileprivate func showTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [.beginFromCurrentState, .curveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
            }, completion:nil)
    }
    
    fileprivate func hideTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [.beginFromCurrentState, .curveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
            }, completion:nil)
    }
   
}


open class HKFloatingTextFieldDelegate:NSObject,UITextFieldDelegate {
    
    var textChangedClouser:clouserFloating?
    var delegate:UITextFieldDelegate?
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let r = textField.text!.range(from: range)

        return textChangedClouser?(textField as! HKFloatingTextField,textField.text!.replacingCharacters(in:r!,with: string),string) ??
            delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
        
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
       let _ = delegate?.textFieldShouldBeginEditing?(textField)
    }
    
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldClear?(textField) ?? true
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
        return delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
}

