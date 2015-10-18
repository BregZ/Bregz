//
//  UIImage-Extension.swift
//  QQ聊天
//
//  Created by MacG on 15/8/30.
//  Copyright (c) 2015年 MacG. All rights reserved.
//

import UIKit

//class UIImage_Extension: UIImage {
//   
//}


extension UIImage {
    ///图片拉伸
    class func resizableImage(#name : String) -> UIImage {
        var image : UIImage = UIImage(named: name)!
        
        let w : CGFloat = image.size.width * 0.5
        let h : CGFloat = image.size.height * 0.5
        //图片拉伸
        return image.resizableImageWithCapInsets(UIEdgeInsets(top: h, left: w, bottom: h, right: w))
        
    }
}