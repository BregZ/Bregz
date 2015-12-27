//
//  UILabel_Extension.swift
//  ShopApp
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit


extension UILabel {
    
    func Toact(text : String , fontSize : CGFloat , view : UIView){
        
        let textPadding : CGFloat = 13
        
        var label : UILabel = UILabel()
        
        label.text = text
        
        label.font = UIFont.systemFontOfSize(fontSize)
        
        label.textAlignment = NSTextAlignment.Center
        
        label.textColor = UIColor.whiteColor()
        
        label.backgroundColor = UIColor.blackColor()
        
        let maxSize : CGSize = CGSizeMake(view.bounds.width, CGFloat(MAXFLOAT))
        
        let atter : NSDictionary = [NSFontAttributeName : label.font]
        
        
        let textSize : CGSize = text.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin
            , attributes: atter as! [String : AnyObject], context: nil).size
        
        label.frame = CGRectMake(0, 0, textSize.width + textPadding, textSize.height + textPadding)
        
        label.center = view.center
        
        label.alpha = 0
        //设置圆角
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        view.addSubview(label)
        
        /*
        
        delay －> 动画时间
        UIViewKeyframeAnimationOptions.CalculationModeLinea －> 匀速进行动画
        */
        UIView.animateWithDuration(1, animations: { () -> Void in
            
            //从alpha = 0 -> alpha = 0.5 (显示)
            label.alpha = 0.5
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    //从alpha = 0.5 -> alpha = 0（消失）
                    label.alpha = 0
                    
                    }, completion: { (Bool) -> Void in
                        // 将 label 从父控件删除
                        label.removeFromSuperview()
                })
                
        }
        
    }
    
}