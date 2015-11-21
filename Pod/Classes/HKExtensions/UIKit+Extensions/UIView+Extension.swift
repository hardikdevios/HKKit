//
//  UIView+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit

extension UIView{
    public func setAppBackGround()->Void{
        self.backgroundColor = MAIN_COLOR
    }
    public func setAppBackGroundWithAlpha(alpha:CGFloat)->Void{
        self.backgroundColor = MAIN_COLOR.colorWithAlphaComponent(alpha)
    }
    public func setAppRadius()->Void{
        self.layer.cornerRadius = 3.0
    }
    public func setAppRadius(radius:CGFloat)->Void{
        self.layer.cornerRadius = radius
    }
    public func setEmptyView(text:String!){
        let visualEffect:UIVisualEffectView? = self.viewWithTag(9999) as? UIVisualEffectView
        if visualEffect != nil{
            self.isViewEmpty(false)
            return
        }
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.tag = 9999
        self.addSubview(blurEffectView)
        
        
        // Label for vibrant text
        let vibrantLabel = UILabel()
        let ccenter:CGPoint? = self.center
        vibrantLabel.textColor = UIColor.lightGrayColor()
        vibrantLabel.backgroundColor = UIColor.clearColor()
        vibrantLabel.font = UIFont.boldSystemFontOfSize(8 * UIScreen.mainScreen().scale)
        vibrantLabel.textAlignment = .Center
        vibrantLabel.frame = CGRectMake(0, 0, self.frame.size.width-50, self.frame.size.height)
        vibrantLabel.numberOfLines = 0
        vibrantLabel.center = ccenter!
        vibrantLabel.text = text
        
        blurEffectView.contentView.addSubview(vibrantLabel)
    }
    
    public func isViewEmpty(isempty:Bool){
        let visualEffect:UIVisualEffectView? = self.viewWithTag(9999) as? UIVisualEffectView
        if visualEffect == nil{
            return
        }
        visualEffect?.hidden = isempty
    }
    
    public func setAppShadow(color:UIColor,size:CGSize){
        
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowOffset = size;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 10.0;
        self.clipsToBounds = false
    }
    
    public func setCardlayout(){
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(-0.5, 1)
        self.layer.shadowOpacity = 0.2
        //        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).CGPath
    }
    
    public func addDashedBorder() {
        
        // self.layoutIfNeeded()
        let color = UIColor.lightGrayColor().CGColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: 0)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 0.50
        shapeLayer.lineJoin = kCALineJoinRound
        
        shapeLayer.lineDashPattern = [3,2]
        shapeLayer.path = UIBezierPath(roundedRect: CGRectMake(0, shapeRect.height, shapeRect.width, 0), cornerRadius: 0).CGPath
        
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    public func findSuperViewWithClass<T>(superViewClass : T.Type) -> UIView? {
        
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
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, 0, self.frame.size.width, width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat)->CALayer {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width)
        self.layer.addSublayer(border)
        return border
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

