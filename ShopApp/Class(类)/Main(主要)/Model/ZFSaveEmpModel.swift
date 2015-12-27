//
//  ZFSaveEmpModel.swift
//  ShopApp
//
//  Created by mac on 15/10/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSaveEmpModel: NSObject {
    
    var emp_id : Int!
    
    //单例模式
    class func  shareInstance() -> ZFSaveEmpModel {
        struct qzStringle{
            static var predicate : dispatch_once_t = 0
            static var instance : ZFSaveEmpModel? = nil
        }
        //单例化一次
        dispatch_once(&qzStringle.predicate,{
            qzStringle.instance = ZFSaveEmpModel()
        })
        return qzStringle.instance!
    }
    
    
    deinit{
       println("ZFSaveEmpModel 被销毁")
    }
   
}
