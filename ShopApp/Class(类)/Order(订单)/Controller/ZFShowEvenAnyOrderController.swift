//
//  ZFShowEvenAnyOrderController.swift
//  ShopApp
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFShowEvenAnyOrderController: UITableViewController, ZFOrderHttpDelegate {
    
    weak var navTitleView : ZFNavTitleView!
    
    var allPrice : CGFloat!
    
    var time : String!
    
    var seat_id : Int!
    
    var orderHttp : ZFOrderHttp!
    
    lazy var orders : Array<ZFOrderContentModel> = {
        return Array<ZFOrderContentModel>()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

         //初始化View上的控件
        self.initView()
        
        

    }
    
    //初始化View上的控件
    func initView(){
        
        //设置标题
        self.title = " 〖\(self.seat_id)〗号座订单 "
        
        //设置行高
        self.tableView.rowHeight = 70
        
        //设置分区 hearderView 高度
        self.tableView.sectionHeaderHeight = 50
        
        //分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //初始化
        self.orderHttp = ZFOrderHttp()
        self.orderHttp.delegate = self
        
        //添加自定义标题
        self.addNavTitleView();
        
        //添加下拉刷新
        self.addRefreshControl()
        
        
    }
    
    //添加刷新功能
    func addRefreshControl() {
        
        self.tableView.addHeaderWithTarget(self, action: "reloadEvenOrderData")
        
        //刷新数据
        self.reloadEvenOrderData();

    }
    
    
    
    //添加刷新功能
    func reloadEvenOrderData(){
        
        self.navTitleView.titleBeginRefreshing();
        
        self.orderHttp.gainOrderData(self.seat_id)
        
    }
    
    //获得网络数据回调
    func orderHttp(orderHttp: ZFOrderHttp, reloadEvenOrder: Array<ZFOrderContentModel>) {
        self.orders = reloadEvenOrder
        
        self.tableView.reloadData()
        
        //结束刷新
        self.tableView.headerEndRefreshing();
        self.navTitleView.titleEndRefreshing();
    }
    
    //添加自定义标题
    func addNavTitleView(){
        let navTitleView : ZFNavTitleView = ZFNavTitleView(frame : CGRectMake(0, 0, 0, 44))
        navTitleView.title = self.title!
        self.navigationItem.titleView = navTitleView
        self.navTitleView = navTitleView;
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ZFOrderContentCell.orderContentCellWithTabelView(tableView)
        
        cell.orderContent = self.orders[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = ZFShowEvenOrderSectionHearderView.headerViewWithTableView(tableView)
        
        headerView.allPrice = self.allPrice
        
        headerView.time = self.time
        
        return headerView
    }
    
    deinit {
        println("ZFShowEvenAnyOrderController deinit")
    }

}
