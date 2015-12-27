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
    class func addSeparator(x : CGFloat , y : CGFloat) -> UIView {
        
        let lineX : CGFloat = x;
        let lineY : CGFloat = y;
        let lineW : CGFloat = UIScreen.mainScreen().bounds.width - 20;
        let lineH : CGFloat = 1;
        
        let lineView : UIView = UIView()
        
        lineView.frame = CGRectMake(lineX, lineY, lineW, lineH)
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        lineView.alpha = 0.2
        
        return lineView
    }
    
    //添加提示栏
    class func ZFAlertView(frame: CGRect, title: String, titleColor: UIColor,titleFont : UIFont) -> UIView{
        
        let alertView : UIView = UIView(frame: frame);
        alertView.backgroundColor = THEME_MIN_COLOR;
        
        let textTipBackgroundImageSise : CGSize =  (title as NSString).sizeWithText(font: titleFont, maxSize: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)));
        let textTipBackgroundImageW : CGFloat = textTipBackgroundImageSise.width + 50;
        let textTipBackgroundImage : UIImageView = UIImageView(frame: CGRectMake(0, 0, textTipBackgroundImageW, frame.size.height));
        textTipBackgroundImage.image = UIImage.resizableImage(name:"title_bg");
        alertView.addSubview(textTipBackgroundImage);
        
        let textTipsLebel : UILabel = UILabel(frame: CGRectMake(10, 0, frame.size.width, frame.size.height));
        
        textTipsLebel.textColor = UIColor.whiteColor();
        textTipsLebel.font = titleFont;
        textTipsLebel.text = title;
        alertView.addSubview(textTipsLebel);
        
        return alertView;
    }
    
    //设置模糊
    func insertBlurView (style: UIBlurEffectStyle) {
        
        var blurEffect = UIBlurEffect(style: style);
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRectMake( self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.frame.size.height);
        self.insertSubview(blurEffectView, atIndex: 0);
    }
    
    //删除模糊
    func removeBlurView(){
        
        for view in self.subviews {
            if view.isKindOfClass(UIVisualEffectView) {
                view.removeFromSuperview();
            }
        }
        
    }
}