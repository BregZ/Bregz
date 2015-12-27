
//
//  ZFOrdersModel.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFOrdersModel: NSObject {
    
    var seat_id : NSNumber?             // 座位id
    
    var seat_name : String?             //座位名称
    
    var orders_price : NSNumber?        //订单总价
    
    var order_time : String?            //订单时间
    
    //获取allOrder
    
    class func ordersModelWithDict(dict : NSDictionary) -> ZFOrdersModel{
        let ordersModel = ZFOrdersModel(dict: dict)
        return ordersModel
    }
    
    init(dict : NSDictionary) {
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as [NSObject : AnyObject])
    }
    
    override init() {
        super.init()
    }
   
}
