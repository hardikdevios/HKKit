//
//  UIAppDelegate+Notification.swift
//  HKKit
//
//  Created by Hardik Shah on 01/08/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import UserNotifications


public class HKNotificaitonManager:NSObject, UNUserNotificationCenterDelegate {
    
    
    
    public var deviceToken:String = ""
    public var delegate = UIApplication.shared.delegate!
    public static var `default`:HKNotificaitonManager {
        return HKNotificaitonManager()
    }
    override init() {
        super.init()
        self.swizzleSetUp()
    }
    
    func swizzleSetUp(){
        let main = UIApplication.shared.delegate!
        self.swizzle(selector: #selector(main.application(_:didRegisterForRemoteNotificationsWithDeviceToken:)) ,
                     replaceSelector: #selector(self.hk_application(_:didRegisterForRemoteNotificationsWithDeviceToken:)))
        
        self.swizzle(selector: #selector(main.application(_:didFailToRegisterForRemoteNotificationsWithError:)) ,
                     replaceSelector: #selector(self.hk_application(_:didFailToRegisterForRemoteNotificationsWithError:)))
        
        self.swizzle(selector: #selector(main.application(_:didReceiveRemoteNotification:)) ,
                     replaceSelector: #selector(self.hk_application(_:didReceiveRemoteNotification:)))
        
        self.swizzle(selector: #selector(main.application(_:didReceiveRemoteNotification:fetchCompletionHandler:)) ,
                     replaceSelector: #selector(self.hk_application(_:didReceiveRemoteNotification:fetchCompletionHandler:)))
        
        
    }
    
    
    func swizzle(selector:Selector,replaceSelector:Selector){
        
        
        let originalClass:AnyClass =  NSClassFromString(NSStringFromClass(type(of: UIApplication.shared.delegate!)))!
        
        let originalMethod = class_getInstanceMethod(originalClass, selector)
        let swizzledMethod = class_getInstanceMethod(self.classForCoder, replaceSelector)
        
        let didAdd = class_addMethod(originalClass, selector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAdd {
            
            class_replaceMethod(originalClass,
                                selector,
                                method_getImplementation(originalMethod!),
                                method_getTypeEncoding(originalMethod!))
        }else{
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        
        
    }
    
    public func registerForRemoteNotificaiton(handler:((String?,Error?)->())?){
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
                (granted, error) in
                if (granted) {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        
    }
    
    
    
    
    
    
    @objc public func hk_application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.delegate.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        self.deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
    }
    // Called when APNs failed to register the device for push notifications
    @objc public func hk_application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        
    }
    
    @objc func hk_application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        self.delegate.application?(application, didReceiveRemoteNotification: data)
        
    }
    
    
    
    
    
    
    @objc func hk_application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.delegate.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        completionHandler(UIBackgroundFetchResult.newData);
        
        
    }
    
    // MARK UNNotificationCenter Delegate Methods
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        
        /**
         If your app is in the foreground when a notification arrives, the notification center calls this method to deliver the notification directly to your app. If you implement this method, you can take whatever actions are necessary to process the notification and update your app. When you finish, execute the completionHandler block and specify how you want the system to alert the user, if at all.
         
         If your delegate does not implement this method, the system silences alerts as if you had passed the UNNotificationPresentationOptionNone option to the completionHandler block. If you do not provide a delegate at all for the UNUserNotificationCenter object, the system uses the notification’s original options to alert the user.
         
         see https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter
         
         **/
        
    }
    
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        
        /**
         Use this method to perform the tasks associated with your app’s custom actions. When the user responds to a notification, the system calls this method with the results. You use this method to perform the task associated with that action, if at all. At the end of your implementation, you must call the completionHandler block to let the system know that you are done processing the notification.
         
         You specify your app’s notification types and custom actions using UNNotificationCategory and UNNotificationAction objects. You create these objects at initialization time and register them with the user notification center. Even if you register custom actions, the action in the response parameter might indicate that the user dismissed the notification without performing any of your actions.
         
         If you do not implement this method, your app never responds to custom actions.
         
         see https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter
         
         **/
        
        completionHandler()
        
    }
    
    
    
    
}
