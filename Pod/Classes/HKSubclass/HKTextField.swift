//
//  HKTextField.swift
//  Doctodoor
//
//  Created by Hardik on 19/09/15.
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit

public typealias cl_textfield_text = ((HKTextField,String,String)->Bool?)
public typealias cl_textfield = ((HKTextField)->Bool?)

open class HKTextField: UITextField,UITextFieldDelegate {
    public var padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10);
    var needBottomBorder:Bool = false
    open var bottomBorder:CALayer?
    open var validationErrorColor:UIColor = UIColor.red.withAlphaComponent(0.5)
    var objDelegate:HKTextFieldDelegate = HKTextFieldDelegate()
    let animationDuration = 0.3
    var title = UILabel()
    open var onBackWardclick:((HKTextField)->())?
    var bottomBorderColor:UIColor = .white
    var bottomBorderWidth:CGFloat = 1
    
    weak open override var delegate: UITextFieldDelegate? {
        
        didSet{
            objDelegate.delegate = self.delegate
          //  super.delegate = objDelegate

        }
    }
    open var noPadding = false {
        
        didSet{
            
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);

        }
    }
    open var textChanged:cl_textfield_text?{
        
        didSet{
            
            objDelegate.textChangedClouser = textChanged

        }
    }
    open var textEditigStart:cl_textfield?{
        
        didSet{
            
            objDelegate.textEditingStartClouser = textEditigStart
            
        }
    }
    open var textEditingEnd:cl_textfield?{
        
        didSet{
            
            objDelegate.textEditingStopClouser = textEditingEnd
            
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
    
    
    @IBInspectable open var isFloting:Bool = false {
        
        didSet{
            self.title.isHidden = !self.isFloting
            
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
    
    override open func awakeFromNib() {
        self.keyboardAppearance = .default
        objDelegate.delegate = self.delegate
        super.delegate = objDelegate
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
        if isFloting {
            
            setTitlePositionForTextAlignment()
            let isResp = isFirstResponder
            if isResp && !text!.isEmpty {
                title.textColor = HKConstant.sharedInstance.main_color
            } else {
                title.textColor = titleTextColour
            }
            if text!.isEmpty {
                hideTitle(isResp)
            } else {
                showTitle(isResp)
            }
            
        }
   
        if needBottomBorder == true {
            let _ = self.hk_addBottomBorderWithColor(bottomBorderColor,
                                                     width: bottomBorderWidth)
        }
        
    }
    
    public func setBottomBorder(color:UIColor = UIColor.white, width:CGFloat = 1.0) {
        needBottomBorder = true
        self.bottomBorderColor = color
        self.bottomBorderWidth = width
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
        let leftWidth = self.leftView?.frame.width ?? 0
        let rightWidth = self.rightView?.frame.width ?? 0
        var top = padding.top
        var bottom = padding.bottom
        
        if !self.text!.isEmpty && self.isFloting {
            top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            bottom = 5
        }
        newBounds.origin.x += padding.left + rightWidth
        newBounds.origin.y += top
        newBounds.size.height -= top + bottom
        newBounds.size.width -= padding.left + padding.right + leftWidth + rightWidth + extraPadding

        return newBounds
    }
    
    
    fileprivate func setup() {
        borderStyle = UITextField.BorderStyle.none
        titleActiveTextColour = tintColor
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let str = placeholder {
            if !str.isEmpty {
                title.text = str
                title.sizeToFit()
            }
        }
        if noPadding {
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
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

    
    override open func deleteBackward() {
        super.deleteBackward()
        self.onBackWardclick?(self)
    }

   
}


open class HKTextFieldDelegate:NSObject,UITextFieldDelegate {
    
    var textChangedClouser:cl_textfield_text?
    var textEditingStartClouser:cl_textfield?
    var textEditingStopClouser:cl_textfield?

    weak var delegate:UITextFieldDelegate?
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let r = textField.text!.hk_range(from: range)
            return textChangedClouser?(textField as! HKTextField,textField.text!.replacingCharacters(in: r!,with: string),string) ??
            delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
       
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        guard let clouser = textEditingStopClouser else{
            let _ = delegate?.textFieldDidEndEditing?(textField)
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
