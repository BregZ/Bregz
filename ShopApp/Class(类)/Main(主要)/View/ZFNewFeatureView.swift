//
//  ZFNewFeatureView.swift
//  ShopApp
//
//  Created by mac on 15/11/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFNewFeatureView: UIView,UIScrollViewDelegate {
    
    ///设置图片滚动view
    weak var imageScrollView : UIScrollView!
    
    ///提示图片器
    weak var pageView : UIPageControl!
    
    ///开始体验按钮
    weak var statrExperienceBtn : UIButton!
    
    var _imagesM : Array<String>!
    
    var imagesM : Array<String> {
        set{
            self._imagesM = newValue;
            self.imageScrollView.contentSize = CGSizeMake(CGFloat(newValue.count) * self.frame.size.width, self.frame.size.height);
            
            self.setImage(newValue);
        }
        
        get{
            return self._imagesM
        }
    }
    

    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 222/255, green: 223/255, blue: 226/255, alpha: 1);
        
        //设置图片滚动view
        self.setupImageScrollView();
        
        //设置提示图片器
        self.setupPageVeiw();
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置图片滚动view
    func setupImageScrollView(){
        
        let imageScrollView  : UIScrollView = UIScrollView(frame: self.frame);
        imageScrollView.pagingEnabled = true;
        imageScrollView.showsHorizontalScrollIndicator = false;
        imageScrollView.delegate = self;
        self.addSubview(imageScrollView)
        
        self.imageScrollView = imageScrollView;
        
    }
    
    //设置提示图片器
    func setupPageVeiw(){
        
        let pageViewW : CGFloat = 100;
        let pageViewH : CGFloat = 30;
        let pageViewX : CGFloat = (self.frame.size.width - pageViewW) * 0.5;
        let pageViewY : CGFloat = self.frame.size.height - pageViewH - 20;
        
        let pageView : UIPageControl = UIPageControl(frame: CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH));
        pageView.pageIndicatorTintColor = UIColor.lightGrayColor();
        pageView.currentPageIndicatorTintColor = UIColor.redColor();
        
        self.addSubview(pageView);
        self.pageView = pageView;
    }
    
    //设置开始体验按钮
    func statrExperienceBtn(x : CGFloat){
        
        let statrExperienceBtnW : CGFloat = 150;
        let statrExperienceBtnH : CGFloat = 44;
        let statrExperienceBtnX : CGFloat = (self.imageScrollView.frame.size.width - statrExperienceBtnW) * 0.5 + x;
        let statrExperienceBtnY : CGFloat = self.imageScrollView.frame.size.height - statrExperienceBtnH - 230;
        
        let statrExperienceBtn : UIButton = UIButton(frame: CGRectMake(statrExperienceBtnX, statrExperienceBtnY, statrExperienceBtnW, statrExperienceBtnH));
        statrExperienceBtn.setTitle("开始体验", forState: UIControlState.Normal)
        statrExperienceBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        statrExperienceBtn.setBackgroundImage(UIImage.resizableImage(name: "newFeatureShopStartBtn"), forState: UIControlState.Normal)
        
        self.imageScrollView.addSubview(statrExperienceBtn);
        
        self.statrExperienceBtn = statrExperienceBtn;
    }
    
    //设置图片
    func setImage(imagesM : Array<String>){
        
        let imageY : CGFloat = 0;
        let imageW : CGFloat = self.imageScrollView.frame.width;
        let imageH : CGFloat = self.imageScrollView.frame.height;
        
        for index in 0 ..< imagesM.count {
            
            let imageX : CGFloat = CGFloat(index) * imageW;
            
            let imageView : UIImageView = UIImageView(frame:CGRectMake(imageX, imageY, imageW, imageH));
            
            imageView.image = UIImage(named: imagesM[index]);
            
            self.imageScrollView.addSubview(imageView);
            
            if index == imagesM.count - 1 {
                //设置开始体验按钮
                self.statrExperienceBtn(imageX);
            }
            
        }
        
        self.pageView.numberOfPages = imagesM.count;
        
    }
    
    //scrollView滚动时调用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let imageW : Int = Int(self.imageScrollView.frame.size.width);
        
        let page : Int = (Int(self.imageScrollView.contentOffset.x) +  imageW / 2 ) / imageW
        
        self.pageView.currentPage = page;
        
    }
    
    //添加点击事件
    func statrExperienceBtnAddTarget(target: AnyObject?, action: Selector) {
        self.statrExperienceBtn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchDown);
    }

}
