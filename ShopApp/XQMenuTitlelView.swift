//
//  XQMenuTitlelView.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol XQMenuTitlelViewDelegate : NSObjectProtocol {
    
    optional func menuTitlelView(menuTitlelView: XQMenuTitlelView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    
}

class XQMenuTitlelView: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    
    var XQdelegate : XQMenuTitlelViewDelegate?
    
    var _menuTitles : Array<XQMenuTitleModel>?
    
    var menuTitles : Array<XQMenuTitleModel>{
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
        
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        
        

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self._menuTitles == nil {
            return 0
        }
        return self._menuTitles!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = XQMenuTitlelCell.menuTitleCellWithTableView(tableView)
        
        cell.menuTile = self._menuTitles![indexPath.row].menuTitle_name!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.XQdelegate != nil && self.XQdelegate!.respondsToSelector(Selector("menuTitlelView:didSelectRowAtIndexPath:")) {
            self.XQdelegate!.menuTitlelView!(self, didSelectRowAtIndexPath: indexPath)
        }
        
    }

}
