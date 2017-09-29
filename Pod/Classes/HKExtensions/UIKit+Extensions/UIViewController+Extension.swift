//
//  UIViewController+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension UIViewController {
    
    
    
    
    public func hk_setAppLogo(){
        
        let imgView:UIImageView = UIImageView(image: UIImage(named: MAIN_LOGO))
        imgView.contentMode = .scaleAspectFit
        // let barbutton:UIBarButtonItem = UIBarButtonItem(customView: imgView)
        self.navigationItem.titleView = imgView
    }
    
    public func hk_setAppLogoLeft(){
        
        let imgView:UIImageView = UIImageView(image: UIImage(named: MAIN_LOGO))
        imgView.contentMode = .center
        let barbutton:UIBarButtonItem = UIBarButtonItem(customView: imgView)
        self.navigationItem.leftBarButtonItem = barbutton
    }
    
    public func hk_setMainTitle(_ navigationTitle:String!)->Void{
        self.navigationItem.title = navigationTitle
    }
    
    public func hk_remvoeAllObserver(_ isForcefully:Bool = false){
        
        if self.isMovingFromParentViewController || isForcefully{
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    public func hk_setObserver(_ methodname:Selector,observername:String){
        
        NotificationCenter.default.addObserver(self, selector: methodname, name: NSNotification.Name(rawValue: observername), object: nil)
        
    }
    public func hk_setCustomeTitleView(_ navigationTitle:String!,font:UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))->Void{
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        label.text = navigationTitle
        label.font = font
        label.sizeToFit()
        label.textColor = UIColor.white
        
        
        self.navigationItem.titleView = label
    }
  
    public func hk_setCancelButton()->Void{
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action:#selector(UIViewController.hk_cancelClick(_:)))
    }
    
    public func hk_setSaveButton(_ action:Selector)->Void{
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: action)
    }
    
    @objc open func hk_cancelClick(_ sender:AnyObject?){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    public func hk_setBlurryBackground(){
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = self.view.bounds
        visualEffectView.tag = 999
        
        self.view.insertSubview(visualEffectView, at: 0)
        visualEffectView.isHidden=false;
    }
    
    public func hk_isBlurVisible(_ ishidden:Bool){
        //        var visualEffect:UIVisualEffectView? = (self.revealViewController().frontViewController as! UINavigationController).topViewController.view.viewWithTag(999) as? UIVisualEffectView
        //        if visualEffect == nil{
        //            return
        //        }
        //        visualEffect?.hidden = ishidden
        
    }
    
    public func hk_setEmptyView(_ text:String!){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.tag = 9999
        view.addSubview(blurEffectView)
        
        let vibrantLabel = UILabel()
        let ccenter:CGPoint? = self.parent?.view.center
        vibrantLabel.textColor = UIColor.lightGray
        vibrantLabel.backgroundColor = UIColor.clear
        vibrantLabel.font = UIFont.boldSystemFont(ofSize: 8 * UIScreen.main.scale)
        vibrantLabel.textAlignment = .center
        vibrantLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width-50, height: self.view.frame.size.height)
        vibrantLabel.numberOfLines = 0
        vibrantLabel.center = ccenter!
        vibrantLabel.text = text
        blurEffectView.contentView.addSubview(vibrantLabel)
    }
    
    public func hk_isViewEmpty(_ isempty:Bool){
        let visualEffect:UIVisualEffectView? = view.viewWithTag(9999) as? UIVisualEffectView
        if visualEffect == nil{
            return
        }
        visualEffect?.isHidden = isempty
        
    }
    
    public func hk_setToolbarWithActivity(){
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.isHidden = false
        let barbuttonActivity = UIBarButtonItem(customView: activity)
        activity.startAnimating()
        activity.color = MAIN_COLOR
        self.toolbarItems = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),barbuttonActivity,UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)]
        
    }
    public func hk_removeWithAnimation(){
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.alpha = 0
            }, completion: { (sucess) -> Void in
                self.removeFromParentViewController()
                self.view.removeFromSuperview()
                
        })
    }
    public func hk_setBlankBackButton(){
        
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        
    }
    
    public func hk_setCustomBackbutton(_ methodName:Selector){
        let myBackButton:UIButton = UIButton(type: UIButtonType.custom)
        myBackButton.addTarget(self, action: methodName, for: UIControlEvents.touchUpInside)
        myBackButton.setTitle(" ", for: UIControlState())
        myBackButton.setImage(UIImage(named: "back"), for: UIControlState())
        
        myBackButton.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 0)
        myBackButton.titleEdgeInsets = UIEdgeInsetsMake(0,-30, 0, 0)
        myBackButton.setTitleColor(UIColor.gray, for: UIControlState())
        myBackButton.sizeToFit()
        myBackButton.tintColor = UIColor.gray
        
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        
        
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    public func hk_setUpActivityIndicator(){
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.hidesWhenStopped = true
        let barbuttonActivity = UIBarButtonItem(customView: activity)
        if self.navigationItem.rightBarButtonItem != nil {
            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItem!,barbuttonActivity]

        }else{
            self.navigationItem.rightBarButtonItems = [barbuttonActivity]

        }
    }

    public func hk_startIndicator(){
        
        
        if let activity = self.navigationItem.rightBarButtonItems?.last?.customView as? UIActivityIndicatorView {
            activity.startAnimating()
        }
        if let activity = self.navigationItem.leftBarButtonItem?.customView as? UIActivityIndicatorView {
            activity.startAnimating()
        }
    }
    
    public func hk_stopIndicator(){
        if let activity = self.navigationItem.rightBarButtonItems?.last?.customView as? UIActivityIndicatorView {
            activity.stopAnimating()
        }
        if let activity = self.navigationItem.leftBarButtonItem?.customView as? UIActivityIndicatorView {
            activity.stopAnimating()
        }
    }
    
    public func hk_setNavigationBarVisiblity(isVisible:Bool = true){
        self.navigationController?.isNavigationBarHidden = !isVisible
        }
    
    
    
}


extension UIViewController {
    class public func hk_currentViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return hk_currentViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return hk_currentViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return hk_currentViewController(presented)
        }
        return base
    }
    public func hk_isUIViewControllerPresentedAsModal() -> Bool {
        
        
        if((self.presentingViewController) != nil) {
            return true
        }
        
        if(self.presentingViewController?.presentedViewController == self) {
            return true
        }
        
        if(self.navigationController?.presentingViewController?.presentedViewController == self.navigationController) {
            return true
        }
        
        if((self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self)) != nil) {
            return true
        }
        
        return false
    }
}

private var xoAssociationKey: UInt8 = 0


extension UIViewController {
    
    
    public var hk_tbl_pickerIndexPath: IndexPath! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? IndexPath
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    public func hk_tbl_displayInLinepickerAtIndextPath(_ indexpath:IndexPath!,tableView:UITableView)->Void{
        
        tableView.beginUpdates()
        
        let before = hk_tbl_pickerIsBefore(indexpath)
        let sameCellClicked = hk_tbl_isSameCelclicked(indexpath)
        
        if self.hk_tbl_hasInlinePicker() && sameCellClicked{
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: self.hk_tbl_pickerIndexPath.row, section: self.hk_tbl_pickerIndexPath.section)], with: .fade)
            tableView.endUpdates()
            self.hk_tbl_pickerIndexPath = nil
            
        }
        
        if (!sameCellClicked)
        {
            
            
            let rowToReveal:NSInteger! = (before ? indexpath.row-1:indexpath.row)
            
            let indexpathRowtoRivel:IndexPath! = IndexPath(row: rowToReveal, section: indexpath.section)
            self.hk_tbl_insertPickeratIndexPath(indexpathRowtoRivel,tableView:tableView)
            
            self.hk_tbl_pickerIndexPath = IndexPath(row: indexpathRowtoRivel.row + 1, section: indexpathRowtoRivel.section)
            
        }
        
        tableView.deselectRow(at: indexpath, animated: true)
        
        tableView.endUpdates()
        
        
    }
    public func hk_tbl_indexPathHasPicker(_ indexPath:IndexPath!)->Bool{
        
        return (self.hk_tbl_hasInlinePicker() && self.hk_tbl_pickerIndexPath.row == indexPath.row && self.hk_tbl_pickerIndexPath.section == indexPath.section);
        
        
    }
    
    
    public func hk_tbl_hasInlinePicker()->Bool{
        
        
        if((self.hk_tbl_pickerIndexPath) != nil){
            return true
        }
        return false
    }
    
    public func hk_tbl_pickerIsBefore(_ indexpath:IndexPath)->Bool{
        
        var before:Bool = false
        if self.hk_tbl_hasInlinePicker(){
            before = self.hk_tbl_pickerIndexPath.row < (indexpath as NSIndexPath).row && self.hk_tbl_pickerIndexPath.section == (indexpath as NSIndexPath).section
        }
        return before
    }
    
    public func hk_tbl_isSameCelclicked(_ indexpath:IndexPath)->Bool{
        
        var sameCellClicked:Bool = false;
        
        if (self.hk_tbl_pickerIndexPath) != nil {
            sameCellClicked = (self.hk_tbl_pickerIndexPath.row - 1 == (indexpath as NSIndexPath).row && self.hk_tbl_pickerIndexPath.section == (indexpath as NSIndexPath).section)
        }
        return sameCellClicked
    }
    
    public func hk_tbl_hasInlinePicker(_ section:Int)->Bool{
        
        
        if(self.hk_tbl_pickerIndexPath != nil && self.hk_tbl_pickerIndexPath.section == section){
            return true
        }
        return false
    }
    public func hk_tbl_insertPickeratIndexPath(_ indexpath:IndexPath!,tableView:UITableView)->Void{
        tableView.beginUpdates()
        if self.hk_tbl_hasInlinePicker() {
            tableView.deleteRows(at: [IndexPath(row: self.hk_tbl_pickerIndexPath.row, section: self.hk_tbl_pickerIndexPath.section)], with: .fade)
            
        }
        tableView.insertRows(at: [IndexPath(row: indexpath.row + 1, section: indexpath.section)], with: .fade)
        tableView.endUpdates()
    }
}

extension UIViewController{
    
    
    public func hk_segue(_ identifire:String){
        self.performSegue(withIdentifier: identifire, sender: self)
    }
    
    public func hk_segue(_ identifire:String,sender:AnyObject?){
        self.performSegue(withIdentifier: identifire, sender: sender)
    }
}



extension UIViewController  {
    
    
    public func hk_setUpAddClick(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UIViewController.hk_addClick))
        
        
    }
    
    @objc public func hk_addClick(){
        
    }
    
}

