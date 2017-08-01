//
//  UIAppDelegate+Notification.swift
//  HKKit
//
//  Created by Hardik Shah on 01/08/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
import UserNotifications


public class HKMain: UIResponder, UNUserNotificationCenterDelegate {
    
    
    typealias clouserforRegister = (String?,Error?)->Swift.Void
    public typealias clouserforReceive = (Any)->Swift.Void
    public typealias clouserforPresent = (Any)->Swift.Void

    var didRegister:clouserforRegister?
    
    public var didRecieve:clouserforReceive?
    public var willPresent:clouserforPresent?

    public var deviceToken:String = ""
    static var `default`:HKMain {
    
        return HKMain()
    }
    
    
    func registerForRemoteNotificaiton(handler: @escaping(clouserforRegister)){
        
        self.didRegister = handler
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
    
    
    
    

    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        self.deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        self.didRegister?(self.deviceToken,nil)
        
    }
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.didRegister?(nil,error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        self.didRecieve?(data)
        
    }

    
    
    

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        self.didRecieve?(userInfo)
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
        self.willPresent?(notification.request.content.userInfo)
        
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
        
        self.didRecieve?(response.notification.request.content.userInfo)
        completionHandler()
        
    }

    
    
    
}
