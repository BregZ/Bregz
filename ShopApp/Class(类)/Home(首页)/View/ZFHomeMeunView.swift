//
//  ZFHomeMeunView.swift
//  ShopApp
//
//  Created by mac on 15/11/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFHomeMeunView: UITableView {

    
    override init(frame: CGRect) {
        super.init(frame: frame, style: UITableViewStyle.Plain);
        
        //设置行高
        self.rowHeight = 100;
        
        //设置分区 hearderView 高度
        self.sectionHeaderHeight = 50;
        
        //取消分割线
        self.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        //滑动条
        self.showsVerticalScrollIndicator = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        println("ZFHomeMeunView 被销毁了");
    }

}
