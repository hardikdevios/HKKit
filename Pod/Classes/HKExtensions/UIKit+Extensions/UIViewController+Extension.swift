//
//  UIViewController+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension UIViewController {
    
    
    
    public func setAppLogo(){
        
        let imgView:UIImageView = UIImageView(image: UIImage(named: "logo"))
        imgView.contentMode = .Center
        let barbutton:UIBarButtonItem = UIBarButtonItem(customView: imgView)
        self.navigationItem.leftBarButtonItem = barbutton
    }
    
    public func setMainTitle(navigationTitle:String!)->Void{
        self.navigationItem.title = navigationTitle
    }
    public func remvoeAllObserver(isForcefully:Bool = false){
        
        if self.isMovingFromParentViewController() || isForcefully{
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    public func setObserver(methodname:Selector,observername:String){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: methodname, name: observername, object: nil)
        
    }
    public func setCustomeTitleView(navigationTitle:String!,let font:UIFont = UIFont.systemFontOfSize(UIFont.smallSystemFontSize()))->Void{
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.Center
        label.text = navigationTitle
        label.font = font
        label.sizeToFit()
        //label.textColor = UIColor.whiteColor()
        
        
        self.navigationItem.titleView = label
    }
  
    public func setCancelButton()->Void{
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action:"cancelClick:")
    }
    public func setSaveButton(action:Selector)->Void{
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: action)
    }
    public func cancelClick(sender:AnyObject?){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    public func setBlurryBackground(){
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = self.view.bounds
        visualEffectView.tag = 999
        
        self.view.insertSubview(visualEffectView, atIndex: 0)
        visualEffectView.hidden=false;
    }
    public func isBlurVisible(ishidden:Bool){
        //        var visualEffect:UIVisualEffectView? = (self.revealViewController().frontViewController as! UINavigationController).topViewController.view.viewWithTag(999) as? UIVisualEffectView
        //        if visualEffect == nil{
        //            return
        //        }
        //        visualEffect?.hidden = ishidden
        
    }
    
    public func setEmptyView(text:String!){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 9999
        view.addSubview(blurEffectView)
        
        let vibrantLabel = UILabel()
        let ccenter:CGPoint? = self.parentViewController?.view.center
        vibrantLabel.textColor = UIColor.lightGrayColor()
        vibrantLabel.backgroundColor = UIColor.clearColor()
        vibrantLabel.font = UIFont.boldSystemFontOfSize(8 * UIScreen.mainScreen().scale)
        vibrantLabel.textAlignment = .Center
        vibrantLabel.frame = CGRectMake(0, 0, self.view.frame.size.width-50, self.view.frame.size.height)
        vibrantLabel.numberOfLines = 0
        vibrantLabel.center = ccenter!
        vibrantLabel.text = text
        blurEffectView.contentView.addSubview(vibrantLabel)
    }
    
    public func isViewEmpty(isempty:Bool){
        let visualEffect:UIVisualEffectView? = view.viewWithTag(9999) as? UIVisualEffectView
        if visualEffect == nil{
            return
        }
        visualEffect?.hidden = isempty
        
    }
    
    public func setToolbarWithActivity(){
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activity.hidden = false
        let barbuttonActivity = UIBarButtonItem(customView: activity)
        activity.startAnimating()
        activity.color = APP_COLOR_COMPUTED
        self.toolbarItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil),barbuttonActivity,UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)]
        
    }
    public func removeWithAnimation(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 0
            }, completion: { (sucess) -> Void in
                self.removeFromParentViewController()
                self.view.removeFromSuperview()
                
        })
    }
    public func setBlankBackButton(){
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        
    }
    
    public func setCustomBackbutton(methodName:Selector){
        let myBackButton:UIButton = UIButton(type: UIButtonType.Custom)
        myBackButton.addTarget(self, action: methodName, forControlEvents: UIControlEvents.TouchUpInside)
        myBackButton.setTitle(" ", forState: UIControlState.Normal)
        myBackButton.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        
        myBackButton.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 0)
        myBackButton.titleEdgeInsets = UIEdgeInsetsMake(0,-30, 0, 0)
        myBackButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        myBackButton.sizeToFit()
        myBackButton.tintColor = UIColor.grayColor()
        
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        
        
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    public func setUpActivityIndicator(){
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activity.hidesWhenStopped = true
        let barbuttonActivity = UIBarButtonItem(customView: activity)
        if self.navigationItem.rightBarButtonItem != nil {
            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItem!,barbuttonActivity]

        }else{
            self.navigationItem.rightBarButtonItems = [barbuttonActivity]

        }
    }
    public func startIndicator(){
        
        
        if let activity = self.navigationItem.rightBarButtonItems?.last?.customView as? UIActivityIndicatorView {
            activity.startAnimating()
        }
        if let activity = self.navigationItem.leftBarButtonItem?.customView as? UIActivityIndicatorView {
            activity.startAnimating()
        }
    }
    
    public func stopIndicator(){
        if let activity = self.navigationItem.rightBarButtonItems?.last?.customView as? UIActivityIndicatorView {
            activity.stopAnimating()
        }
        if let activity = self.navigationItem.leftBarButtonItem?.customView as? UIActivityIndicatorView {
            activity.stopAnimating()
        }
    }
    
}
//extension UIViewController {
//    class public func currentViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return currentViewController(nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return currentViewController(selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return currentViewController(presented)
//        }
//        return base
//    }
//}
