//
//  ZFSaveLoginEmpModel.swift
//  ShopApp
//
//  Created by mac on 15/11/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSaveLoginEmpModel: NSObject {
   
    var emp_id : Int!
    
    var isLoginState  : Bool?
    
    override init() {
        super.init();
    }
    
    ///NSKeyedArchiver 归档时数据是怎么保存的，保存什么属性
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeInteger(self.emp_id, forKey: "emp_id");
        aCoder.encodeBool(self.isLoginState!, forKey: "isLoginState");
        
    }
    
    //NSKeyedArchiver 是怎么样读取的，读取什么属性
    required init(coder aDecoder: NSCoder) {
        self.emp_id = Int(aDecoder.decodeIntegerForKey("emp_id"));
        self.isLoginState = aDecoder.decodeBoolForKey("isLoginState");
    }
}
