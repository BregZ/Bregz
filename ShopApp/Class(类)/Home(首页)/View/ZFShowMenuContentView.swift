//
//  ZFShowMenuContentView.swift
//  ShopApp
//
//  Created by mac on 15/11/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFShowMenuContentViewDelegate : NSObjectProtocol {
    
    optional func showMenuContentView(showMenuContentView : ZFShowMenuContentView, closeBtnDidClick closeBtn : UIButton)
}

class ZFShowMenuContentView: UIView {
    
    //透明背景
    weak var transparentBackground : UIButton!
    
    //显示菜单内容窗口
    weak var showMenuContentView : UIView!
    
    //菜单内容名字
    weak var menuContentNameView : UILabel!
    
    //菜单内容图片
    weak var menuContentImageView : UIImageView!
    
    //初始化 －》 菜单内容价格提示文字
    weak var menuContentPriceTitle : UILabel!
    
    //菜单内容价格
    weak var menuContentPriceView : UILabel!
    
    //关闭窗口按钮
    weak var closeViewBtn : UIButton!
    
    //菜单内容介绍标题
    weak var menuContentIntroduceTitle : UILabel!
    
    //菜单内容介绍
    weak var menuContentIntroduceView : UILabel!
    
    weak var delegate : ZFShowMenuContentViewDelegate!
    
    //字体大小
    let textFont : UIFont = UIFont.systemFontOfSize(13);
    
    //菜单内容介绍宽度
    let menuContentIntroduceW : CGFloat = 200;
    
    var _menuContent : ZFMenuContentModel?
    
    var menuContent : ZFMenuContentModel {
        set {
            self._menuContent = newValue
            
            self.menuContentNameView.text = self.menuContent.menuContent_name!
            self.menuContentPriceView.text = "￥\(self.menuContent.menuContent_price!)"
            
            if self.menuContent.menuContent_introduce != nil {
                self.menuContentIntroduceView.text = self.menuContent.menuContent_introduce!
                
                //设置显示菜单信息窗口高度
                self.setupViewHeight(self.menuContent.menuContent_introduce!)
                
            }else{
                
            }
            
            let imageURl = self.menuContent.menuContent_img
            
            if  imageURl != "Null" {
                
                let url : NSURL = NSURL(string: "http://\(ZFAsynHttp.IP)/\(imageURl!)")!;
                
                self.menuContentImageView.sd_setImageWithURL(url);
            }
            
        }
        
        get {
            return self._menuContent!
        }
    }

    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化 －》 透明背景
        self.setupTransparentBackground();
        
        //初始化 －》 显示菜单内容窗口
        self.setupShowMenuContentView();
        
        //初始化 －》 菜单内容名字
        self.setupMenuContentNameView();
        
        //初始化 －》 删除按钮
        self.setupCloseBtn();
        
        //初始化 －》 菜单内容图片
        self.setupMenuContentImage();
        
        //初始化 －》 菜单内容价格提示文字
        self.setupMenuContentPriceTitle();
        
        //初始化 －》 菜单内容价格
        self.setupMenuContentPrice();
        
        //初始化 －》 菜单内容介绍提示文字
        self.setupMenuContentIntroduceTitle();
        
        //初始化 －》 菜单内容介绍
        self.setupIenuContentIntroduce();
        
    }
    
    //初始化 －》 透明背景
    func setupTransparentBackground(){
        let transparentBackground : UIButton = UIButton(frame: frame);
        transparentBackground.backgroundColor = UIColor.blackColor();
        //透明度
        transparentBackground.alpha = 0.8;
        self.addSubview(transparentBackground);
        self.transparentBackground = transparentBackground;
    }
    
    //初始化 －》 显示菜单内容窗口
    func setupShowMenuContentView(){
        let showMenuContentViewW : CGFloat = 300;
        let showMenuContentView : UIView = UIView();
        showMenuContentView.frame.size.width = showMenuContentViewW;
        showMenuContentView.frame.origin.x = (frame.size.width - showMenuContentViewW) * 0.5;
        showMenuContentView.layer.cornerRadius = 10;
        showMenuContentView.backgroundColor = UIColor.whiteColor()
        self.addSubview(showMenuContentView);
        self.showMenuContentView = showMenuContentView;
    }
    
    //初始化 －》 菜单内容名字
    func setupMenuContentNameView(){
        let menuContentNameW : CGFloat = self.showMenuContentView.frame.size.width;
        let menuContentNameH : CGFloat = 44;
        
        let menuContentName : UILabel = UILabel(frame: CGRectMake(0, 0, menuContentNameW, menuContentNameH))
        menuContentName.textAlignment = NSTextAlignment.Center;
        showMenuContentView.addSubview(menuContentName);
        self.menuContentNameView = menuContentName;
    }
    
    //初始化 －》 删除按钮
    func setupCloseBtn(){
        let closeBtnWH : CGFloat = 30;
        let closeBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        closeBtn.frame = CGRectMake(showMenuContentView.frame.size.width - closeBtnWH - PADDING, PADDING, closeBtnWH, closeBtnWH)
        closeBtn.addTarget(self, action: "closeBtnDidClick", forControlEvents: UIControlEvents.TouchDown)
        closeBtn.setImage(UIImage(named: "close_btn_bg"), forState: UIControlState.Normal)
        showMenuContentView.addSubview(closeBtn);
        self.closeViewBtn = closeBtn;

    }
    
    //初始化 －》 菜单内容图片
    func setupMenuContentImage(){
        
        let menuContentImageX : CGFloat = 0;
        let menuContentImageY : CGFloat = CGRectGetMaxY(self.menuContentNameView.frame);
        let menuContentImageW : CGFloat = self.showMenuContentView.frame.size.width;
        let menuContentImageH : CGFloat = 170;
        
        let menuContentImage : UIImageView = UIImageView(frame: CGRectMake(menuContentImageX, menuContentImageY, menuContentImageW, menuContentImageH));
        showMenuContentView.addSubview(menuContentImage);
        self.menuContentImageView = menuContentImage;

    }
    
    
    //初始化 －》 菜单内容价格提示文字
    func setupMenuContentPriceTitle(){
        let menuContentPriceTitleY : CGFloat = CGRectGetMaxY(self.menuContentImageView.frame) + PADDING;
        let menuContentPriceTitleW : CGFloat = 30;
        let menuContentPriceTitleH : CGFloat = 20;
        let menuContentPriceTitleX : CGFloat = 20;
        
        let menuContentPriceTitle : UILabel = UILabel(frame: CGRectMake(menuContentPriceTitleX, menuContentPriceTitleY, menuContentPriceTitleW, menuContentPriceTitleH))
        menuContentPriceTitle.text = "价格: ";
        menuContentPriceTitle.font = self.textFont;
        showMenuContentView.addSubview(menuContentPriceTitle);
        self.menuContentPriceTitle = menuContentPriceTitle
    }
    
    //初始化 －》 菜单内容价格
    func setupMenuContentPrice(){
        
        let menuContentPriceX : CGFloat = CGRectGetMaxX(self.menuContentPriceTitle.frame) + PADDING;
        let menuContentPriceY : CGFloat = self.menuContentPriceTitle.frame.origin.y;
        let menuContentPriceW : CGFloat = 150;
        let menuContentPriceH : CGFloat = self.menuContentPriceTitle.frame.size.height;
        
        let menuContentPrice : UILabel = UILabel(frame: CGRectMake(menuContentPriceX, menuContentPriceY, menuContentPriceW, menuContentPriceH));
        menuContentPrice.textColor = UIColor.redColor();
        menuContentPrice.font = self.textFont;
        showMenuContentView.addSubview(menuContentPrice);
        self.menuContentPriceView = menuContentPrice;
    }
    
    
    //初始化 －》 菜单内容介绍提示文字
    func setupMenuContentIntroduceTitle(){
        let menuContentIntroduceTitleY : CGFloat = CGRectGetMaxY(menuContentPriceTitle.frame) + PADDING;
        let menuContentIntroduceTitleW : CGFloat = self.menuContentPriceTitle.frame.size.width;
        let menuContentIntroduceTitleH : CGFloat = self.menuContentPriceTitle.frame.size.height;
        let menuContentIntroduceTitleX : CGFloat = self.menuContentPriceTitle.frame.origin.x;
        
        let menuContentIntroduceTitle : UILabel = UILabel(frame: CGRectMake(menuContentIntroduceTitleX, menuContentIntroduceTitleY, menuContentIntroduceTitleW, menuContentIntroduceTitleH));
        menuContentIntroduceTitle.text = "介绍: ";
        menuContentIntroduceTitle.font = self.textFont;
        showMenuContentView.addSubview(menuContentIntroduceTitle);
        self.menuContentIntroduceTitle = menuContentIntroduceTitle;
    }
    
    //初始化 －》 菜单内容介绍
    func setupIenuContentIntroduce(){
        
        let menuContentIntroduceX : CGFloat = CGRectGetMaxX(self.menuContentIntroduceTitle.frame) + PADDING;
        let menuContentIntroduceY : CGFloat = self.menuContentIntroduceTitle.frame.origin.y;
        let menuContentIntroduceH : CGFloat = 0;
        
        let menuContentIntroduce : UILabel = UILabel(frame: CGRectMake( menuContentIntroduceX, menuContentIntroduceY, self.menuContentIntroduceW,menuContentIntroduceH));
        menuContentIntroduce.textColor = UIColor.lightGrayColor();
        menuContentIntroduce.font = self.textFont;
        menuContentIntroduce.numberOfLines = 0;
        showMenuContentView.addSubview(menuContentIntroduce);
        self.menuContentIntroduceView = menuContentIntroduce;
    }
    
    //设置显示菜单信息窗口高度
    func setupViewHeight(introduce : NSString){
        let introduce : NSString = introduce;
        let textSize : CGSize =  introduce.sizeWithText(font: self.textFont, maxSize: CGSize(width: self.menuContentIntroduceW, height: CGFloat(MAXFLOAT)));
        
        self.menuContentIntroduceView.frame.size.height = textSize.height;
        
        self.showMenuContentView.frame.size.height = CGRectGetMaxY(self.menuContentIntroduceView.frame) + PADDING;
        
        self.showMenuContentView.frame.origin.y = (self.frame.height - self.showMenuContentView.frame.size.height) * 0.5;
    }
    
    //关闭按钮被点击
    func closeBtnDidClick(){
        //将这个窗口从父控件中删除
        self.removeFromSuperview();
        
        if self.delegate != nil && self.delegate.respondsToSelector(Selector("showMenuContentView:closeBtnDidClick:")){
            self.delegate.showMenuContentView!(self, closeBtnDidClick: self.closeViewBtn);
        }
    }
    
    deinit {
        println("ZFShowMenuContentView 被销毁");
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
