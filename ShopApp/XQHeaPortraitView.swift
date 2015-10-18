//
//  XQHeaPortraitView.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQHeaPortraitView: UIView {
    
    let windowW : CGFloat = UIScreen.mainScreen().bounds.width
    
    let headRadius : CGFloat = 65
    
    let lineW : CGFloat = 6
    
    let headY : CGFloat = 100
    
    var _headImageName : String?
    
    var headImageName : String {
        set {
            self._headImageName = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return self._headImageName!
        }
    }
    
    init(y : CGFloat) {
        super.init(frame: CGRectMake(0, y, self.windowW,  (self.headRadius + self.lineW) * 2))
        
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        if self._headImageName != nil {
            
            let context = UIGraphicsGetCurrentContext()
            
            UIColor.whiteColor().set()
            CGContextAddEllipseInRect(context, CGRectMake(self.windowW * 0.5 - self.headRadius - self.lineW, 0, (self.headRadius + self.lineW) * 2, (self.headRadius + self.lineW) * 2))
            CGContextFillPath(context)
            
            
            //画圆
            CGContextAddEllipseInRect(context, CGRectMake(self.windowW * 0.5 - self.headRadius, lineW, self.headRadius * 2, self.headRadius * 2))
            
            //将超出所画形状的图片像素 剪掉
            CGContextClip(context)
            
            CGContextFillPath(context)
            
            let image = UIImage(named: self.headImageName)
            
            image?.drawAtPoint(CGPoint(x: self.windowW * 0.5 - self.headRadius, y: lineW))
            
            
        }
        
        
    }
   /* */

}
