//
//  XQHomeHeaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQHomeHeaderView: UIView, UIScrollViewDelegate{
    
    weak var scrollView : UIScrollView!          //图片滚动器
    
    weak var pageControl : UIPageControl!        //图片滚提示器
    
    weak var textTipsLebel : UILabel!            //文本提示（tableView显示内容提示）
    
    weak var nameView : UILabel!                //名称

    var timer : NSTimer!                    //定时器
    
    var imageCount : Int!                   //图片数量
    
    let padding : CGFloat = 10              //view间隔
    
    var menuContent : Array<XQMenuContentModel>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        let scrollView : UIScrollView = self.getXQScrollView()
        self.scrollView = scrollView
        self.scrollView.delegate = self
        self.addSubview(scrollView)
        
        let nameView : UILabel = self.getXQNameView()
        self.addSubview(nameView)
        self.nameView = nameView
        
        let pageControl : UIPageControl = self.getXQPageControl()
        self.pageControl = pageControl
        self.addSubview(pageControl)
        
        self.addSubview(UIView.addLine(0, y: CGRectGetMaxY(self.scrollView.frame) + padding))
        
        let textTipsLebel : UILabel = self.getXQTextTipsLebel("菜单")
        self.textTipsLebel = textTipsLebel
        self.addSubview(textTipsLebel)
        
        self.addSubview(UIView.addLine(0, y: CGRectGetMaxY(self.textTipsLebel.frame)))
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 设置 UIScrollView
    func getXQScrollView() -> UIScrollView {
        
        let scrollW : CGFloat = self.frame.width
        let scrollH : CGFloat = 200
        let scrollY : CGFloat = 10
        let scrollX : CGFloat = 0
        
        return UIScrollView(frame: CGRectMake(scrollX, scrollY, scrollW, scrollH))
    }
    
    // 设置 UIPageControl
    func getXQPageControl() -> UIPageControl {
        
        let PageCW : CGFloat = 0
        let PageCH : CGFloat = 0
        let PageCY : CGFloat = self.scrollView.frame.height
        let PageCX : CGFloat = self.scrollView.frame.width - self.padding
        
        return UIPageControl(frame: CGRectMake(PageCX, PageCY, PageCW, PageCH))
    }
    
    //名称
    func getXQNameView() -> UILabel {
        let labelW : CGFloat = UIScreen.mainScreen().bounds.width
        let labelH : CGFloat = 20
        let labelX : CGFloat = 0
        let labelY : CGFloat = CGRectGetMaxY(self.scrollView.frame) - labelH
        
        let label : UILabel = UILabel()
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH)
        
        label.backgroundColor = UIColor.blackColor()
        
        label.alpha = 0.6
        
        label.textColor = UIColor.whiteColor()
        
        return label

    }
    
    //设置 uilabel
    func getXQTextTipsLebel(text : String) -> UILabel {
        let labelX : CGFloat = self.padding
        let labelY : CGFloat = CGRectGetMaxY(self.scrollView.frame) + padding
        let labelW : CGFloat = UIScreen.mainScreen().bounds.width
        let labelH : CGFloat = 50
        
        let label : UILabel = UILabel()
        
        label.text = text
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH)
        
        return label
    }
    
    
    // 设置要显示的信息
    func setImage(menuContent : Array<XQMenuContentModel>){
        
        self.menuContent = menuContent
        
        let imageY : CGFloat = 0
        let imageW : CGFloat = self.scrollView.frame.width
        let imageH : CGFloat = self.scrollView.frame.height
        self.imageCount = menuContent.count
        
        for index in 0 ..< self.imageCount + 2 {
            
            let  imageView = UIImageView()
            
            let imageX : CGFloat = CGFloat(index) * imageW
            
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH)
            
            let imageFlie : String?
            
            if (index == 0) {
                imageFlie = menuContent[imageCount - 1].menuContent_img
            } else if index == imageCount + 1 {
                imageFlie = menuContent[0].menuContent_img
            } else {
                imageFlie = menuContent[index - 1].menuContent_img
            }
            
            let image : UIImage!
            
            if imageFlie == nil {
                image = UIImage(named: "NoPicture")
            } else {
                image = UIImage(contentsOfFile: imageFlie!)
            }
        
            imageView.image = image
            
            self.scrollView.addSubview(imageView)
            
        }
        
        self.scrollView.contentSize = CGSizeMake(CGFloat(imageCount + 2) * imageW, imageH)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentOffset.x = imageW
        
        self.pageControl.frame.origin.x = pageControl.frame.origin.x - CGFloat(imageCount * 6)
        self.pageControl.numberOfPages = imageCount
        
        //增加定时器
        self.addTimer()
        
        
//        self.nameView.text = menuContent[0].menuContent_name!
        
    }
    
    //定时器回调方法
    func nextImage(){
        // 增加 pageControl 页码
        var page = self.pageControl.currentPage
        
        page++
        
        let offsetX : CGFloat = CGFloat(page+1) * self.scrollView.bounds.width
        let offset : CGPoint = CGPointMake(offsetX, 0)
        
        self.scrollView.setContentOffset(offset, animated: true )
        
    }
    
    ///滚动时 不停的调
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrllW = scrollView.bounds.width
        
        var page : Int = Int((scrollView.contentOffset.x + scrllW / 2) / scrllW) - 1
        
        if page == imageCount{
            page = 0
        } else if page == -1 {
            page = imageCount - 1
        }
        
        self.pageControl.currentPage = page
        
        if scrollView.contentOffset.x == scrollView.bounds.width * CGFloat(imageCount + 1) {
            self.scrollView.setContentOffset(CGPointMake(scrollView.bounds.width, 0), animated: false )
        }else if scrollView.contentOffset.x == 0 {
            self.scrollView.setContentOffset(CGPointMake(scrollView.bounds.width * CGFloat(imageCount) , 0), animated: false )
        }
        
        self.nameView.text = menuContent[page].menuContent_name!

        
    }
    
    ///开始拖 就调
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        //移除定时器
        self.removeTimer()
    }
    
    ///完成拖
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //增加定时器
        self.addTimer()
        
    }
    
    ///增加定时器
    func addTimer(){
        //用sched 不用调 fire() 每个2秒 调一次 nextImage
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "nextImage", userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    ///移除定时器
    func removeTimer(){
        timer.invalidate()
        timer = nil
    }

    
    
}
