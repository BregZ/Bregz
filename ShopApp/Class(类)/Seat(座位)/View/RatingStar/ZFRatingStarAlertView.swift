//
//  ZFRatingStarAlertView.swift
//  ShopApp
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFRatingStarAlertViewDelegate : NSObjectProtocol {
    
    optional func ratingStarAlertView(ratingStarAlertView : ZFRatingStarAlertView, btnDidClick index : Int)
    
}

class ZFRatingStarAlertView: UIView {
 
    var title: String {
        set {
            self.titleView.text = newValue
        }
        get {
            return self.titleView.text != nil ? self.titleView.text! : ""
        }
    }
    
    var messageView: UIView!                //
    
    weak var titleView : UILabel!
    
    weak var ratingStarView : ZFRatingStarView!
    
    weak var delegate : ZFRatingStarAlertViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, 0, 250, 132))
        
        self.layer.cornerRadius = 5
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.setTitleView()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setRatingStarView()
        
        self.setBtnView()
    }
    
    func setTitleView(){
        let titleX : CGFloat = 0;
        let titleY : CGFloat = 0;
        let titleW : CGFloat = self.frame.width;
        let titleH : CGFloat = 44;
        
        let titleView = UILabel(frame: CGRectMake(titleX, titleY, titleW, titleH))
        
        titleView.textAlignment = NSTextAlignment.Center
        titleView.font = UIFont.boldSystemFontOfSize(17)
        
        self.addSubview(titleView)
        
        self.titleView = titleView
    }
    
    
    func setRatingStarView(){
        
        let ratingStarW : CGFloat = 200;
        let ratingStarH : CGFloat = 44;
        let ratingStarX : CGFloat = (self.frame.size.width - ratingStarW) * 0.5;
        let ratingStarY : CGFloat = CGRectGetMaxY(self.titleView.frame);
        
        let ratingStarView = ZFRatingStarView(frame: CGRectMake(ratingStarX, ratingStarY, ratingStarW, ratingStarH), numberOfStars: 5)
        ratingStarView.hasAnimation = true;
        ratingStarView.delegate = UIViewController.viewControllerWithView(self) as! ZFRatingStarViewController
        
        self.addSubview(ratingStarView)
        
        self.ratingStarView = ratingStarView
  
    }
    
    func setBtnView(){
        let btnX : CGFloat = 0;
        let btnY : CGFloat = CGRectGetMaxY(self.ratingStarView.frame);
        let btnW : CGFloat = self.frame.size.width * 0.5 ;
        let btnH : CGFloat = 44;
        let borderWidth : CGFloat = 1
        let borderColor : UIColor = UIColor.grayColor()
        
        let cancelBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        cancelBtn.frame = CGRectMake(btnX, btnY, btnW, btnH)
        cancelBtn.setTitle("取消", forState: UIControlState.Normal)
        self.addSubview(cancelBtn)
        
        let determineBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        determineBtn.frame = CGRectMake(btnW, btnY, btnW, btnH)
        determineBtn.setTitle("确定", forState: UIControlState.Normal)
        self.addSubview(determineBtn)
        
    }
    
    func btnClick(btn : UIButton){
        var index : Int!
        if btn.titleLabel?.text == "取消" {
            index = 0;
        }else if btn.titleLabel?.text == "确定"{
            index = 1;
        }
        
        
        if self.delegate != nil && self.delegate.respondsToSelector(Selector("ratingStarAlertView:btnDidClick")) {
            self.delegate.ratingStarAlertView!(self, btnDidClick: index)
        }
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
