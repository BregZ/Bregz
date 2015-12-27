//
//  ZFEmpModel.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFEmpModel: NSObject {
    
    var emp_id : Int?          //ID
    
    var emp_name : String?          //名称
    
    var emp_sex : Bool?             //性别
    
    var emp_grade : CGFloat?        //评分
    
    var emp_rank : String?          //排名
    
    class func empModelWithDict(dict : NSDictionary) -> ZFEmpModel{
        return ZFEmpModel(dict: dict)
    }
    
    init(dict : NSDictionary) {
        
        super.init()
        
        self.emp_id = (dict["emp_id"] as! String).toInt()
        
        self.emp_name = dict["emp_name"] as? String
        
        if dict["emp_sex"] != nil {
            
            self.emp_sex = (dict["emp_sex"] as? String)! == "1"
        }
        
        if dict["emp_grade"] != nil {
            
            self.emp_grade = CGFloat((dict["emp_grade"] as! NSString).floatValue)
            
        }
        
        
//        self.emp_id = dict[""] as! String
        
        
        
    }
    
    override init() {
        super.init()
    }
   
}
