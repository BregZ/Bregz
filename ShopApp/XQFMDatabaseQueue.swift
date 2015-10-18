//
//  XQFMDatabaseQueue.swift
//  ShopApp
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQFMDatabaseQueue: NSObject {
    
    //FMDatabaseQueue 对列，里面有一个已经封装好线程安全的FMDatabase
    var queue : FMDatabaseQueue?
    
    //单例模式
    class func  shareInstance() -> XQFMDatabaseQueue {
        struct qzStringle{
            static var predicate : dispatch_once_t = 0
            static var instance : XQFMDatabaseQueue? = nil
        }
        //单例化一次
        dispatch_once(&qzStringle.predicate,{
            qzStringle.instance = XQFMDatabaseQueue()
        })
        return qzStringle.instance!
    }

    override init() {
        super.init()
        
        //获取沙盒中数据库文件名
        var fileString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as! String
        
        fileString = fileString.stringByAppendingPathComponent("shopApp.sqlite")
        
        println(fileString)
        
        //声明一个 FMDatabaseQueue ，如果 fileString 所指的 sqlite 文件不存在，会自动创建在打开，如果存在，就直接打开
        self.queue = FMDatabaseQueue(path: fileString)
        
//        println("创建数据库成功")
        
//        用这个方法可以获得已经封装好线程安全 FMDatabase 的对象
        self.queue?.inDatabase({ (db : FMDatabase!) -> Void in
            

            XQMenuTitleDBTool.createMenuTitleTable(db)
            
            XQMenuContentDBTool.createMenuContentTable(db)
            
        })

    }
   
}
