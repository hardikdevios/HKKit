//
//  UITextField+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension UITextField{
    
    public func setDefaultBottomBorder()->Void{
        
        let border = CALayer()
        
        let width = CGFloat(1)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.bounds.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    public func setSelectedBottomBorder()->Void{
        
        let border = CALayer()
        
        let width = CGFloat(1)
        border.borderColor = COLOR_COMPUTED.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
   public func setDefaultText(defaultText:String!)->Void{
        if self.text == "" ||  self.text == " " ||  self.text == nil{
            self.text = defaultText
        }
        
    }
    
   public func setLeftImgView(imgName:String!)->Void{
        
        self.layoutIfNeeded()
        let leftViewForImg = UIView(frame: CGRectMake(0, 0, 50, self.frame.size.height))
        let imgView = UIImageView(image: UIImage(named: imgName)!)
        imgView.frame = CGRectMake(0, 0, leftViewForImg.frame.size.width - 20, leftViewForImg.frame.size.height - 20)
        imgView.center = leftViewForImg.center
        imgView.contentMode = .ScaleAspectFit
        leftViewForImg.addSubview(imgView)
        self.leftView = leftViewForImg
        self.leftViewMode = .Always
        
    }
    
    public func setPlaceHolderColor(color:UIColor){
        
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "",
            attributes:[NSForegroundColorAttributeName:color])
        
    }
    
}


extension UITextField{
    
    
    public func isEmpty()->Int{
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        if self.text!.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
            return 0
        }
        self.shake()
        return 1
    }
    
    public func isEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive)
        return regex?.firstMatchInString(self.text!, options: [], range: NSMakeRange(0, self.text!.characters.count)) != nil
    }
    
    public func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 10, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 10, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
    }
    public func setLockViewAndDisabled(isLeft:Bool = false){
        
        let view:UIView = UIView(frame: CGRectMake(0, 0, 30 , 30))
        let label = UILabel(frame: CGRectMake(0, 0, 25 ,25))
        
        label.textAlignment = NSTextAlignment.Center
        label.text = "🔒"
        view.addSubview(label)
        
        self.enabled = false
        
        if isLeft {
            self.leftView = view
            self.leftViewMode = .Always
        }else{
            self.rightView = view
            self.rightViewMode = .Always
        }
        
    }
    

    
}
