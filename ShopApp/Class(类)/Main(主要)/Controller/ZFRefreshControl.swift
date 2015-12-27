//
//  ZFRefreshControl.swift
//  ShopApp
//
//  Created by mac on 15/11/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFRefreshControl1: UIRefreshControl {
    
    let RELOAD_WILL_TITLE : String = "下拉刷新";
    let RELOADING_TITLE : String = "玩命加载中...";
    let RELOADED_TITLE : String = "刷新完毕";
    
    let delayTime : UInt64 = 1;
    
    var attributedString : NSMutableAttributedString!

    override init() {
        super.init();
        
//        let attr : Dictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()];
        self.attributedString = NSMutableAttributedString(string: RELOAD_WILL_TITLE, attributes: nil);
        
//        self.tintColor = UIColor.redColor()
        
        self.attributedTitle = self.attributedString;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    override func beginRefreshing() {
        
        self.attributedString.replaceCharactersInRange(NSMakeRange(0, self.attributedString.length), withString: self.RELOADING_TITLE);
        self.attributedTitle = self.attributedString;
        
        super.beginRefreshing();
        
    }
    
    override func endRefreshing() {
        
        
        self.attributedString.replaceCharactersInRange(NSMakeRange(0, attributedString.length), withString: RELOADED_TITLE);
        self.attributedTitle = self.attributedString;
        
        super.endRefreshing();
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            
            self.attributedString.replaceCharactersInRange(NSMakeRange(0, self.attributedString.length), withString: self.RELOAD_WILL_TITLE);
            self.attributedTitle = self.attributedString;
        
        }
        
    }

}
