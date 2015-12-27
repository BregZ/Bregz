//
//  ZFNavTitleView.swift
//  ShopApp
//
//  Created by mac on 15/11/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFNavTitleView: UIView {

    weak var reloadView : UIActivityIndicatorView!
    
    weak var titleView : UILabel!
    
    var _title : String!
    
    var title : String{
        set{
            self._title = newValue;

            self.titleView.text = newValue;
            
            self.frame.size.width = newValue.sizeWithText(font: UIFont.boldSystemFontOfSize(17), maxSize: CGSizeMake(CGFloat(MAXFLOAT), self.frame.height)).width + self.frame.size.height * 2;
        }
        get{
            return _title;
        }
    }
    
    override init(frame : CGRect){
        super.init(frame: frame)
        //设置转轮
        self.setupReloadView();
        
        //设置标题
        self.setupTitleView();
        
    }
    
    //设置转轮
    func setupReloadView(){
        
        let reloadViewWH : CGFloat = self.frame.size.height
        
        let reloadView : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, reloadViewWH, reloadViewWH));
        reloadView.color = UIColor.whiteColor();
        reloadView.hidden = false;
        self.addSubview(reloadView);
        self.reloadView = reloadView;
    }
    
    //设置标题
    func setupTitleView(){
        let titleView : UILabel = UILabel();
        titleView.textAlignment = NSTextAlignment.Center;
        titleView.frame.origin = CGPoint(x: CGRectGetMaxX(self.reloadView.frame), y: 0);
        titleView.frame.size.height = self.reloadView.frame.size.height;
        titleView.textColor = UIColor.whiteColor();
        self.addSubview(titleView);
        self.titleView = titleView;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        if titleView != nil {
            
            self.titleView.frame.size.width = self.frame.size.width - 44 * 2;
        }
    }
    
    //开始刷新
    func titleBeginRefreshing(){
        self.reloadView.hidden = true;
        self.reloadView.startAnimating();
    }
    
    //停止刷新
    func titleEndRefreshing(){
        self.reloadView.hidden = false;
        self.reloadView.stopAnimating();
    }

}
