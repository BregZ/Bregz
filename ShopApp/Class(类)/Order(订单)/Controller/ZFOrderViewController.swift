//
//  ZFOrderViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFOrderViewController: UITableViewController, ZFOrderHttpDelegate,UIAlertViewDelegate {
    
    ///自带刷新转轮的标题
    weak var navTitleView : ZFNavTitleView!
    
    ///加载中显示的view
    weak var loadingView : ZFLoadingView!
    
    lazy var orders : Array<ZFOrdersModel> = {
        
        return Array<ZFOrdersModel>();
        
    }()
    
    var orderHttp : ZFOrderHttp!

    override func viewDidLoad() {
        super.viewDidLoad();
        
        //初始化tableiew
        self.initView();

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //刷新数据
        self.reloadAllOrderData();
    }
    
    //初始化tableiew
    func initView(){
        
        //设置行高
        self.tableView.rowHeight = 70;
        
        //取消分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        //滑动条
        self.tableView.showsVerticalScrollIndicator = false;
        
        self.orderHttp = ZFOrderHttp();
        self.orderHttp.delegate = self;
        
        //添加下拉刷新方法
        self.addRefreshControl();
        
        //添加自定义标题
        self.addNavTitleView();
        
        //设置加载中显示的view
        self.setupLoadingView();
        
    }
    
    //添加自定义标题
    func addNavTitleView(){
        let navTitleView : ZFNavTitleView = ZFNavTitleView(frame : CGRectMake(0, 0, 0, 44))
        navTitleView.title = self.title!
        self.navigationItem.titleView = navTitleView
        self.navTitleView = navTitleView;
        
    }
    
    //添加刷新功能
    func addRefreshControl() {
        
        self.tableView.addHeaderWithTarget(self, action: "reloadAllOrderData")
    }
    
    //下拉调用方法
    func reloadAllOrderData(){
        
        self.navTitleView.titleBeginRefreshing();
        
        self.orderHttp.getAllOrderData();
        
    }
    
    //设置加载中显示的view
    func setupLoadingView(){
        
        let loadingView : ZFLoadingView = ZFLoadingView(frame: self.view.frame)
        loadingView.hidden = true;
        self.view.addSubview(loadingView)
        
        self.loadingView = loadingView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orders.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //获得Cell
        let cell = ZFOrderTableViewCell.orderTableViewCellWithTableView(tableView);
        
        //给cell赋值
        cell.orders = self.orders[indexPath.row];
        
        return cell;

    }
    
    //设置tableView的左滑按钮
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let settleAction  = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "结账") { (action : UITableViewRowAction!, indexPath : NSIndexPath!) -> Void in
            
            //是否结账提示框
            self.isSettleAlert(indexPath);
        }
        
        let addOrderAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "加菜") { (action : UITableViewRowAction!, indexPath : NSIndexPath!) -> Void in
            
            //posh化购物车controller
            self.nextsinglePointVC(indexPath);
            
        }
        
        return [settleAction,addOrderAction]
        
    }

    ///设置订单提示
    func setupAnimPromopt(promoptText : String){
        
        let promoptBtnW : CGFloat = self.view.frame.size.width;
        let promoptBtnH : CGFloat = 35;
        let promoptBtnX : CGFloat = 0;
        let promoptBtnY : CGFloat = 64 - promoptBtnH;
        
        let promoptBtn : ZFPromoptView = ZFPromoptView(frame: CGRectMake(promoptBtnX, promoptBtnY, promoptBtnW, promoptBtnH));
        
        promoptBtn.setTitle(promoptText, forState: UIControlState.Normal);
        self.navigationController!.view.insertSubview(promoptBtn, belowSubview: self.navigationController!.navigationBar);
        
        //设置动画
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            //向下移动 promoptBtnH ＋ 2 的距离
            promoptBtn.transform = CGAffineTransformMakeTranslation(0, promoptBtnH + 1)
        }) { (Bool) -> Void in
            UIView.animateWithDuration(0.7, delay: 1, options: UIViewAnimationOptions(0), animations: { () -> Void in
                
                //恢复之前的 transform
                promoptBtn.transform = CGAffineTransformIdentity;
                
            }, completion: { (Bool) -> Void in
                
                //删除提示按钮
                promoptBtn.removeFromSuperview();
            })
        }
        
    }
    
    lazy var isSettleA : UIAlertView = {
        return UIAlertView(title: "友情提示", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定");
    }()
    
    //是否结账提示框
    func isSettleAlert(indexPath: NSIndexPath){
        
        let allPrice = CGFloat(self.orders[indexPath.row].orders_price!)
        self.isSettleA.message = "共￥\(allPrice)元，您确定要结账了吗？"
        self.isSettleA.tag = indexPath.row
        self.isSettleA.show()
    }
    
    //UIAlertView按钮代理
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.buttonTitleAtIndex(buttonIndex) == "确定" {
            
            //开始加载
            self.loadingView.statrLoad();
            
            //提交结账请求
            self.orderHttp.orderSettleData(Int(self.orders[alertView.tag].seat_id!))
        }
    }
    
    //posh化购物车controller
    func nextsinglePointVC(indexPath: NSIndexPath){
        //初始化购物车controller
        let singlePointVC : ZFSinglePointViewController = ZFSinglePointViewController()
        
        //给购物车的座位id赋值
        singlePointVC.seat_id = Int(self.orders[indexPath.row].seat_id!)
        
        //进入购物车界面
        self.navigationController?.pushViewController(singlePointVC, animated: true)
    }
    
    //点击一行
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //posh展示一桌订单内容contoller
        self.nextshowEvenVC(indexPath)
    }
    
    //posh展示一桌订单内容contoller
    func nextshowEvenVC(indexPath: NSIndexPath){
        
        //初始化展示一桌订单内容contoller
        let showEvenContent : ZFShowEvenAnyOrderController = ZFShowEvenAnyOrderController();
        
        //赋值id
        showEvenContent.seat_id = Int(self.orders[indexPath.row].seat_id!);
        
        //赋值总价
        showEvenContent.allPrice = CGFloat(self.orders[indexPath.row].orders_price!);
        
        //赋值时间
        showEvenContent.time = self.orders[indexPath.row].order_time;
        
        //进入展示一桌订单内容contoller
        self.navigationController?.pushViewController(showEvenContent, animated: true);
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }

    //下拉数据完成后调用
    func orderHttp(orderHttp: ZFOrderHttp, reloadAllOrder: Array<ZFOrdersModel>) {
        
        if reloadAllOrder.count == 0 {
            self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "no_order_bg")!);
        }else{
            self.tableView.backgroundColor = UIColor.whiteColor();
        }
        
        self.orders = reloadAllOrder;
        
        //刷新tableView
        self.tableView.reloadData();
        
        //设置订单提示
        self.setupAnimPromopt("共\(reloadAllOrder.count)条订单");
        
        //结束刷新
        self.tableView.headerEndRefreshing();
        self.navTitleView.titleEndRefreshing();
    }
    
    //结账是否成功会掉用
    func orderHttp(orderHttp: ZFOrderHttp, isSettle: String) {
        
        //结束加载
        self.loadingView.stopLoad();
        
        if isSettle == "YesSettle" {
            //结账成功
            
            //跳入评分界面
            let vc = ZFRatingStarViewController();
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true);
            
            
        }else if isSettle == "NoSettle" {
            //结账失败
            let label : UILabel = UILabel();
            label.Toact("您的订单不存在，或以结账", fontSize: 17, view: self.tableView);
            
            //刷新数据
            self.reloadAllOrderData();
        }
    }
    
    deinit {
        println("ZFOrderViewController deinit")
    }

}
