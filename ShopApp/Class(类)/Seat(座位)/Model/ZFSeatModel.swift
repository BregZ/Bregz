//
//  ZFSeatModel.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSeatModel: NSObject {
   
    var seat_id : Int?
    var seat_name : String?
    var seat_state : Bool?
    
    class func seatWithDict(dict : NSDictionary) -> ZFSeatModel{
        
        return ZFSeatModel(dict : dict)
        
    }
    
    init(dict : NSDictionary){
        super.init()
        
        self.seat_id = (dict["seat_id"] as? String)?.toInt()
        
        self.seat_name = dict["seat_name"] as? String
        
        self.seat_state = (dict["seat_state"] as? String) == "1" ? true : false
        
    }
    
    override init() {
        super.init()
    }
}
