//
//  ZFHomeHeaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFHomeHeaderView: UIView, UIScrollViewDelegate{
    
    weak var scrollView : UIScrollView!;          //图片滚动器
    
    weak var pageControl : UIPageControl!;        //图片滚提示器
    
    weak var nameView : UILabel!;                //名称

    weak var timer : NSTimer!;                   //定时器
    
    var imageCount : Int!;                       //图片数量
    
    var cultureModels : Array<ZFCultureModel>!     //数据
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        // 设置 UIScrollView
        self.setupScrollView();
        
        //设置名称
        self.setupNameView();
        
        // 设置 UIPageControl
        self.setupPageControl();
        
        //设置提示栏
        self.setupTextTipsView();
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 设置 UIScrollView
    func setupScrollView() {
        
        let scrollW : CGFloat = self.frame.width;
        let scrollH : CGFloat = 210;
        let scrollY : CGFloat = 0;
        let scrollX : CGFloat = 0;
        
        let scrollView : UIScrollView = UIScrollView(frame: CGRectMake(scrollX, scrollY, scrollW, scrollH));
        self.addSubview(scrollView);
        
        self.scrollView = scrollView;
    }
    
    // 设置 UIPageControl
    func setupPageControl() {
        
        let PageCW : CGFloat = 0;
        let PageCH : CGFloat = 0;
        let PageCY : CGFloat = self.scrollView.frame.height - PADDING;
        let PageCX : CGFloat = self.scrollView.frame.width - PADDING;
        
        let pageControl : UIPageControl = UIPageControl(frame: CGRectMake(PageCX, PageCY, PageCW, PageCH));
        pageControl.hidden = true;
        self.addSubview(pageControl);
        
        self.pageControl = pageControl;
        
    }
    
    //设置名称
    func setupNameView() {
        
        let labelW : CGFloat = UIScreen.mainScreen().bounds.width;
        let labelH : CGFloat = 20
        let labelX : CGFloat = 0
        let labelY : CGFloat = CGRectGetMaxY(self.scrollView.frame) - labelH;
        
        let label : UILabel = UILabel();
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        label.backgroundColor = UIColor.blackColor();
        
        label.alpha = 0.6;
        
        label.textColor = UIColor.whiteColor();
    
        self.addSubview(label);
        self.nameView = label;
        
    }
    
    //设置提示栏
    func setupTextTipsView(){
        
        let textTipsView : UIView = UIView.ZFAlertView(CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) + PADDING, self.frame.size.width, 50), title: "菜单介绍",titleColor: TITLE_BIG_COLOR,titleFont: UIFont.boldSystemFontOfSize(24));
        self.addSubview(textTipsView);
        
    }
    
    
    
    // 设置要显示的信息
    func setImage(cultureModels : Array<ZFCultureModel>){
        
        //删除这个view中全部UIImageView
        self.removeInImageView();
        
        self.cultureModels = cultureModels;
        
        let imageY : CGFloat = 0;
        let imageW : CGFloat = self.scrollView.frame.width;
        let imageH : CGFloat = self.scrollView.frame.height;
        
//            var imageFlie : String = "\(FILE_STRING)/";
        var imageFlie : String = "http://\(ZFAsynHttp.IP)/";
        
        if cultureModels.count == 1 {
            
            //隐藏提示
            pageControl.hidden = true;
            
            //如果只有一条数据
            self.evenImage(imageY, imageW: imageW, imageH: imageH, imageFlie: imageFlie);
            
            
        }else {
            
            //显示提示
            pageControl.hidden = false;
            
//          //获取显示数据长度
            self.imageCount = cultureModels.count;
            
            //含多张图片 多与2张
            self.moreImage(imageY, imageW: imageW, imageH: imageH, imageFlie: imageFlie);
            
            self.pageControl.frame.origin.x = self.frame.size.width - CGFloat(imageCount * 6) - PADDING;
            self.pageControl.numberOfPages = imageCount;
            
            //增加定时器
            if self.timer == nil {
                
                self.addTimer();
            }
        }
        
        
        self.scrollView.pagingEnabled = true;
        self.scrollView.showsHorizontalScrollIndicator = false;

        

        
    }
    
    //如果只有一条数据
    func evenImage(imageY : CGFloat, imageW : CGFloat, imageH : CGFloat, imageFlie : String) {
        
        //清空scrollView协议
        self.scrollView.delegate = nil;
        
        let  imageView = UIImageView();
        
        imageView.frame = CGRectMake(0, imageY, imageW, imageH);
        
        //设置图片
        self.setupImageWithHTTP(imageFlie, addimageFlie: self.cultureModels[0].culture_image,imageView: imageView);
        
        self.scrollView.addSubview(imageView);
        
        self.scrollView.contentSize = CGSizeMake(imageW, imageH);
        
        //设置标题名称
        self.setupNameViewTest(cultureModels[0]);
        
    }
    
    //含多张图片 多与2张
    func moreImage(imageY : CGFloat, imageW : CGFloat, imageH : CGFloat, var imageFlie : String){
        
        //设置scrollView协议
        self.scrollView.delegate = self;
        
        for index in 0 ..< self.imageCount + 2 {
            
            let  imageView = UIImageView();
            
            let imageX : CGFloat = CGFloat(index) * imageW;
            
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            
            if (index == 0) {
                
                //通过uil拿到网络图片
                self.setupImageWithHTTP(imageFlie, addimageFlie: self.cultureModels[imageCount - 1].culture_image,imageView: imageView);
                
            } else if index == imageCount + 1 {
                
                //通过uil拿到网络图片
                self.setupImageWithHTTP(imageFlie, addimageFlie: self.cultureModels[0].culture_image,imageView: imageView);
            } else {
                
                //通过uil拿到网络图片
                self.setupImageWithHTTP(imageFlie, addimageFlie: self.cultureModels[index-1].culture_image,imageView: imageView);
            }

            
            self.scrollView.addSubview(imageView);
            self.scrollView.contentSize = CGSizeMake(CGFloat(imageCount + 2) * imageW, imageH);
            self.scrollView.contentOffset.x = imageW;
            
        }
    }
    
    //通过uil拿到网络图片
    func setupImageWithHTTP(imageFlie : String, addimageFlie : String?, imageView : UIImageView){
        
        if addimageFlie != nil {
            
            let file : String = imageFlie + addimageFlie!;
            
            //通过uil拿到网络图片
//            let data : NSData? = NSData(contentsOfURL: NSURL(string: imageFlie)!);
//            
//            if data != nil {
//                image = UIImage(data: data!);
//            }else {
//                image = UIImage(named: "NoPicture");
//            }
            
            let url : NSURL = NSURL(string: file)!;
            
            imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "NoPicture"));
            
        }else {
            imageView.image = UIImage(named: "NoPicture");
        }
        
    }
    
    //定时器回调方法
    func nextImage(){
        // 增加 pageControl 页码
        var page = self.pageControl.currentPage;
        
        page++;
        
        let offsetX : CGFloat = CGFloat(page+1) * self.scrollView.bounds.width;
        let offset : CGPoint = CGPointMake(offsetX, 0);
        
        self.scrollView.setContentOffset(offset, animated: true );
        
    }
    
    ///滚动时 不停的调
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrllW = scrollView.bounds.width;
        
        var page : Int = Int((scrollView.contentOffset.x + scrllW / 2) / scrllW) - 1;
        
        if page == imageCount{
            page = 0
        } else if page == -1 {
            page = imageCount - 1;
        }
        
        self.pageControl.currentPage = page;
        
        if scrollView.contentOffset.x == scrollView.bounds.width * CGFloat(imageCount + 1) {
            self.scrollView.setContentOffset(CGPointMake(scrollView.bounds.width, 0), animated: false );
        }else if scrollView.contentOffset.x == 0 {
            self.scrollView.setContentOffset(CGPointMake(scrollView.bounds.width * CGFloat(imageCount) , 0), animated: false );
        }
        
        //设置标题名称
        if self.cultureModels.count > page {
            
            self.setupNameViewTest(self.cultureModels[page]);
            
        }
      
        
    }
    
    //设置标题名称
    func setupNameViewTest(cultureModel : ZFCultureModel){
        if (cultureModel.culture_name != nil) {
            //显示标题
            self.nameView.text = cultureModel.culture_name!;
        }else {
            self.nameView.text = "无标题";
        }
    }
    
    ///开始拖 就调
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        //移除定时器
        self.removeTimer();
    }
    
    ///完成拖
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //增加定时器
        self.addTimer();
        
    }
    
    ///增加定时器
    func addTimer(){
        
        if  self.timer == nil && self.cultureModels != nil && self.cultureModels.count > 1 {
            
            //用sched 不用调 fire() 每个2秒 调一次 nextImage
            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextImage", userInfo: nil, repeats: true);
            
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes);
            
        }

    }
    
    ///移除定时器
    func removeTimer(){
        
        if  self.timer != nil && self.cultureModels != nil && self.cultureModels.count > 1 {
        
            timer.invalidate();
            timer = nil;
        }
        
    }
    
    //删除这个view中全部UIImageView
    func removeInImageView(){
        
        for view in self.scrollView.subviews {
            if view.isKindOfClass(UIImageView){
                view.removeFromSuperview();
            }
        }
    }

    deinit {
        println("ZFHomeHeaderView 被销毁了");
    }
    
}
