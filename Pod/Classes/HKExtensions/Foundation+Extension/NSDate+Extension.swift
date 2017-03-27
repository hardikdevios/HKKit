//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension Date{
    public static func getOnlydate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
    public func getOnlydate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func getOnlydateStartWithDD()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func getOnlyDateWithMM()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public static func getOnlyTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
    public func getOnlyTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func getOnlyTimeWithAMPM()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func getAMPM()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func getOnlyTimeWithDot()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func getOnlyTimeWithDotWithSecond()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.string(from: self)
        return date
    }
    public func getOnlyTimeWithSeconds()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.string(from: self)
        return date
    }
    public static func getDateFromStringValue(_ str:String)->Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.date(from: str) ?? Date()
        return date
    }
    
    public static func getDateFromStringWithSeconds(_ dateString:String)->Date{
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    public func getOnlydateWithMonthString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func getTodayMedicineDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM dd, yyyy"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func getDateAndTimeString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.string(from: self)
        return date
    }
    public static func getCurrentTimeStemp()->Int{
        
        return Int(Date().timeIntervalSince1970)
    }
    public func getCurrentTimeStemp()->Int{
        
        return Int(self.timeIntervalSince1970)
    }
    public static func getCurrentDateTimeStemp()->Int{
        
        return getDatebyRemovingTimeFromTimeStamp(Date.getOnlydate())
        
    }
    public func getCurrentDateTimeStemp()->Int{
        
        return Date.getDatebyRemovingTimeFromTimeStamp(self.getOnlydate())
        
    }
    fileprivate static func getDatebyRemovingTimeFromTimeStamp(_ date:String)->Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.date(from: date)
        return Int(date!.timeIntervalSince1970)
    }
    
    
    public static func getTimeStampFromString(_ str:String)->Int{
        
        return Int(getDateFromStringValue(str).timeIntervalSince1970)
    }
    
    
    
    public static func getStringDateFromTimeStamp(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).getOnlydateWithMonthString()
    }
    public static func getStringDateAndTimeFromTimeStamp(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).getDateAndTimeString()
    }
    public static func getStringTimeFromTimeStamp(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).getOnlyTimeWithSeconds()
    }
    public static func getTimeStampFromStringWithDateandTime(_ timestamp:Int)->String{
        return  Date(timeIntervalSince1970: Double(timestamp)).getOnlyTimeWithSeconds()
    }
    public static func getHourMinwithDate(_ time:String)->Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: time) ?? Date()
        return date
    }
    public static func getHourMinwithDateDot(_ time:String)->Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let date = dateFormatter.date(from: time ) ?? Date()
        return date
    }
    public static func getHourMinSecondswithDate(_ time:String)->Date!{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.date(from: time ) ?? Date()
        return date
    }
    
    
    public func getNextDay()->String{
        return (Calendar.current as NSCalendar).date(
            byAdding: .day,
            value: 1,
            to: self,
            options: NSCalendar.Options(rawValue: 0))!.getOnlydate()
    }
    

    
    
    public func isGreaterThanDate(_ dateToCompare : Date) -> Bool
    {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending
        {
            isGreater = true
        }
        
        return isGreater
    }
    
    
}
