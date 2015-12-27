//
//  ZFLoadingView.swift
//  ShopApp
//
//  Created by mac on 15/11/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFLoadingView: UIView {
    
    weak var doubleBounce : ZFCDoubleBounceActivityIndicatorView!

    override init(frame : CGRect){
        super.init(frame: frame);
        
        //初始化
        self.initView();
        
        //设置加载动画
        self.setupDoubleBounce();
    }
    
    //初始化
    func initView(){
        
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5);
        
        self.hidden = true;
    }
    
    //设置加载动画
    func setupDoubleBounce(){
        
        var doubleBounce : ZFCDoubleBounceActivityIndicatorView = ZFCDoubleBounceActivityIndicatorView()
        doubleBounce.center = CGPointMake(WINDOW_WIDTH*0.5, self.frame.size.height * 0.5);
        doubleBounce.bounceColor = UIColor.redColor();
        self.addSubview(doubleBounce);
        
        self.doubleBounce = doubleBounce;
    }
    
    //开始加载
    func statrLoad(){
        self.hidden = false;
        self.doubleBounce.startAnimating();
    }
    
    //结束加载
    func stopLoad(){
        self.hidden = true;
        self.doubleBounce.stopAnimating();
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
