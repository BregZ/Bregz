//
//  NSString-Extension.swift
//  QQ聊天
//
//  Created by MacG on 15/8/30.
//  Copyright (c) 2015年 MacG. All rights reserved.
//

import UIKit

//class NSString_Extension: NSString {
//    
//}

extension NSString {
    ///计算文字的 size（长河宽）
    func sizeWithText(#font : UIFont, maxSize : CGSize) -> CGSize {
        
        let atter : NSDictionary = [NSFontAttributeName : font]
        
        return self.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin
            , attributes: atter as! [String : AnyObject], context: nil).size
    }
}