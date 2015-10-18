//
//  XQShoppingCartShowMenuContentView.swift
//  ShopApp
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

let XQShoppingCartShowMenuContentViewSectionHeight : CGFloat = 50                              //分区头高

class XQShoppingCartShowMenuContentView: UITableView ,UITableViewDataSource,UITableViewDelegate {
    
    
    
    var _menuContents : Array<XQOrderContentModel>?
    
    var menuContents : Array<XQOrderContentModel>! {
        set {
            self._menuContents = newValue
            
            self.reloadData()
        }
        get{
            return self._menuContents!
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame, style: UITableViewStyle.Plain)
        
        self.rowHeight = XQShoppingCartShowMenuContentCellHieght
        
        self.backgroundColor = UIColor.clearColor()
        
        self.bounces = false
        
        self.delegate = self
        self.dataSource = self
        
        self.sectionHeaderHeight = XQShoppingCartShowMenuContentViewSectionHeight
        self.sectionFooterHeight = XQShoppingCartShowMenuContentViewSectionHeight
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if _menuContents == nil {
            return 0
        }
        return self.menuContents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = XQShoppingCartShowMenuContentCell.shoppingCartShowMenuContentCellWithtableView(tableView)
        
        cell.orderContent = self.menuContents[indexPath.row]
        
        cell.delegate = UIViewController.viewControllerWithView(self) as! XQSinglePointViewController
        
        return cell
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = XQShopCarHeaderView.shopCarHeaderViewWithTable(tableView)
        
        header.delegate = UIViewController.viewControllerWithView(self) as! XQSinglePointViewController
        
        return header
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footer = XQShopCarFooterView.shopCarFooterViewWithTable(tableView)
        
        return footer
    }

}
