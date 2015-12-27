//
//  ZFShowSearchResultView.swift
//  ShopApp
//
//  Created by mac on 15/11/18.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFShowSearchResultView: UIView, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, ZFMenuContentCellDelegate {
    
    //搜索栏背景View
    weak var searchBarBgView : UIView!
    
    //展示搜索内容数据view
    weak var showContentView : ZFMenuContentView!
    
    //搜索栏
    weak var searchBarView : ZFSearchBarView!
    
    //搜索的菜谱信息
    var searchMenuContents : Array<ZFMenuContentModel>!
    
    //操作数据酷对象
    var menuSqlite : ZFMenuSqlite!

    override init(frame : CGRect){
        super.init(frame: frame);
        
        //初始化
        self.initView();
        
        //设置透明背景
        self.setupTransparentBackground();
        
        //设置搜索栏背景
        self.setupSearchBarBgView();
        
        //设置搜索栏
        self.setupSearchBarView();
        
        //设置展示搜索内容数据view
        self.setupContentView();
        
        
    }

    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //初始化
    func initView(){
        
        self.backgroundColor = UIColor.clearColor();
        
        self.menuSqlite = ZFMenuSqlite();
        
    }
    
    //设置透明背景
    func setupTransparentBackground(){
        
        let background : UIButton = UIButton()
        background.backgroundColor = UIColor.blackColor();
        background.alpha = 0.5;
        background.frame = self.bounds;
        background.addTarget(self, action: "scrollViewWillBeginDragging:", forControlEvents: UIControlEvents.TouchDown)
        
        self.addSubview(background)
    }
    
    //设置搜索栏背景
    func setupSearchBarBgView(){
        
        let bgX : CGFloat = 0;
        let bgY : CGFloat = 0;
        let bgW : CGFloat = self.frame.size.width;
        let bgH : CGFloat = 50;
        
        let searchBarBgView : UIView = UIView(frame: CGRectMake(bgX, bgY, bgW, bgH));
        searchBarBgView.backgroundColor = UIColor.whiteColor();
        self.addSubview(searchBarBgView);
        self.searchBarBgView = searchBarBgView;
        
    }
    
    //设置搜索栏
    func setupSearchBarView (){
        
        let searchBarX : CGFloat = 10;
        let searchBarW : CGFloat = self.frame.size.width - searchBarX * 2;
        let searchBarH : CGFloat = 40;
        let searchBarY : CGFloat = (self.searchBarBgView.frame.size.height - searchBarH) * 0.5;
    
        
        let searchBar : ZFSearchBarView = ZFSearchBarView(frame: CGRectMake(searchBarX, searchBarY, searchBarW, searchBarH));
        searchBar.delegate = self;
        self.searchBarBgView.addSubview(searchBar);
        
        self.searchBarView = searchBar;
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if count(searchText) > 0 {
            
            self.showContentView.hidden = false;
            
            self.searchMenuContents = self.menuSqlite.searchMenuContent(searchText);
            
            self.showContentView.reloadData();
            
        } else {
            self.showContentView.hidden = true;
        }
    }
    
    //设置展示搜索内容数据view
    func setupContentView(){
        
        let contentViewX : CGFloat = 0;
        let contentViewY : CGFloat = CGRectGetMaxY(self.searchBarBgView.frame);
        let contentViewW : CGFloat = self.frame.size.width;
        let contentViewH : CGFloat = self.frame.height - contentViewY;
        
        let contentView : ZFMenuContentView = ZFMenuContentView(frame: CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH));
        contentView.hidden = true;
        contentView.delegate = self;
        contentView.dataSource = self;
        self.addSubview(contentView);
        
        self.showContentView = contentView;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchMenuContents != nil ? self.searchMenuContents.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let menuContentCell = ZFMenuContentCell.menuContentCellWithTableView(tableView);
        
        menuContentCell.menuContent = self.searchMenuContents[indexPath.row];
        
        menuContentCell.delegate = UIViewController.viewControllerWithView(self) as! ZFSinglePointViewController;
        
        return menuContentCell;
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if self.searchMenuContents != nil {
            
            return "为您搜索到 \(self.searchMenuContents.count) 条结果";
        }
        return nil;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchBarView.resignFirstResponder();
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBarView.resignFirstResponder();
    }
    
    deinit {
        println("ZFShowSearchResultView deinit")
        
        self.searchBarView.resignFirstResponder();
    }

}
