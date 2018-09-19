//
//  UIView+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
import AlamofireImage

extension UIView{
    public func hk_setAppBackGround()->Void{
        self.backgroundColor = HKConstant.sharedInstance.main_color
    }
    public func hk_setAppBackGroundWithAlpha(_ alpha:CGFloat)->Void{
        self.backgroundColor = HKConstant.sharedInstance.main_color.withAlphaComponent(alpha)
    }
    
    public func hk_setAppDisableColor()->Void{
        self.backgroundColor = UIColor.lightGray
    }
    public func hk_setAppRadius()->Void{
        self.layer.cornerRadius = 3.0
    }
    public func hk_setAppRadius(_ radius:CGFloat)->Void{
        self.layer.cornerRadius = radius
    }
    public func hk_setEmptyView(_ text:String!){
        let visualEffect:UIVisualEffectView? = self.viewWithTag(9999) as? UIVisualEffectView
        if visualEffect != nil{
            self.hk_isViewEmpty(false)
            return
        }
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.tag = 9999
        self.addSubview(blurEffectView)
        
        
        // Label for vibrant text
        let vibrantLabel = UILabel()
        let ccenter:CGPoint? = self.center
        vibrantLabel.textColor = UIColor.lightGray
        vibrantLabel.backgroundColor = UIColor.clear
        vibrantLabel.font = UIFont.boldSystemFont(ofSize: 8 * UIScreen.main.scale)
        vibrantLabel.textAlignment = .center
        vibrantLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width-50, height: self.frame.size.height)
        vibrantLabel.numberOfLines = 0
        vibrantLabel.center = ccenter!
        vibrantLabel.text = text
        
        blurEffectView.contentView.addSubview(vibrantLabel)
    }
    
    public func hk_isViewEmpty(_ isempty:Bool){
        let visualEffect:UIVisualEffectView? = self.viewWithTag(9999) as? UIVisualEffectView
        if visualEffect == nil{
            return
        }
        visualEffect?.isHidden = isempty
    }
    
    public func hk_setAppShadow(_ color:UIColor,size:CGSize){
        
        self.layer.shadowColor = color.cgColor;
        self.layer.shadowOffset = size;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 10.0;
        self.clipsToBounds = false
    }
    
    public func hk_setCardlayout(){
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: -0.5, height: 1)
        self.layer.shadowOpacity = 0.2
        //        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    public func hk_addDashedBorder() {
        
        // self.layoutIfNeeded()
        let color = UIColor.lightGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 0.50
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        shapeLayer.lineDashPattern = [3,2]
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: shapeRect.height, width: shapeRect.width, height: 0), cornerRadius: 0).cgPath
        
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    public func hk_findSuperViewWithClass<T>(_ superViewClass : T.Type) -> UIView? {
        
        var xsuperView : UIView!  = self.superview!
        var foundSuperView : UIView!
        
        while (xsuperView != nil && foundSuperView == nil) {
            
            if xsuperView.self is T {
                foundSuperView = xsuperView
            } else {
                xsuperView = xsuperView.superview
            }
        }
        return foundSuperView
    }
    
    
}
extension UIView {
    
    
    
    public func hk_makeOval(){
        
        if let imgView = self as? UIImageView {
            imgView.image = imgView.image?.af_imageRoundedIntoCircle()
            return
        }
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    public func hk_setAppTintColor(){
        
        self.tintColor = HKConstant.sharedInstance.main_color
    }
    
    
}
extension UIView {
    
    fileprivate func hk_actionHandleBlock(_ action:(() -> Void)? = nil) {
        struct ActionClick {
            static var action :(() -> Void)?
        }
        
        
        if action != nil {
            ActionClick.action = action
        } else {
            ActionClick.action?()
        }
    }
    @objc fileprivate func hk_triggerActionHandleBlock() {
        self.hk_actionHandleBlock()
        
    }
    
    public func hk_onViewClick(_ block:@escaping (()->())){
        
        self.isUserInteractionEnabled = true
        self.hk_actionHandleBlock(block)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.hk_triggerActionHandleBlock))
        self.addGestureRecognizer(gesture)
        
    }
    
}

extension UIView {
    public func hk_addTopBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    public func hk_addRightBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    public func hk_addBottomBorderWithColor(_ color: UIColor, width: CGFloat)->CALayer {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        return border
    }
    
    public func hk_addLeftBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

