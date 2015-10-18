//
//  XQShoppingCartBtn.swift
//  ShopApp
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQShoppingCartBtn: UIButton {

    var _badgeValue : Int?          //提示数字
    
    var bgValue : UIImage?          //提示数字的背景
    
    var bgValueX : CGFloat?         //提示数字的背景X
    
    var valueX : CGFloat?           //提示数字X
    
    var valueY : CGFloat?           //提示数字Y
    
    var attr : NSMutableDictionary? //提示数字属性
    
    var badgeValue : Int {
        set{
            self._badgeValue = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return self._badgeValue!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //圆形背景
        self.bgValue = UIImage(named: "shoppingCart_badgeValue")!
        //圆形背景X
        self.bgValueX = self.frame.width - self.bgValue!.size.width
        
        //提示数字X
        self.valueX = bgValueX
        
        //提示数字Y
        self.valueY = 2.5
        
        //提示数字属性
        self.attr = NSMutableDictionary()
        
        attr![NSFontAttributeName] = UIFont.systemFontOfSize(12)        //提示数字大小
        attr![NSForegroundColorAttributeName] = UIColor.whiteColor()    //提示数字颜色
        
       
        var paragraph : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.Center
        attr![NSParagraphStyleAttributeName] = paragraph
        self.badgeValue = 0

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        //画背景图
        let imageBg = UIImage(named: "shopCar_bg")
        
        imageBg?.drawInRect(CGRectMake(0, 0, imageBg!.size.width, imageBg!.size.height))
        
        if self._badgeValue != 0 {
            
            
            //画提示数字的背景
            self.bgValue!.drawAtPoint(CGPoint(x: bgValueX! , y: 0))
            
            let value : NSString = "\(self.badgeValue)"
            
            //画提示数字
            value.drawInRect(CGRectMake(self.valueX!, self.valueY!, self.bgValue!.size.width, self.bgValue!.size.height), withAttributes: self.attr! as [NSObject : AnyObject])
        }
    }
    

}
