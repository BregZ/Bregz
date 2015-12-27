//
//  ZFTimeTool.swift
//  ShopApp
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFTimeTool: NSObject {
    
    //获取显示时间
    func getShowTime(newValue : String) -> String{
        
        let fmt : NSDateFormatter = NSDateFormatter();
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let createdDate : NSDate = fmt.dateFromString(newValue)!;
        
        var timeStr : String = "";
        
        if createdDate.isToday() {          //今天
            
            if createdDate.delteWithNow().hour >= 1 {
                timeStr = "\(createdDate.delteWithNow().hour)小时前";
            }else if createdDate.delteWithNow().minute >= 1 {   //
                timeStr = "\(createdDate.delteWithNow().minute)分钟前";
            }else {
                timeStr = "刚刚";
            }
        }else if createdDate.isYearday() { //昨天
            
            fmt.dateFormat = "昨天 HH:mm";
            timeStr = fmt.stringFromDate(createdDate);
            
        }else if createdDate.isThisYear() { //今年
            
            fmt.dateFormat = "MM-dd HH:mm";
            timeStr = fmt.stringFromDate(createdDate);
        } else {
            
            fmt.dateFormat = "yyyy-MM-dd HH:mm";
            timeStr = fmt.stringFromDate(createdDate);
        }
        
        return timeStr;
    }

   
}
