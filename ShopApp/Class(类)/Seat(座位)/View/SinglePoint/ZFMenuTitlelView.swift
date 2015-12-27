//
//  ZFMenuTitlelView.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFMenuTitlelViewDelegate : NSObjectProtocol {
    
    optional func menuTitlelView(menuTitlelView: ZFMenuTitlelView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    
}

class ZFMenuTitlelView: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    
    weak var ZFdelegate : ZFMenuTitlelViewDelegate?          //自定义代理
    
    var _menuTitles : Array<ZFMenuTitleModel>?          //菜单标题模型
    
    var menuTitles : Array<ZFMenuTitleModel>{           //更新菜单标题模型
        set{
            self._menuTitles = newValue
            
            
//            self.reloadData()
            let indexPath = NSIndexPath(forItem: 0, inSection: 0)
            self.tableView(self, didSelectRowAtIndexPath: indexPath)
            self.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
        }
        get{
            return _menuTitles!
        }
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame,style : UITableViewStyle.Plain)
        
        self.delegate = self
        self.dataSource = self

        //设置行高
        self.rowHeight = 70
        
        //取消分割线
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        
        

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置分区行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self._menuTitles == nil {
            return 0
        }
        return self._menuTitles!.count
    }
    
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = ZFMenuTitlelCell.menuTitleCellWithTableView(tableView)
        
        cell.menuTile = self._menuTitles![indexPath.row].menuTitle_name!
        
        return cell
    }
    
    //点击cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //通知代理
        if self.ZFdelegate != nil && self.ZFdelegate!.respondsToSelector(Selector("menuTitlelView:didSelectRowAtIndexPath:")) {
            self.ZFdelegate!.menuTitlelView!(self, didSelectRowAtIndexPath: indexPath)
        }
        
    }

}
