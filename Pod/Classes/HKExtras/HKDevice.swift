//
//  HKDevice.swift
//  HKKit
//
//  Created by Hardik on 18/01/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import Foundation

public class HKDevice {
    
    static let appname = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

    
    static let device_id = UIDevice.current.hk_deviceUUID
    static let device_deviceLocalizedModel = UIDevice.current.localizedModel
    static let device_name = UIDevice.current.name
    static let device_model = UIDevice.current.model
    static let device_system_version = UIDevice.current.systemVersion
    static let device_system_name = UIDevice.current.systemName
    static let device_platform = platform()
    static let device_os = "iOS"
    static let current_appname = appname
    static let current_appversion = version

    
    class func platform() -> String {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    
    
    
}
