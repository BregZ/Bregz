//
//  ZFBadgeValueBtn.swift
//  ShopApp
//
//  Created by mac on 15/11/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFBadgeValueBtn: UIButton {
    
    var _badgeValue : Int?          //提示数字
    
    var badgeValue : Int {
        set{
            self._badgeValue = newValue;
            
            if newValue > 0 {
                self.hidden = false;
                
                let value : String = "\(newValue)";
                //计算提示文字大小
                let valueSize : CGSize = value.sizeWithText(font: self.titleLabel!.font, maxSize: CGSizeMake(CGFloat(MAXFLOAT),self.frame.height))
                
                if count(value) > 1 {
                    //设置提示文字高度
                    self.frame.size.width = self.frame.size.width * 0.5 + valueSize.width
                }else{
                    self.frame.size.width = self.frame.height;
                }
                //设置提示文字
                self.setTitle("\(newValue)", forState: UIControlState.Normal)
                
            }else {
                //隐藏提示数字
                self.hidden = true;
            }
        }
        get{
            return self._badgeValue!;
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //设置拉伸
        self.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleLeftMargin;
        //背景
        self.setBackgroundImage(UIImage.resizableImage(name: "shoppingCart_badgeValue"), forState: UIControlState.Normal)

        //设置按钮不能点击
        self.userInteractionEnabled = false;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
