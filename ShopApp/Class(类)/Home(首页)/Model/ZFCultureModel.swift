//
//  ZFCultureModel.swift
//  ShopApp
//
//  Created by mac on 15/11/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFCultureModel: NSObject {
   
    var culture_id : Int!
    
    var culture_image : String?
    
    var culture_name : String?
    
    override init() {
        super.init();
    }
    
    init(dict : NSDictionary) {
        super.init();
        
        self.culture_id = (dict["culture_id"]! as! String).toInt();
        
        self.culture_image = dict["culture_image"] as? String;
        
        self.culture_name = dict["culture_name"] as? String;
    }
}
