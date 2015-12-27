//
//  ZFShoppingCartShowMenuContentView.swift
//  ShopApp
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit



@objc protocol ZFShoppingCartShowMenuContentViewDegelate : NSObjectProtocol {
    
    optional func shoppingCartShowMenuContentView(showMenuContentView : ZFShoppingCartShowMenuContentView,reloadSectionFooterView : ZFShopCarFooterView)
    
}

class ZFShoppingCartShowMenuContentView: UITableView ,UITableViewDataSource,UITableViewDelegate {
    
    weak var ZFDelegate : ZFShoppingCartShowMenuContentViewDegelate!;        //自定义协议
    
    var _menuContents : Array<ZFOrderContentModel>?;                    //菜单内容模型
    
    var menuContents : Array<ZFOrderContentModel>! {                    //设置菜单内容模型
        set {
            //赋值
            self._menuContents = newValue;
            
            //刷新表格
            self.reloadData();
        }
        get{
            return self._menuContents!;
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame, style: UITableViewStyle.Plain)
        
        //设置行高
        self.rowHeight = ZFShoppingCartShowMenuContentCellHieght
        
        //清除背景色
        self.backgroundColor = UIColor.clearColor()
        
        //消除反弹
        self.bounces = false
        
        //协议与数据原
        self.delegate = self
        self.dataSource = self
        
        //设置分区头部高度
        self.sectionHeaderHeight = ZFShoppingCartShowMenuContentViewSectionHeight
        //设置分区尾部高度
        self.sectionFooterHeight = ZFShoppingCartShowMenuContentViewSectionHeight
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置每个分区行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _menuContents == nil {
            return 0
        }
        return self.menuContents.count
    }
    
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ZFShoppingCartShowMenuContentCell.shoppingCartShowMenuContentCellWithtableView(tableView)
        
        cell.orderContent = self.menuContents[indexPath.row]
        
        cell.delegate = UIViewController.viewControllerWithView(self) as! ZFSinglePointViewController
        
        return cell
    }

    //设置taableView的头View
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = ZFShopCarHeaderView.shopCarHeaderViewWithTable(tableView)
        
        header.delegate = UIViewController.viewControllerWithView(self) as! ZFSinglePointViewController
        
        return header
        
    }
    
    //设置taableView的底部View
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footer = ZFShopCarFooterView.shopCarFooterViewWithTable(tableView)
        
        footer.delegate = UIViewController.viewControllerWithView(self) as! ZFSinglePointViewController
        
        return footer
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.ZFDelegate != nil && self.ZFDelegate.respondsToSelector(Selector("shoppingCartShowMenuContentView:reloadSectionFooterView:")) {
            self.ZFDelegate.shoppingCartShowMenuContentView!(self, reloadSectionFooterView: self.footerViewForSection(0) as! ZFShopCarFooterView)
        }
        
    }

}
