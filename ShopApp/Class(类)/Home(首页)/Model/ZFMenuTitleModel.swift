//
//  MenuTitleModel.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuTitleModel: NSObject {
    
    var menuTitle_id : NSNumber?            //菜单类型id
    
    var menuTitle_name : String?            //菜单类型名字
    
    var menuContents : NSArray?             //菜单内容
    
    var opened : Bool!                      //是否展开这一组
    
    //将字典 转化为对象
    class func menuTitleWithDict(dict : NSDictionary ) -> ZFMenuTitleModel{
        
        return ZFMenuTitleModel(dict: dict)
        
        
    }
    
    init(dict : NSDictionary) {
        
        super.init()
        
        self.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
        
        var menuContentArray = NSMutableArray()
        
        if self.menuContents != nil {
            
            for dtic in self.menuContents! {
                let menuContent : ZFMenuContentModel = ZFMenuContentModel.menuContentWithDict(dtic as! NSDictionary)
                
                menuContentArray.addObject(menuContent)
            }
            
            self.menuContents = menuContentArray
        }

        self.opened = false
    }
    
    override init() {
        super.init()
        
        self.opened = false
    }
    
    deinit {
//        println("ZFMenuTitleModel 被销毁了")
    }

}
