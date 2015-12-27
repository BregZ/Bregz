//
//  CGPoint_Extension.swift
//  ShopApp
//
//  Created by mac on 15/11/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

extension CGPoint {
    
    static func distanceFromPoint(max: CGPoint, min: CGPoint) -> CGFloat{
        
        var distance : CGFloat!;
        
        //下面就是高中的数学，不详细解释了
        
        let xDist : CGFloat = (min.x - max.x);
        
        let yDist : CGFloat = (min.y - max.y);
        
        distance = sqrt((xDist * xDist) + (yDist * yDist));
        
        return distance;
        
    }
}
