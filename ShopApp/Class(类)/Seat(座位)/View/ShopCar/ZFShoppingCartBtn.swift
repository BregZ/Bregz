//
//  ZFShoppingCartBtn.swift
//  ShopApp
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit



class ZFShoppingCartBtn: UIButton {

    var _badgeValue : Int?          //提示数字
    
    var badgeValueFont : UIFont = UIFont.systemFontOfSize(12); //提示数字大小
    
    let badgeValueWH: CGFloat = 20;   //提示文字高度
    
    weak var badgeValueView : ZFBadgeValueBtn!
    
    var badgeValue : Int {
        set{
            self._badgeValue = newValue;
            
            self.badgeValueView.badgeValue = newValue;
            
        }
        get{
            return self._badgeValue!;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        //设置背景图片
        self.setBackgroundImage(UIImage(named: "shopCar_bg"), forState: UIControlState.Normal)
        
        //设置提示数字
        self.setupBadgeValueView();
        

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func setupBadgeValueView(){
        
        let badgeValueW: CGFloat = 20;
        let badgeValueX: CGFloat = self.frame.width - badgeValueW;
        let badgeValueY: CGFloat = 0;
        
        
        var badgeValue : ZFBadgeValueBtn = ZFBadgeValueBtn(frame: CGRectMake(badgeValueX, badgeValueY, badgeValueW, badgeValueWH));
        
        //字体
        badgeValue.titleLabel?.font = badgeValueFont;        //提示数字大小
        
        //设置按钮不能点击
//        badgeValue.enabled = false;
        
        self.addSubview(badgeValue);
        self.badgeValueView = badgeValue;
        
    }
    

}
