//
//  ZFMenuContentModel.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuContentModel: NSObject {
    
    var menuContent_id : NSNumber?              //菜单内容id
    
    var menuContent_name : String?              //菜单内容名字
    
    var menuContent_pinYin : String?            //菜单名字拼音
    
    var menuContent_pinYinHead : String?       //菜单名字简拼
    
    var menuContent_price : NSNumber?           //菜单内容价格
    
    var menuContent_introduce : String?         //菜单内容介绍
    
    var menuContent_measure : NSNumber?         //菜单内容销量
    
    var menuContent_img : String?               //菜单内容图片
    
    var menuTitle_id : NSNumber?                //菜单类型id
    
    var menuContent_isProvide : String?           //是否有售
    
    //ZFMenuContentTableViewCell
    class func menuContentWithDict(dict : NSDictionary) -> ZFMenuContentModel{
        return ZFMenuContentModel(dict: dict)
    }
   
    
    init(dict : NSDictionary){
        
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as [NSObject : AnyObject])
        
    }
    
    override init() {
        super.init()
    }
    
    deinit {
//        println("ZFMenuContentModel 被销毁了")
    }
}
