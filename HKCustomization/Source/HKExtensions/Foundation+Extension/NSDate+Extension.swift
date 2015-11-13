//
//  UIButton+Extension.swift
//  HKCustomization
//
//  Created by Hardik on 10/18/15.
//  Copyright © 2015 Vivacious. All rights reserved.
//

import UIKit
extension NSDate{
    class func getOnlydate()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.stringFromDate(NSDate())
        return date
    }
    
    func getOnlydate()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    func getOnlydateStartWithDD()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    func getOnlyDateWithMM()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    class func getOnlyTime()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.stringFromDate(NSDate())
        return date
    }
    
    func getOnlyTime()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    func getOnlyTimeWithAMPM()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    func getAMPM()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    func getOnlyTimeWithDot()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    func getOnlyTimeWithDotWithSecond()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    func getOnlyTimeWithSeconds()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    class func getDateFromStringValue(str:String)->NSDate{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.dateFromString(str) ?? NSDate()
        return date
    }
    
    class func getDateFromStringWithSeconds(dateString:String)->NSDate{
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.dateFromString(dateString)
        print(date, terminator: "")
        return date!
    }
    func getOnlydateWithMonthString()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    func getTodayMedicineDate()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E, MMM dd, yyyy"
        
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    
    func getDateAndTimeString()->String!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss a"
        let date = dateFormatter.stringFromDate(self)
        return date
    }
    class func getCurrentTimeStemp()->Int{
        
        return Int(NSDate().timeIntervalSince1970)
    }
    func getCurrentTimeStemp()->Int{
        
        return Int(self.timeIntervalSince1970)
    }
    class func getCurrentDateTimeStemp()->Int{
        
        return getDatebyRemovingTimeFromTimeStamp(NSDate.getOnlydate())
        
    }
    func getCurrentDateTimeStemp()->Int{
        
        return NSDate.getDatebyRemovingTimeFromTimeStamp(self.getOnlydate())
        
    }
    private class func getDatebyRemovingTimeFromTimeStamp(date:String)->Int{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        let date = dateFormatter.dateFromString(date)
        return Int(date!.timeIntervalSince1970)
    }
    
    
    class func getTimeStampFromString(str:String!)->Int{
        
        return Int(getDateFromStringValue(str).timeIntervalSince1970)
    }
    
    
    
    class func getStringDateFromTimeStamp(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getOnlydateWithMonthString()
    }
    class func getStringDateAndTimeFromTimeStamp(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getDateAndTimeString()
    }
    class func getStringTimeFromTimeStamp(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getOnlyTimeWithSeconds()
    }
    class func getTimeStampFromStringWithDateandTime(timestamp:Int)->String{
        return  NSDate(timeIntervalSince1970: Double(timestamp)).getOnlyTimeWithSeconds()
    }
    class func getHourMinwithDate(time:String!)->NSDate!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.dateFromString(time ?? NSDate.getOnlyTime()) ?? NSDate()
        return date
    }
    class func getHourMinwithDateDot(time:String!)->NSDate!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let date = dateFormatter.dateFromString(time ?? NSDate.getOnlyTime()) ?? NSDate()
        return date
    }
    class func getHourMinSecondswithDate(time:String!)->NSDate!{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        let date = dateFormatter.dateFromString(time ?? NSDate.getOnlyTime()) ?? NSDate()
        return date
    }
    
    
    func getNextDay()->String{
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 1,
            toDate: self,
            options: NSCalendarOptions(rawValue: 0))!.getOnlydate()
    }
    

    
    
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        var isGreater = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        return isGreater
    }
    
    
}
