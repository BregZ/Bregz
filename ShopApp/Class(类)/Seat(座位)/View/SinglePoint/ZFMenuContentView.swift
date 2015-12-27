//
//  ZFMenuContentView.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuContentView: UITableView,UITableViewDataSource,UITableViewDelegate {

    var _menuContents : Array<ZFMenuContentModel>?          //菜单内容模型
    
    var menuContents : Array<ZFMenuContentModel>{           //更新菜单内容模型
        set{
            self._menuContents = newValue
            
            self.reloadData()
        }
        get{
            return self.menuContents
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame, style: UITableViewStyle.Plain)
        
        self.initTableView()
        
    }
    
    //初始化tableview上控件
    func initTableView(){
        
        //代理与数据源
        self.delegate = self;
        self.dataSource = self;
        
        //设置行高
        self.rowHeight = ZFShoppingCartMenuContentCellHieght;
        
        //取消分割线
        self.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        //滑动条
        self.showsVerticalScrollIndicator = false;
        

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    //分区行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self._menuContents == nil {
            return 0;
        }
        return self._menuContents!.count;
    }
    
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //获取cell
        let cell = ZFMenuContentCell.menuContentCellWithTableView(tableView);
        
        //赋值数据
        cell.menuContent = self._menuContents![indexPath.row];
        
        //建立代理
        cell.delegate = UIViewController.viewControllerWithView(self) as? ZFSinglePointViewController;

        return cell
    }

}
