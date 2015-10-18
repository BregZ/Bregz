//
//  XQOrderViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQOrderViewController: UITableViewController {
    
    lazy var orders : Array<XQOrdersModel> = {
        
        var orders = Array<XQOrdersModel>()
        
        for i in 1 ... 5 {
            let order = XQOrdersModel()
            
            order.orders_seatText = "\(i)"
            
            order.orders_price = 10 * CGFloat(i)
            
            orders.append(order)
        }
        return orders
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = XQOrderTableViewCell.orderTableViewCellWithTableView(tableView)
        
        cell.orders = self.orders[indexPath.row]
        
        return cell

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let settleAction  = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "结账") { (action : UITableViewRowAction!, indexPath : NSIndexPath!) -> Void in
            
        }
        
        let addOrderAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "加菜") { (action : UITableViewRowAction!, indexPath : NSIndexPath!) -> Void in
            
            let singlePointVC : XQSinglePointViewController = XQSinglePointViewController()
            singlePointVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(singlePointVC, animated: true)
            
        }
        
        return [settleAction,addOrderAction]
        
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    

}
