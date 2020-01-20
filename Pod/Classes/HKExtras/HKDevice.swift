//
//  HKDevice.swift
//  HKKit
//
//  Created by Hardik on 18/01/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import Foundation
import UIKit

public class HKDevice {
    
    public static let appname = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    public static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

    
    public static let device_id = UIDevice.current.hk_deviceUUID
    public static let device_deviceLocalizedModel = UIDevice.current.localizedModel
    public static let device_name = UIDevice.current.name
    public static let device_model = UIDevice.current.model
    public static let device_system_version = UIDevice.current.systemVersion
    public static let device_system_name = UIDevice.current.systemName
    public static let device_platform = platform()
    public static let device_os = "iOS"
    public static let current_appname = appname
    public static let current_appversion = version

    
    class func platform() -> String {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    
    
    
}
