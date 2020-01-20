//
//  HKEnums.swift
//  HKKit
//
//  Created by Hardik Shah on 13/09/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import Foundation
#if canImport(AFDateHelper)
import AFDateHelper

public enum HK_ENUM_WEEKDAY: String,ViewPager {
    case ALL = "All Day"
    case Sunday = "Sunday"
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    
    
  public var mainValue:Int{
        
        switch self {
        case .Sunday:
            return 7
            
        case .Monday:
            return 1
        case .Tuesday:
            return 2
        case .Wednesday:
            return 3
        case .Thursday:
            return 4
        case .Friday:
            return 5
        case .Saturday:
            return 6
            
            
        default:
            return -1
        }
        
    }
    public static func getDay(fromInt:Int)->HK_ENUM_WEEKDAY {
        
        return self.days.filter({$0.mainValue == fromInt}).first ?? HK_ENUM_WEEKDAY.ALL
    }
    public func getShortName(characters:Int = 2,capital:Bool = true ) -> String {
        
        let string = String(self.rawValue.prefix(characters))
        return string.uppercased()
        
    }
    
    public static func getWeek(fromInt:Int)->HK_ENUM_WEEKDAY {
        
        return self.days.filter({$0.mainValue == fromInt}).first ?? HK_ENUM_WEEKDAY.Monday
    }
    public var stringValue: String {
        get {
            if self == .ALL {
                return "ALL"
            }
            return String(self.rawValue[self.rawValue.index(self.rawValue.startIndex, offsetBy: 0)])
        }
    }
    public var title:String{
        get {
            if self == .ALL {
                return "ALL"
            }
            let string = String(self.rawValue.prefix(3))
            return string.uppercased()
        }
        
    }
    
    public static var today:HK_ENUM_WEEKDAY {
        get{
            
            return self.days.filter({ $0.mainValue == Date().component(.weekday)! - 1}).first ?? HK_ENUM_WEEKDAY.Monday
            
        }
        
    }
    public var isToday: Bool {
        
        return  Date().toString(style: .weekday) == self.rawValue
        
        
    }
    
    
    
    public static let days = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday ]
    public static let days_with_All = [ALL,Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
    
}
#endif
