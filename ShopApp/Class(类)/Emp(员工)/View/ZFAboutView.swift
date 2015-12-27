//
//  ZFAboutView.swift
//  ShopApp
//
//  Created by mac on 15/11/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFAboutViewDelegate : NSObjectProtocol {
    
    
    optional func aboutView(aboutView: ZFAboutView, closeButtonDidClick closeBtn : UIButton)
    
}

class ZFAboutView: UIView {

    ///透明背景
    weak var transparentBackground : UIButton!
    
    //显示显示关于内容窗口
    weak var showAboutView : UIView!
    
    //关闭窗口按钮
    weak var closeViewBtn : UIButton!
    
    //标题
    weak var aboutTitleView : UILabel!
    
    //学校
    weak var schoolView : UILabel!
    
    //班级
    weak var classView : UILabel!
    
    //开发人员
    weak var properView : UILabel!
    
    weak var delegate : ZFAboutViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //初始化 －》 透明背景
        self.setupTransparentBackground();
        
        //初始化 －》 显示关于内容窗口
        self.setupAboutView();
        
        //初始化 －》 关于名字
        self.setupAboutTitleView();
        
        //设置关于名字背景图片
        self.setupBackgroundView()
        
        //初始化 －》 删除按钮
        self.setupCloseBtn();
        
        //设置学校名称
        self.setupShoeSchoolView();
        
        //设置班级
        self.setupClassView();
        
        //设置开发人员
        self.setupProperView();
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    //初始化 －》 显示关于内容窗口
    func setupAboutView(){
        let showAboutViewW : CGFloat = 300;
        let showAboutViewH : CGFloat = 230;
        let showAboutViewX : CGFloat = (self.frame.width - showAboutViewW) / 2;
        let showAboutViewY : CGFloat = (self.frame.height - showAboutViewH) / 2;
        let showAboutView : UIView = UIView(frame: CGRectMake(showAboutViewX, showAboutViewY, showAboutViewW, showAboutViewH));
        showAboutView.layer.cornerRadius = 10;
        showAboutView.layer.masksToBounds = true;
        showAboutView.backgroundColor = UIColor.whiteColor();
        self.addSubview(showAboutView);
        self.showAboutView = showAboutView;
    }
    
    //初始化 －》 删除按钮
    func setupCloseBtn(){
        let closeBtnWH : CGFloat = 30;
        let closeBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        closeBtn.frame = CGRectMake(self.showAboutView.frame.size.width - closeBtnWH - PADDING, PADDING, closeBtnWH, closeBtnWH)
        closeBtn.addTarget(self, action: "closeBtnDidClick", forControlEvents: UIControlEvents.TouchDown)
        closeBtn.setImage(UIImage(named: "close_btn_bg"), forState: UIControlState.Normal)
        self.showAboutView.addSubview(closeBtn);
        self.closeViewBtn = closeBtn;
        
    }
    
    //关闭按钮被点击
    func closeBtnDidClick(){
        
        self.removeFromSuperview();
        
        if self.delegate != nil && self.delegate.respondsToSelector("aboutView:closeButtonDidClick:"){
            self.delegate.aboutView!(self, closeButtonDidClick: self.closeViewBtn)
        }
        
        
    }
    
    //初始化 －》 关于名字
    func setupAboutTitleView(){
        let aboutTitleViewW : CGFloat = self.showAboutView.frame.size.width;
        let aboutTitleViewH : CGFloat = 44;

        let aboutTitleView : UILabel = UILabel(frame: CGRectMake(0, 0, aboutTitleViewW, aboutTitleViewH))
        aboutTitleView.textAlignment = NSTextAlignment.Center;
        aboutTitleView.text = "关于"
        showAboutView.addSubview(aboutTitleView);
        self.aboutTitleView = aboutTitleView;
    }
    
    //设置关于名字背景图片
    func setupBackgroundView(){
        let backgroundView : UIImageView = UIImageView(frame: self.aboutTitleView.frame);
        backgroundView.frame.size.width =  backgroundView.frame.size.width - 25;
        backgroundView.image = UIImage.resizableImage(name: "buddy_header_bg");
        self.showAboutView.insertSubview(backgroundView, belowSubview: self.aboutTitleView)
    }
    
    //设置学校名称
    func setupShoeSchoolView(){
        
        let schoolViewX : CGFloat = 30;
        let schoolViewY : CGFloat = CGRectGetMaxY(self.aboutTitleView.frame) + PADDING;
        let schoolViewW : CGFloat = 250;
        let schoolViewH : CGFloat = 44;
        
        let schoolView : UILabel = UILabel(frame: CGRectMake(schoolViewX, schoolViewY, schoolViewW, schoolViewH));
        schoolView.text = "学   校：南宁职业技术学院";
        self.showAboutView.addSubview(schoolView);
        self.schoolView = schoolView;
    }
    
    //设置班级
    func setupClassView(){
        let classViewX : CGFloat = CGRectGetMinX(self.schoolView.frame);
        let classViewY : CGFloat = CGRectGetMaxY(self.schoolView.frame) + PADDING;
        let classViewW : CGFloat = self.schoolView.frame.size.width;
        let classViewH : CGFloat = self.schoolView.frame.size.height;
        
        let classView : UILabel = UILabel(frame: CGRectMake(classViewX, classViewY, classViewW, classViewH));
        classView.text = "班   级：13软件2班";
        self.showAboutView.addSubview(classView);
        self.classView = classView;
    }
    
    //设置开发人员
    func setupProperView(){
        let  properViewX : CGFloat = CGRectGetMinX(self.schoolView.frame);
        let  properViewY : CGFloat = CGRectGetMaxY(self.classView.frame) + PADDING;
        let  properViewW : CGFloat = self.schoolView.frame.size.width;
        let  properViewH : CGFloat = self.schoolView.frame.size.height;
        
        let properView : UILabel = UILabel(frame: CGRectMake(properViewX, properViewY, properViewW, properViewH))
        properView.text = "开发者：陆祖富、甘信强";
        self.showAboutView.addSubview(properView);
        self.properView = properView;
    }
    
    deinit {
        println("ZFAboutView deinit")
    }

}
