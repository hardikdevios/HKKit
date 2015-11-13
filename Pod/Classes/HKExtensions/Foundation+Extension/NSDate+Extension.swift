//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 . All rights reserved.
//

import UIKit
extension NSDate{
    public class func getOnlydate()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.stringFromDate(NSDate())
        return date
    }
    
    public func getOnlydate()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public func getOnlydateStartWithDD()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public func getOnlyDateWithMM()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    public class func getOnlyTime()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.stringFromDate(NSDate())
        return date
    }
    
    public func getOnlyTime()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public func getOnlyTimeWithAMPM()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    public func getAMPM()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public func getOnlyTimeWithDot()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public func getOnlyTimeWithDotWithSecond()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public func getOnlyTimeWithSeconds()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public class func getDateFromStringValue(str:String)->NSDate{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.dateFromString(str) ?? NSDate()
        return date
    }
    
    public class func getDateFromStringWithSeconds(dateString:String)->NSDate{
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.dateFromString(dateString)
        print(date, terminator: "")
        return date!
    }
    public func getOnlydateWithMonthString()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    public func getTodayMedicineDate()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E, MMM dd, yyyy"
        
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    public func getDateAndTimeString()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    public class func getCurrentTimeStemp()->Int{
        
        return Int(NSDate().timeIntervalSince1970)
    }
    public func getCurrentTimeStemp()->Int{
        
        return Int(self.timeIntervalSince1970)
    }
    public class func getCurrentDateTimeStemp()->Int{
        
        return getDatebyRemovingTimeFromTimeStamp(NSDate.getOnlydate())
        
    }
    public func getCurrentDateTimeStemp()->Int{
        
        return NSDate.getDatebyRemovingTimeFromTimeStamp(self.getOnlydate())
        
    }
    private class func getDatebyRemovingTimeFromTimeStamp(date:String)->Int{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.dateFromString(date)
        return Int(date!.timeIntervalSince1970)
    }
    
    
    public class func getTimeStampFromString(str:String!)->Int{
        
        return Int(getDateFromStringValue(str).timeIntervalSince1970)
    }
    
    
    
    public class func getStringDateFromTimeStamp(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getOnlydateWithMonthString()
    }
    public class func getStringDateAndTimeFromTimeStamp(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getDateAndTimeString()
    }
    public class func getStringTimeFromTimeStamp(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getOnlyTimeWithSeconds()
    }
    public class func getTimeStampFromStringWithDateandTime(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getOnlyTimeWithSeconds()
    }
    public class func getHourMinwithDate(time:String!)->NSDate!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString(time ?? NSDate.getOnlyTime()) ?? NSDate()
        return date
    }
    public class func getHourMinwithDateDot(time:String!)->NSDate!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let date = dateFormatter.dateFromString(time ?? NSDate.getOnlyTime()) ?? NSDate()
        return date
    }
    public class func getHourMinSecondswithDate(time:String!)->NSDate!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.dateFromString(time ?? NSDate.getOnlyTime()) ?? NSDate()
        return date
    }
    
    
    public func getNextDay()->String{
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 1,
            toDate: self,
            options: NSCalendarOptions(rawValue: 0))!.getOnlydate()
    }
    

    
    
    public func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        var isGreater = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        return isGreater
    }
    
    
}
