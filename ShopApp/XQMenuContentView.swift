//
//  XQMenuContentView.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQMenuContentView: UITableView,UITableViewDataSource,UITableViewDelegate {

    var _menuContents : Array<XQMenuContentModel>?
    
    var menuContents : Array<XQMenuContentModel>{
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
        
        self.delegate = self
        self.dataSource = self
        
        self.rowHeight = 90
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self._menuContents == nil {
            return 0
        }
        return self._menuContents!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = XQMenuContentCell.menuContentCellWithTableView(tableView)
        
        cell.menuContent = self._menuContents![indexPath.row]
        
        cell.delegate = UIViewController.viewControllerWithView(self) as? XQSinglePointViewController

        return cell
    }

}
