//
//  UIView_Extension.swift
//  ShopApp
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

extension UIView {
    
    //添加分割线
    class func addLine(x : CGFloat , y : CGFloat) -> UIView {
        
        let lineX : CGFloat = x
        let lineY : CGFloat = y
        let lineW : CGFloat = UIScreen.mainScreen().bounds.width
        let lineH : CGFloat = 1
        
        let lineView : UIView = UIView()
        
        lineView.frame = CGRectMake(lineX, lineY, lineW, lineH)
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        lineView.alpha = 0.2
        
        return lineView
    }
    
    
}