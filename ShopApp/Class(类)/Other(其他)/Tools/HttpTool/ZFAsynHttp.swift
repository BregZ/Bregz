//
//  ZFAsynHttp.swift
//  ShopApp
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFAsynHttp: NSObject {
    
    static let IP : String = "127.0.0.1"
    
    
    class func sendGetHttp(url : String,isNSUTF8StringEncoding : Bool) -> NSURLRequest{
        
        //如果字符串中含有中文或特殊字符（空格），就需要转义
        var str : String = "http://\(self.IP)/\(url)"
        
        if isNSUTF8StringEncoding {
            //中文转义
            str = str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        }
        
        //1.URL
        let url : NSURL = NSURL(string: str)!
        
        //2.Request(创建连接)
        //        let request : NSURLRequest = NSURLRequest(URL: url)
        
        //cachePolicy : 缓存
        //timeoutInterval : 加载超时
        let request : NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        
       

        return request
    }
    
    class func sendPostHttp(url : String ,var strHTTPBody : String,isNSUTF8StringEncoding : Bool) -> NSURLRequest {
        
        //1.URL
        let url : NSURL = NSURL(string: "http://\(self.IP)/\(url)")!
        
        //2.Request
        var request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        //默认是GET 请求
        request.HTTPMethod = "POST"
        
        //数据体
        
        if isNSUTF8StringEncoding {
            //中文转义
            strHTTPBody = strHTTPBody.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        }

        
        //将str 转化为 NSData
        request.HTTPBody = strHTTPBody.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        return request
        
    }
   
}
