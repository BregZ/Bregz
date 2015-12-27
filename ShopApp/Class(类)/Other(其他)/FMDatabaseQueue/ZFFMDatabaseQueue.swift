//
//  ZFFMDatabaseQueue.swift
//  ShopApp
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFFMDatabaseQueue: NSObject {
    
    //FMDatabaseQueue 对列，里面有一个已经封装好线程安全的FMDatabase
    var queue : FMDatabaseQueue?
    
    //单例模式
    class func  shareInstance() -> ZFFMDatabaseQueue {
        struct qzStringle{
            static var predicate : dispatch_once_t = 0
            static var instance : ZFFMDatabaseQueue? = nil
        }
        //单例化一次
        dispatch_once(&qzStringle.predicate,{
            qzStringle.instance = ZFFMDatabaseQueue()
        })
        return qzStringle.instance!
    }

    override init() {
        super.init()
        
        //创建存储图片的文件夹
//        self.createFlie(FILE_STRING)
        
        //创建个人信息文件
        let saveEmp : ZFSaveEmpModel = ZFSaveEmpModel.shareInstance()
        ZFEmpTool.createEmpPlist(FILE_STRING,emp_id: saveEmp.emp_id)
        
        let fileString = FILE_STRING.stringByAppendingPathComponent("shopApp.sqlite")
        
        println(fileString)
        
        //声明一个 FMDatabaseQueue ，如果 fileString 所指的 sqlite 文件不存在，会自动创建在打开，如果存在，就直接打开
        self.queue = FMDatabaseQueue(path: fileString)
        
//        println("创建数据库成功")
        
//        用这个方法可以获得已经封装好线程安全 FMDatabase 的对象
        self.queue?.inDatabase({ (db : FMDatabase!) -> Void in
            
            //创建菜单标题表
            ZFMenuTitleDBTool.createMenuTitleTable(db)
            
            //创建菜内容题表
            ZFMenuContentDBTool.createMenuContentTable(db)
            
            //创建每桌订单表
            ZFSeatDBTool.createSeatOrderTable(db)
            
            
        })

    }
    
    //创建存储图片的文件夹
    func createFlie(fileString : String){
        let fileManager : NSFileManager = NSFileManager.defaultManager()
        
        let path : String = "\(fileString)/shopApp/image"
        
        let isCreateSuccess : Bool = fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: nil)
        
        if isCreateSuccess {
//            println("创建存储图片的文件夹成功")
        }else{
            println("创建存储图片的文件夹失败")
        }
    }
   
}
