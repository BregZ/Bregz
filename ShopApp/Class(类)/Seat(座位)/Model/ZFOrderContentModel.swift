//
//  ZFOrderContentModel.swift
//  ShopApp
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFOrderContentModel: NSObject {
    
    var orderContentName : String!      //名字
    
    var orderContentPrice : CGFloat!    //价格
    
    var orderContentNumber : Int = 1    //数量
    
    var seat_id : Int!                  //座位号
    
    override init() {
        super.init()
    }
    
    func dictWithOrderContentModel(OrderContent : ZFOrderContentModel) -> NSDictionary {
        
        var dict = Dictionary<String, AnyObject>()
        
        dict["orderContentName"] = OrderContent.orderContentName!
        dict["orderContentPrice"] = OrderContent.orderContentPrice!
        dict["orderContentNumber"] = OrderContent.orderContentNumber
//        dict["seat_id"] = OrderContent.seat_id
        
        return dict
        
//        return OrderContent.dictionaryWithValuesForKeys(["orderContentName","orderContentNumber"])
        
    }
    
    class func orderContentModelWithDict(dict : NSDictionary) -> ZFOrderContentModel{
        
        return ZFOrderContentModel(dict: dict)
    }
    
    init(dict : NSDictionary){
        
        super.init()
        
        self.orderContentName = dict["orderContentName"] as? String
        
        let price = dict["orderContentPrice"] as? NSString
        self.orderContentPrice =  CGFloat(price!.floatValue)
        
        self.orderContentNumber = (dict["orderContentNumber"] as! String).toInt()!
        
    }
    
}
