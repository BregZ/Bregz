//
//  ZFSeatCollectionViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

//显示座位

import UIKit

let reuseIdentifier = "SeatCell"

class ZFSeatCollectionViewController: UICollectionViewController,UIActionSheetDelegate,ZFSeatHttpDelegate {
    
    weak var navTitleView : ZFNavTitleView!         //导航栏标题
    
    weak var loadingView : ZFLoadingView!           //加载中显示的view
    
    
    let layoutItemW : CGFloat = 100                 //cell的宽
    
    let layoutItemH : CGFloat = 150                 //cell的高
    
    let layoutSectionInset : CGFloat = 20           //
    
    var seatHttp : ZFSeatHttp!
    
    lazy var seats : Array<ZFSeatModel> = {
        
        return Array<ZFSeatModel>()
        
    }()
    
    lazy var shopAction : UIActionSheet = {
        let shopAction : UIActionSheet = UIActionSheet()
        
        shopAction.title = "请您选择"
        shopAction.delegate = self
        shopAction.addButtonWithTitle("点单")
        shopAction.addButtonWithTitle("退桌")
        shopAction.addButtonWithTitle("取消")
        shopAction.destructiveButtonIndex = 1
        shopAction.cancelButtonIndex = 2
        
        return shopAction
    }()     //提示
    
    
    
    init() {
        
        var layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSizeMake(layoutItemW, layoutItemH)
        
        layout.sectionInset = UIEdgeInsetsMake(layoutSectionInset, layoutSectionInset, layoutSectionInset, layoutSectionInset)
        
        super.init(collectionViewLayout: layout)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(ZFSeatCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        self.setupCollectionView()
        
        self.addRefreshControl()
        
        self.seatHttp = ZFSeatHttp()
        self.seatHttp.delegate = self
        
        //滑动条
        self.collectionView!.showsVerticalScrollIndicator = false
        
        //添加自定义标题
        self.addNavTitleView();
        
        //设置加载中显示的view
        self.setupLoadingView();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //进入界面就刷新
        self.reloadSeatData();
    }
    
    //设置collectionView属性
    func setupCollectionView() {
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
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
        
        //添加下拉刷新功能
        self.collectionView?.addHeaderWithTarget(self, action: "reloadSeatData")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }



    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.seats.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ZFSeatCollectionViewCell
        
        cell.seat = self.seats[indexPath.row]
    
        return cell
    }


    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let title : String = (collectionView.cellForItemAtIndexPath(indexPath) as! ZFSeatCollectionViewCell).titleView.text!
        self.shopAction.title = "请您为 \(title) 选择"
        self.shopAction.tag = indexPath.row
        self.shopAction.showInView(self.view)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        let selectSeat = self.seats[actionSheet.tag]
        
        
        
        if actionSheet.buttonTitleAtIndex(buttonIndex) == "点单" {

            //检验是否有人已订购了此桌
            if selectSeat.seat_state! {
                
                //开始加载
                self.loadingView.statrLoad();
                
                selectSeat.seat_state = !selectSeat.seat_state!
                self.seatHttp.sendSeatStateData(selectSeat)
                
            }else {
                
                self.nextController(actionSheet.tag);
            }
            
        }else if actionSheet.buttonTitleAtIndex(buttonIndex) == "退桌" && !selectSeat.seat_state!{    //座位时选中状态
            
            //开始加载
            self.loadingView.statrLoad();
            
            selectSeat.seat_state = !selectSeat.seat_state!
            self.seatHttp.sendRefundSeatStateData(selectSeat)
        }
        
    }
    
    //设置加载中显示的view
    func setupLoadingView(){
        
        let loadingView : ZFLoadingView = ZFLoadingView(frame: self.view.frame)
        loadingView.hidden = true;
        self.view.addSubview(loadingView)
        
        self.loadingView = loadingView;
    }
    
    //进入下一个Controller
    func nextController(row : Int){
        
        let singlePointVC : ZFSinglePointViewController = ZFSinglePointViewController()
        singlePointVC.seat_id = self.seats[row].seat_id
        self.navigationController?.pushViewController(singlePointVC, animated: true)
    }
    
    //下拉刷新调用方法
    func reloadSeatData(){
        
        self.navTitleView.titleBeginRefreshing();
        
        //获取座位josn信息
        self.seatHttp.getSeatData();
  
    }
    
    //获得数据刷新界面
    func seatHttp(seatHttp: ZFSeatHttp, newSeats: Array<ZFSeatModel>) {
        
        self.seats = newSeats
        
        //刷新界面
        self.collectionView?.reloadData()
        
        //关闭刷新
        self.collectionView?.headerEndRefreshing()
        self.navTitleView.titleEndRefreshing()
    }
    
    //获得是否订桌成功数据刷新界面
    func seatHttp(seatHttp: ZFSeatHttp, isSeat: String) {
        
        //结束加载
        self.loadingView.stopLoad();
        
        if isSeat == "YesSeat" {
            
            self.nextController(self.shopAction.tag)
            
        } else if isSeat == "NoSeat" {
            
            let label : UILabel = UILabel()
            
            label.Toact("此桌以有人", fontSize: 17, view: self.collectionView!)
            
            //刷新列表
            self.reloadSeatData()
        }
        
    }
    
    //获得是否退单成功数据刷新界面
    func seatHttp(seatHttp: ZFSeatHttp, isRefundSeat: String, seat_id: Int) {
        
        //结束加载
        self.loadingView.stopLoad();
        
        if isRefundSeat == "YesRefundSeat" {
            let orderSqlite = ZFOrderSqlite()
            
            orderSqlite.removeAllSeatOrder(seat_id)
        } else if (isRefundSeat == "NoRefundSeat") {
            let label = UILabel()
            label.Toact("抱歉，您已点了餐不能退桌", fontSize: 17, view: self.collectionView!)
        }
        
        //刷新列表
        self.reloadSeatData()
    }
    
    deinit {
        println("ZFSeatCollectionViewController 被销毁了")
    }
}
