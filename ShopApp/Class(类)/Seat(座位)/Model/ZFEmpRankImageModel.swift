//
//  ZFEmpRankImageModel.swift
//  ShopApp
//
//  Created by mac on 15/11/4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFEmpRankImageModel: NSObject {
    
    var rank : String!
    
    var image : String!
    
    class func empRankImageWithDict(dict : NSDictionary) -> ZFEmpRankImageModel{
        
        return ZFEmpRankImageModel(dict: dict);
        
    }
    
    init(dict : NSDictionary) {
        super.init();
        
        self.setValuesForKeysWithDictionary(dict as [NSObject : AnyObject])
        
    }
    
    override init() {
        super.init();
    }
   
}
