//
//  ZFHomeViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ZFSectionHeaderViewDelegate, ZFGetMenuDelegate,ZFShowMenuContentViewDelegate, ZFCultureHttpDelegate {
    
    weak var tableView : ZFHomeMeunView!
    
    weak var homeHeaderView : ZFHomeHeaderView!
    
    lazy var menuTitles : Array<ZFMenuTitleModel> = {
        
        let menuSqlite = ZFMenuSqlite();
        
        return menuSqlite.selectMenu();

    }()
    
    lazy var getMeunHttp : ZFGetMenuHttp = {
        
        return ZFGetMenuHttp();
        
        }();
    
    lazy var cultureHttp : ZFCultureHttp = {
        
        return ZFCultureHttp();
        
    }();

    override func viewDidLoad() {
        super.viewDidLoad();
        
        //初始化tabelView属性
        self.initView();
        
        //设置 HeaderView
        self.setHeaderView();

        //设置下拉刷新
        self.setRefreshControl();
        
        //刷新公司文化数据
        self.reloadCultureData();
  
    }
    override func viewDidAppear(animated: Bool) {
        if self.homeHeaderView != nil {
            //添加定时器
            self.homeHeaderView.addTimer();
        }
    }
    
    //视图消失完毕
    override func viewWillDisappear(animated: Bool) {
        if self.homeHeaderView != nil  {
            
            //移除头部掉的定时器
            self.homeHeaderView.removeTimer();
        }
    }
    
    //初始化tabelView属性
    func initView(){
        
        let tableView : ZFHomeMeunView = ZFHomeMeunView(frame: self.view.frame);
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView);
        self.tableView = tableView;

    }
    
    //设置下拉刷新
    func setRefreshControl(){
        
        self.tableView.addHeaderWithTarget(self, action: "reloadData");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }

    //分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return self.menuTitles.count;
    }

    //每个分区行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.menuTitles[section].menuContents == nil {
            return 0;
        }
        return self.menuTitles[section].opened.boolValue ? self.menuTitles[section].menuContents!.count : 0;
    }

    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ZFMenuContentTableViewCell.menuContentWithTableView(tableView);
        
        let menuContent : ZFMenuContentModel = menuTitles[indexPath.section].menuContents![indexPath.row] as! ZFMenuContentModel;
        cell.menuContentModel = menuContent;

        return cell
    }
    
    // 设置 分区 头View
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var sectionHeaderView = ZFSectionHeaderView.headerViewWithTableView(tableView);
        
        sectionHeaderView.menuTitle = self.menuTitles[section];
        
        sectionHeaderView.delegate = self;
        
        return sectionHeaderView;
    }
    
    ///设置 HeaderView
    func setHeaderView() {
        

        let headerW : CGFloat = UIScreen.mainScreen().bounds.width;
        let headerH : CGFloat = 280
        var headerView = ZFHomeHeaderView(frame: CGRectMake(0, 0, headerW, headerH));
        
        self.tableView.tableHeaderView = headerView;
        
        self.homeHeaderView = headerView

        

    }
    
    ///table开始拖动
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //在开始拖动关掉定时器
        homeHeaderView.removeTimer();
    }
    
    ///减速停止(移动停止)
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //在开始拖动添加定时器
        homeHeaderView.addTimer();
    }
    
    ///tableView 的 hearView 被点击
    func sectionHeaderViewBtngClick(sectionHeaderView: ZFSectionHeaderView) {
        self.tableView.reloadData();
    }

    //cell被点击
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //隐藏标签栏和导航栏
        self.isHiddenTabBar(true, isHidenNavigationBar: false)
        
        //显示菜单详情内容信息窗口
        self.showmenuContent(indexPath);

//        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            
//
//            }, completion: nil)
        
    }
    
    //是否隐藏标签栏和导航栏
    func isHiddenTabBar(isHidenTabBar : Bool, isHidenNavigationBar : Bool){
        self.tabBarController?.tabBar.hidden = isHidenTabBar;
        self.navigationController?.navigationBar.hidden = isHidenNavigationBar;
    }
    
    //显示菜单详情内容信息窗口
    func showmenuContent(indexPath: NSIndexPath){
        
        let showMenuContent : ZFShowMenuContentView = ZFShowMenuContentView(frame: self.view.frame);
        
        showMenuContent.menuContent = self.menuTitles[indexPath.section].menuContents![indexPath.row] as! ZFMenuContentModel;
        
        showMenuContent.delegate = self;
        
        self.navigationController!.view.addSubview(showMenuContent);
        
    }
    
    //显示菜单详情的窗口被关闭后调用
    func showMenuContentView(showMenuContentView: ZFShowMenuContentView, closeBtnDidClick closeBtn: UIButton) {
        //显示标签栏和导航栏
        self.isHiddenTabBar(false, isHidenNavigationBar: false)
    }
    
    //下拉刷新调用方法
    func reloadData(){
        
        if self.homeHeaderView != nil  {
            
            //移除头部掉的定时器
            self.homeHeaderView.removeTimer();
        }
        
        //刷新公司文化数据
        self.reloadCultureData();
        
        //刷新菜单
        self.reloadMenuData();
    }
    
    //刷新公司文化数据
    func reloadCultureData(){
        
        
        
        self.cultureHttp.delegate = self;
        
        self.cultureHttp.getulturesData();
    }
    
    //刷新菜单
    func reloadMenuData(){
        
        
        
        self.getMeunHttp.delegate = self;
        
        //调用获取数据方法
        self.getMeunHttp.GetJsonMenuData();
    }
    
    
    
    //获得菜单数据刷新界面
    func getMenuHttp(MenuHttp: ZFGetMenuHttp, newMenuTitleModel: Array<ZFMenuTitleModel>) {
        
        //设置菜单数据
        self.menuTitles = newMenuTitleModel;
        
        //刷新列表
        self.tableView.reloadData();
        
        //保存菜单数据
        self.saveMenuData(newMenuTitleModel);
        
        //结束刷新
        self.tableView.headerEndRefreshing()
    }

    
    //获得公司文化数据刷新界面
    func cultureHttp(cultureHttp: ZFCultureHttp, newCultures: Array<ZFCultureModel>) {
        
        self.homeHeaderView.setImage(newCultures)
    }
    
    //保存数据（持久化）
    func saveMenuData(menuTitles : Array<ZFMenuTitleModel>){
        
        let saveMenu = ZFMenuSqlite();
        
        saveMenu.saveMenu(menuTitles);
        
    }
    
    deinit {
        
        
        println("ZFHomeViewController 被销毁了")
        
        //移除头部掉的定时器
        self.homeHeaderView.removeTimer();
    }
    
}
