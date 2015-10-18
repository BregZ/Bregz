//
//  XQMenuContentModel.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQMenuContentModel: NSObject {
    
    var menuContent_id : NSNumber?              //菜单内容id
    
    var menuContent_name : String?              //菜单内容名字
    
    var menuContent_price : NSNumber?           //菜单内容价格
    
    var menuContent_introduce : String?         //菜单内容介绍
    
    var menuContent_measure : NSNumber?         //菜单内容销量
    
    var menuContent_img : String?               //菜单内容图片
    
    var menuTitle_id : NSNumber?                //菜单类型id
    
    //XQMenuContentTableViewCell
    class func menuContentWithDict(dict : NSDictionary) -> XQMenuContentModel{
        return XQMenuContentModel(dict: dict)
    }
   
    
    init(dict : NSDictionary){
        
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as [NSObject : AnyObject])
        
    }
    
    override init() {
        super.init()
    }
}
