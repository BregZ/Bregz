//
//  ZFSetupContentCell.swift
//  ShopApp
//
//  Created by mac on 15/11/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSetupContentModel: NSObject {
    
    var iconName : String!      //图片名字
    
    var title : String!     //标题文字
    
    override init() {
        super.init()
    }
    
    init(dict : NSDictionary) {
        super.init();
        
        self.setValuesForKeysWithDictionary(dict as [NSObject : AnyObject])
    }
}
