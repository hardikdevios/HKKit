//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension Date{
    public static func hk_getOnlydate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
    public func hk_getOnlydate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func hk_getOnlydateStartWithDD()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func hk_getOnlyDateWithMM()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public static func hk_getOnlyTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
    public func hk_getOnlyTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func hk_getOnlyTimeWithAMPM()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func hk_getAMPM()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func hk_getOnlyTimeWithDot()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func hk_getOnlyTimeWithDotWithSecond()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func hk_getOnlyTimeWithSeconds()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.string(from: self)
        return date
    }
    public static func hk_getDateFromStringValue(_ str:String)->Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.date(from: str) ?? Date()
        return date
    }
    
    public static func hk_getDateFromStringWithSeconds(_ dateString:String)->Date{
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    public func hk_getOnlydateWithMonthString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func hk_getTodayMedicineDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM dd, yyyy"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func hk_getDateAndTimeString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.string(from: self)
        return date
    }
    public static func hk_getCurrentTimeStemp()->Int{
        
        return Int(Date().timeIntervalSince1970)
    }
    public func hk_getCurrentTimeStemp()->Int{
        
        return Int(self.timeIntervalSince1970)
    }
    public static func hk_getCurrentDateTimeStemp()->Int{
        
        return hk_getDatebyRemovingTimeFromTimeStamp(Date.hk_getOnlydate())
        
    }
    public func hk_getCurrentDateTimeStemp()->Int{
        
        return Date.hk_getDatebyRemovingTimeFromTimeStamp(self.hk_getOnlydate())
        
    }
    fileprivate static func hk_getDatebyRemovingTimeFromTimeStamp(_ date:String)->Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.date(from: date)
        return Int(date!.timeIntervalSince1970)
    }
    
    
    public static func hk_getTimeStampFromString(_ str:String)->Int{
        
        return Int(hk_getDateFromStringValue(str).timeIntervalSince1970)
    }
    
    
    
    public static func hk_getStringDateFromTimeStamp(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).hk_getOnlydateWithMonthString()
    }
    public static func hk_getStringDateAndTimeFromTimeStamp(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).hk_getDateAndTimeString()
    }
    public static func hk_getStringTimeFromTimeStamp(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).hk_getOnlyTimeWithSeconds()
    }
    public static func hk_getTimeStampFromStringWithDateandTime(_ timestamp:Int)->String{
        return
            Date(timeIntervalSince1970: Double(timestamp)).hk_getOnlyTimeWithSeconds()
    }
    public static func hk_getHourMinwithDate(_ time:String)->Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: time) ?? Date()
        return date
    }
    public static func hk_getHourMinwithDateDot(_ time:String)->Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let date = dateFormatter.date(from: time ) ?? Date()
        return date
    }
    public static func hk_getHourMinSecondswithDate(_ time:String)->Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.date(from: time ) ?? Date()
        return date
    }
    
    
    public func hk_getNextDay()->String{
        return (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: 1,
            to: self,
            options: NSCalendar.Options(rawValue: 0))!.hk_getOnlydate()
    }
    

    
    
    public func hk_isGreaterThanDate(_ dateToCompare : Date) -> Bool
    {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending
        {
            isGreater = true
        }
        
        return isGreater
    }
    
    
}
