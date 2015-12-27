//
//  NSDate_Extension.swift
//  ShopApp
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

extension NSDate {

    
    //判断是否是今天
    func isToday() -> Bool {
        
        let calender : NSCalendar = NSCalendar.currentCalendar();
        
        //
        let unit : NSCalendarUnit = NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear;
        
        //获取当前时间的 年月日
        let newCmps : NSDateComponents = calender.components(unit, fromDate: NSDate());
        
        //获取self的年月日
        let selfCmps : NSDateComponents =  calender.components(unit, fromDate: self);
        
        return newCmps.year == selfCmps.year && newCmps.month == selfCmps.month && newCmps.day == selfCmps.day;
        
        
    }
    
    //判断是否是昨天
    func isYearday() -> Bool{
        
        let fmt : NSDateFormatter = NSDateFormatter();
        fmt.dateFromString("yyyy-MM-dd");
        
        //self时间String
        let selfStr : String = fmt.stringFromDate(self);
        
        //现在时间String
        let newStr : String = fmt.stringFromDate(NSDate())
        
        
        //self时间的date
        let selfDate : NSDate = fmt.dateFromString(selfStr)!;
        
        //现在时间date
        let newDate : NSDate = fmt.dateFromString(newStr)!;
        
        let calendar : NSCalendar = NSCalendar.currentCalendar();
        
        let unit : NSCalendarUnit = NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear;
        
        let cmps : NSDateComponents = calendar.components(unit, fromDate: selfDate, toDate: newDate, options: NSCalendarOptions(0));

        return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
    }
    
    //判断是否今年
    func isThisYear() -> Bool{
        
        let calender : NSCalendar = NSCalendar.currentCalendar();
        
        //
        let unit : NSCalendarUnit = NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay;
        
        //获取当前时间的 年月日
        let newCmps : NSDateComponents = calender.components(unit, fromDate: NSDate());
        
        //获取self的年月日
        let selfCmps : NSDateComponents =  calender.components(unit, fromDate: self);
        
        return newCmps.year == selfCmps.year;
    }
    
    //判断时间差
    func delteWithNow() -> NSDateComponents {
        let calender : NSCalendar = NSCalendar.currentCalendar();
        
        //
        let unit : NSCalendarUnit = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond;
        
        return calender.components(unit, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(0));
    }
    
    
}
