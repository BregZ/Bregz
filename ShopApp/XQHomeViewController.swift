//
//  XQHomeViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQHomeViewController: UITableViewController,XQSectionHeaderViewDelegate {
    
    lazy var menuTitles : Array<XQMenuTitleModel> = {
        
        var array = Array<XQMenuTitleModel>()
        
        var databaseQueue : XQFMDatabaseQueue = XQFMDatabaseQueue.shareInstance()
        
        databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            array = XQMenuTitleDBTool.selectMenuTitleAll(db)
        }
        
        return array

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置 HeaderView
        self.setHeaderView()
        
        //设置行高
        self.tableView.rowHeight = 80
        
        //设置分区 hearderView 高度
        self.tableView.sectionHeaderHeight = 50
        
        //取消分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "正在刷新...")
        refreshControl.addTarget(self, action: "reloadMenuData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
//      在摇刷新代码首尾加上
//        self.refreshControl?.beginRefreshing()
//        self.refreshControl?.endRefreshing()
//
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //分区数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return self.menuTitles.count
    }

    //每个分区行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.menuTitles[section].menuContents == nil {
            return 0
        }
        return self.menuTitles[section].opened.boolValue ? self.menuTitles[section].menuContents!.count : 0
    }

    //cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = XQMenuContentTableViewCell.menuContentWithTableView(tableView)
        
        let menuContent : XQMenuContentModel = menuTitles[indexPath.section].menuContents![indexPath.row] as! XQMenuContentModel
        cell.menuContentModel = menuContent

        return cell
    }
    
    // 设置 分区 头View
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = XQSectionHeaderView.headerViewWithTableView(tableView)
        
        headerView.menuTitle = self.menuTitles[section]
        
        headerView.delegate = self
        
        return headerView
    }
    
    ///设置 HeaderView
    func setHeaderView() {
        
        let headerW : CGFloat = UIScreen.mainScreen().bounds.width
        let headerH : CGFloat = 280
        var headerView = XQHomeHeaderView(frame: CGRectMake(0, 0, headerW, headerH))
        
//        headerView.setImage(menuTitles[1].menuContents as! Array<XQMenuContentModel>)
        
        self.tableView.tableHeaderView = headerView

    }
    
    ///tableView 的 hearView 被点击
    func sectionHeaderViewBtngClick(sectionHeaderView: XQSectionHeaderView) {
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showFootVC = XQShowFootViewController()
        
        showFootVC.initView()
        
        showFootVC.menuContent = self.menuTitles[indexPath.section].menuContents![indexPath.row] as! XQMenuContentModel
        
        //隐藏tabBar
        showFootVC.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(showFootVC, animated: true)
    }
    
    //刷新数据
    func reloadMenuData(){
        
        self.refreshControl?.beginRefreshing()
        
        let request = XQAsynHttp.sendGetHttp("meunContent.php", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                if jsonArray != nil {
                    
                    var array = Array<XQMenuTitleModel>()
                    
                    
                    
                    for  dict in jsonArray! {
                        
                        let menuTitleModel = XQMenuTitleModel.menuTitleWithDict(dict as! NSDictionary)
                        
                        array.append(menuTitleModel)
                        
                    }
                    
                    self.menuTitles = array
                    
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.tableView.reloadData()
                        
                        
                        
                        self.saveMenuData(array)
                    })
                    
                }
                
                
            } else {
                NSLog("error : %@", error)
                
                
            }
        }
        
        self.refreshControl?.endRefreshing()

    }
    
    //保存数据（持久化）
    func saveMenuData(menuTitles : Array<XQMenuTitleModel>){
        
        var databaseQueue : XQFMDatabaseQueue = XQFMDatabaseQueue.shareInstance()
        
        databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            XQMenuTitleDBTool.deleteMenuTitle(db)
            XQMenuContentDBTool.deleteMenuContent(db)
            
            for menuTitle in menuTitles {
                
                XQMenuTitleDBTool.insertMenuTitle(db, menuTitle: menuTitle)
                
                if menuTitle.menuContents != nil {
                    
                    for menuContent in menuTitle.menuContents! {
                        XQMenuContentDBTool.insertMenuContent(db, menuContent: menuContent as! XQMenuContentModel)
                    }
                    
                }
                
            }
            
            
        }
        
    }
    
}
