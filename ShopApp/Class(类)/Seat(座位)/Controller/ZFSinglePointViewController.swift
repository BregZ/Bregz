//
//  ZFSinglePointViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSinglePointViewController: UIViewController,ZFMenuTitlelViewDelegate,ZFMenuContentCellDelegate,ZFShoppingCarViewDelegate,ZFShoppingCartShowMenuContentCellDelegate,ZFShopCarHeaderViewDelegate,ZFShoppingCartShowMenuContentViewDegelate,ZFShopCarFooterViewDelegate, UIAlertViewDelegate,ZFOrderHttpDelegate {
    
        
    weak var menuTitlelView : ZFMenuTitlelView!;                    //菜单标题
    
    weak var menuContentView : ZFMenuContentView!;                  //菜单内容
    
    weak var shopCarView : ZFShoppingCarView!;                      //购物车
    
    weak var shopCarCoverBg : UIButton!;                            //购物车弹出后window遮盖背景
    
    weak var shopCarAnimView : UIImageView!                         //购物车抛物线动画view
    
    weak var  showSearvhBarResultView : ZFShowSearchResultView!     //搜索显示窗口
    
    weak var loadingView : ZFLoadingView!                           //加载中显示的view
    
    var badgeValue : Int = 0;                                       //购物车提示信息
    
    var isOpenShopCar : Bool = true;                                //是否打开购物车
    
    var seat_id : Int?;                                             //座位id
    
    var orderSqlite : ZFOrderSqlite!;                               //操作 sqlite 对象
    
    let animateTime : NSTimeInterval = 0.3;                         //购物车移动时间
    
    lazy var menuTitles : Array<ZFMenuTitleModel> = {
        
        //从数据库获取菜单
        let menuSqlite = ZFMenuSqlite();
        
        return menuSqlite.selectMenu();
        
        }()
    
    var orderContents : Array<ZFOrderContentModel> {
        
        set {
            
        }
        get {
        
            var arrayM : Array<ZFOrderContentModel> = self.orderSqlite.selectSeatOrderContent(self.seat_id!);
            
            self.allPrice = self.orderSqlite.selectAllOrderPrice(self.seat_id!);
            
            return arrayM;
        }
    }
    
    var allPrice : CGFloat {
        set {
            self.shopCarView.setAllPrice = newValue;
        }
        
        get {
            
            let allPrice : CGFloat = self.orderSqlite.selectAllOrderPrice(self.seat_id!);
            
            return allPrice;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        //初始化 sqlite 操作对象
        self.orderSqlite = ZFOrderSqlite();

        //初始化self.view上控件
        self.initView();
        
        //获得历史订单条数
        self.getHistoryOrderNumber();
        
    }
    
    //初始化self.view上控件
    func initView(){
        //标题
        self.title = "购物车";
        
        
        //设置购物车
        self.setupShoppingCarView();
        
        //设置菜单内容
        self.setupMenuContentView();
        
        //设置菜单标题
        self.setupMenuTitlelView();
        
        //购物车弹出后window背景
        self.setupShopCarCoverBg();
        
        
        //将 shopCarView 移到view子图层的最上面
        self.view.bringSubviewToFront(self.shopCarView);
        
        //设置self.view的背景颜色
        self.view.backgroundColor = UIColor.whiteColor();
        
        //设置购物车动画
        self.setupShopViewAnim();
        
        
        //设置搜索栏
        self.navigationRightBarSearchBar();
        
        //设置加载中显示的view
        self.setupLoadingView();
        
    }
    
    //设置购物车
    func setupShoppingCarView(){
        
        let shopCar = ZFShoppingCarView();
        shopCar.delegate = self;
        self.view.addSubview(shopCar);
        self.shopCarView = shopCar;
    }
    
    //设置菜单内容
    func setupMenuContentView(){
        let menuContentX : CGFloat = self.view.frame.width * 0.3;
        let menuContentY : CGFloat = 64;
        let menuContentW : CGFloat = self.view.frame.width - menuContentX;
        let menuContentH : CGFloat = self.view.frame.height - menuContentY - self.shopCarView.frame.size.height;

        let menuContent = ZFMenuContentView(frame: CGRectMake(menuContentX, menuContentY, menuContentW, menuContentH));
        
        self.view.addSubview(menuContent);
        self.menuContentView = menuContent;
    }
    
    //设置菜单标题
    func setupMenuTitlelView(){
        let menuTitleX : CGFloat = 0;
        let menuTitleY : CGFloat = CGRectGetMinY(self.menuContentView.frame);
        let menuTitleW : CGFloat = CGRectGetMinX(self.menuContentView.frame);
        let menuTitleH : CGFloat = self.menuContentView.frame.size.height
        
        let menuTitle = ZFMenuTitlelView(frame: CGRectMake(menuTitleX, menuTitleY, menuTitleW, menuTitleH));

        menuTitle.ZFdelegate = self;
        menuTitle.menuTitles = self.menuTitles;
        self.view.addSubview(menuTitle);
        self.menuTitlelView = menuTitle;
    }
    
    //购物车弹出后window背景
    func setupShopCarCoverBg(){
        
        let btnX : CGFloat = 0;
        let btnY : CGFloat = 0;
        let btnW : CGFloat = self.view.frame.width;
        let btnH : CGFloat = self.view.frame.height;
        
        let shopCarCoverBg : UIButton = UIButton(frame: CGRectMake(btnX, btnY, btnW, btnH));

        shopCarCoverBg.backgroundColor = UIColor.blackColor();
        shopCarCoverBg.alpha = 0.2;
        shopCarCoverBg.hidden = self.isOpenShopCar;
        shopCarCoverBg.addTarget(self, action: "shopCarCoverBgClick", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(shopCarCoverBg);
        self.shopCarCoverBg = shopCarCoverBg;
        
    }
    
    //设置购物车动画View
    func setupShopViewAnim(){
        
        let shopCarAnimViewWH : CGFloat = 55;
        let shopCarAnimView: UIImageView = UIImageView(frame: CGRectMake(0, 0, shopCarAnimViewWH, shopCarAnimViewWH));
        shopCarAnimView.backgroundColor = UIColor.redColor();
        shopCarAnimView.layer.cornerRadius = shopCarAnimViewWH * 0.5;
        shopCarAnimView.layer.masksToBounds = true;
        shopCarAnimView.hidden = true
        self.view.addSubview(shopCarAnimView);
        self.shopCarAnimView = shopCarAnimView;
        
    }
    
    //设置搜索栏
    func navigationRightBarSearchBar(){
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "rightBarButtonItemSearchDidClick")
    }
    
    //搜索按钮被点击
    func rightBarButtonItemSearchDidClick(){
        
        
        if (showSearvhBarResultView == nil ) {
            
            //设置搜索窗口
            self.setupShowSearvhBarResultView();
            
        }else {
            
            self.closeShowSearvhBarResultView();
        }
        
    }
    
    //设置搜索窗口
    func setupShowSearvhBarResultView() {
        
        let showSearvhBarResultViewX : CGFloat = 0;
        let showSearvhBarResultViewY : CGFloat = 64;
        let showSearvhBarResultViewW : CGFloat = self.view.frame.width;
        let showSearvhBarResultViewH : CGFloat = self.view.frame.size.height - showSearvhBarResultViewY - self.shopCarView.viewAllowBigH;
        
        //搜索显示窗口
        let showSearvhBarResultView : ZFShowSearchResultView = ZFShowSearchResultView(frame: CGRectMake(showSearvhBarResultViewX, showSearvhBarResultViewY, showSearvhBarResultViewW, showSearvhBarResultViewH));
        
        //将搜索显示窗口插入购物车背景下面
        self.view.insertSubview(showSearvhBarResultView, belowSubview: self.shopCarCoverBg);
        
        self.showSearvhBarResultView = showSearvhBarResultView;
        
        self.hidesNavigationItem(isbackButton: true, isSearchBerClick: true);
        
        //设置键盘通知
        self.setupNSNotificationCenter();
        
    }
    
    //设置键盘通知
    func setupNSNotificationCenter(){
        //键盘通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWiilChangeFrame:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    //设置键盘通知响应键盘弹出事件
    func keyboardWiilChangeFrame(notif : NSNotification ){
        
        let viewH : CGFloat = self.view.bounds.height
        
        let KeyboardFrame : CGRect = notif.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        
        let transformY : CGFloat = KeyboardFrame.origin.y - viewH
        
        self.shopCarView.transform = CGAffineTransformMakeTranslation(0, transformY)
        
    }
    
    //设置加载中显示的view
    func setupLoadingView(){
        
        let loadingView : ZFLoadingView = ZFLoadingView(frame: self.view.frame)
        loadingView.hidden = true;
        self.view.addSubview(loadingView)
        
        self.loadingView = loadingView;
    }
    
    //关闭搜索栏
    func closeShowSearvhBarResultView(){
        
//        UIView.animateWithDuration(2, animations: { () -> Void in
//        });
        //删除搜索显示窗口
//        self.showSearvhBarResultView.frame.origin.y = self.view.frame.size.height;
        self.showSearvhBarResultView.removeFromSuperview();
        
        self.hidesNavigationItem(isbackButton: false, isSearchBerClick: true);
    }

    
    //购物车后透明背景被点击
    func shopCarCoverBgClick(){
        
        //如果是在显示搜索栏功能到操作下
        if self.showSearvhBarResultView == nil{
            
            //显示返回按钮,搜索按钮能点击
            self.hidesNavigationItem(isbackButton: false, isSearchBerClick: true);
        }else{
            
            //隐藏返回按钮,搜索按钮能点击
            self.hidesNavigationItem(isbackButton: true, isSearchBerClick: true);
            
        }
        
        //是否显示购物车旁的总价
        self.shopCarView.allPrice.hidden = self.isOpenShopCar;
        
        //刷新总价格
        self.shopCarView.setAllPrice = self.allPrice;
        
        self.isOpenShopCar = !self.isOpenShopCar;
        
        //是否显示透明背景
        self.shopCarCoverBg.hidden = self.isOpenShopCar;
        
        //添加动画效果
        UIView.animateWithDuration(animateTime, animations: { () -> Void in
            
            //恢复购物车的移动
            self.shopCarView.transform = CGAffineTransformMakeTranslation(0, 0);
        }, completion: { (Bool) -> Void in
            
            //删除购物车的tableView
            self.shopCarView.removeMenuContentView();
            
            //恢复shopCarView背景
            self.shopCarView.backgroundView.hidden = !self.isOpenShopCar
        })
        
    }
    
    //获得历史订单条数
    func getHistoryOrderNumber(){
        
        self.badgeValue += self.orderSqlite.selectOrderAllNumber(self.seat_id!);
        
        //如果有订单，就显示订单的总价
        if self.badgeValue != 0 {
            
            //获得总价并显示
            self.allPrice = self.orderSqlite.selectAllOrderPrice(self.seat_id!);
            
        }

        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //菜单标题被选中
    func menuTitlelView(menuTitlelView: ZFMenuTitlelView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menuContent : Array<ZFMenuContentModel> = self.menuTitles[indexPath.row].menuContents as! Array<ZFMenuContentModel>;
        self.menuContentView.menuContents = menuContent;
    }
    
    //添加订单（点击cell中的增加按钮）
    func menuContentCell(menuContentCell: ZFMenuContentCell, didClickAddBtn: UIButton, orderContent: ZFOrderContentModel) {
        
        
            
        //设置view不能用户进行交互
        self.menuContentView.userInteractionEnabled = false;
        
       
        //得到购物车加餐动画移动起点
        let moveStartPoint : CGPoint = self.moveStartPoint(menuContentCell, didClickAddBtn: didClickAddBtn);
        
        //得到购物车加餐动画移动结束点
        let moveEmdPoint : CGPoint = self.moveEmdPoint();
        
        //设置view的移动起点
        self.shopCarAnimView.frame.origin = moveStartPoint;
        self.shopCarAnimView.hidden = false;
        
        //添加核心动画
        self.shopCarAnimView.image = menuContentCell.iconView.image!;
        self.addShopCarAnim(self.shopCarAnimView, stat: moveStartPoint, end: moveEmdPoint);
        
        //添加菜单
        orderContent.seat_id = self.seat_id;
        self.addOrderContent(orderContent);
        
    }
    
    //添加购物车动画结束后调用
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
        //隐藏shopCarAnimView
        self.shopCarAnimView.hidden = true;
        
        //删除shopCarAnimView中动画
        self.shopCarAnimView.layer.removeAnimationForKey("addShopCarAnim");
        
        //修改购物车图片的提示数字
        self.badgeValue += 1;
        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue;
        
        //刷新总价格
        self.shopCarView.setAllPrice = self.allPrice;
        
        //设置view能用户进行交互
        self.menuContentView.userInteractionEnabled = true;
        
//        println(self.badgeValue)
        
    }

    
    ///添加抛物线动画
    func addShopCarAnim(view : UIView, stat : CGPoint, end : CGPoint){
        
        let moveAnim : CAKeyframeAnimation = CAKeyframeAnimation()
        moveAnim.keyPath = "position";
        
        //路径
        let path : CGMutablePathRef = CGPathCreateMutable();
        //曲线起点
        CGPathMoveToPoint(path, nil, stat.x, stat.y)
        //曲线终点
        CGPathAddQuadCurveToPoint(path, nil, stat.x - 150 , stat.y - 130, end.x, end.y)
        
        //设置移动路径路径
        moveAnim.path = path;
        
        //动画节奏
        moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);

        
        //缩放动画
        let scale : CABasicAnimation = CABasicAnimation()
        scale.keyPath = "transform.scale";
        //缩放倍数
        scale.toValue = 0.4
        
        
        //动画组
        let group : CAAnimationGroup = CAAnimationGroup()
        //动画时间
        group.duration = 0.5;
        //代理
        group.delegate = self;
        //将动画添加进动画组
        group.animations = [moveAnim, scale];
        
        //设置动画完成后不要回到原来多状态
        group.removedOnCompletion = false;
        //保持最新的状态
        group.fillMode = kCAFillModeForwards;
        
        view.layer.addAnimation(group, forKey: "addShopCarAnim")
        
    }
    
    
    //得到购物车加餐动画移动起点
    func moveStartPoint(menuContentCell: ZFMenuContentCell, didClickAddBtn: UIButton) -> CGPoint{

        var moveStartPoint : CGPoint = CGPoint();
        
        //获得被点击cell 的父类
        let menuContentView : ZFMenuContentView = menuContentCell.superview!.superview as! ZFMenuContentView
        
        //获取所点击cell的 indexPath
        let indexPath : NSIndexPath = menuContentView.indexPathForCell(menuContentCell)!;
        //通过 indexPath 获取所点击cell的 rect
        var rect : CGRect = menuContentView.rectForRowAtIndexPath(indexPath);
        
        let btnRect = didClickAddBtn.frame;
        
        moveStartPoint.x = CGRectGetMinX(menuContentView.frame) + btnRect.origin.x;
        moveStartPoint.y = CGRectGetMinY(menuContentView.frame) + rect.origin.y + btnRect.origin.y - menuContentView.contentOffset.y + (menuContentView.frame.size.width == WINDOW_WIDTH ? 44 : 0);
        
        return moveStartPoint
    }
    
    //得到购物车加餐动画移动结束点
    func moveEmdPoint() -> CGPoint{
        var moveEmdPoint : CGPoint = CGPoint();
        
        //获取购物车按钮的最大x值
        moveEmdPoint.x = CGRectGetMaxX(self.shopCarView.shopCarBtn.frame);
        //获取购物车按钮的最小y值
        moveEmdPoint.y = CGRectGetMinY(self.shopCarView.frame)
        
        return moveEmdPoint;
    }
    
    //添加食品购物车
    func addOrderContent (orderContent: ZFOrderContentModel) {
        
        var databaseQueue : ZFFMDatabaseQueue = ZFFMDatabaseQueue.shareInstance();
        
        databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let order = ZFSeatDBTool();
            
            //如果订单存在
            let isOrder : Bool = order.selectSeatOrder(db, order: orderContent);
            if isOrder {
                
                //修改订单
                order.updateSeatOrder(db, order: orderContent,type: .AddBtn);
                
            } else {
                
                //添加订单
                order.insertSeatOrder(db, order: orderContent);
                
            }
        }

    }
    
    //点击了购物车按钮
    func shoppingCarView(shoppingCarView: ZFShoppingCarView, didClickShopCarBtn: ZFShoppingCartBtn) {
        
        
        if self.badgeValue != 0 && self.isOpenShopCar {
            
            //退键盘
            self.view.endEditing(true);
            
            //清除购物车的背景色
            self.shopCarView.backgroundView.hidden = self.isOpenShopCar;
            
            //隐藏返回按钮
            self.hidesNavigationItem(isbackButton: true, isSearchBerClick: false)
            
            //是否显示购物车旁的总价
            self.shopCarView.allPrice.hidden = self.isOpenShopCar;
            
            //打开购物车界面
            self.isOpenShopCar = !self.isOpenShopCar;
            
            //是否显示透明背景
            self.shopCarCoverBg.hidden = self.isOpenShopCar;

            //计算购物车向上移动距离
            let moveY : CGFloat = self.shopCarView.addMenuContentView(self.orderContents);
            
            // 添加动画
            UIView.animateWithDuration(animateTime, animations: { () -> Void in
                //shopCarView 向上移
//                self.shopCarView.transform = CGAffineTransformMakeTranslation(0, -moveY);
                self.shopCarView.transform = CGAffineTransformTranslate(self.shopCarView.transform, 0, -moveY)
 
            })
            
        }
    }
    
    /// isbackButton 是否隐藏返回按钮 isSearchBerClick 搜索按钮是否能点击
    func hidesNavigationItem(#isbackButton : Bool, isSearchBerClick : Bool){
        self.navigationItem.hidesBackButton = isbackButton;
        self.navigationItem.rightBarButtonItem?.enabled = isSearchBerClick;
    }
    
    //点击了显示订单 tabelViewCell 增减按钮调用
    func shoppingCartShowMenuContentCell(menuContentCell: ZFShoppingCartShowMenuContentCell, btnType: ZFShoppingCartShowMenuContentCellBtnType, isRemvoeData: Bool) {
        
        if isRemvoeData {
            
            //删除一条数据
            self.orderSqlite.removeSeatOrder(menuContentCell.orderContent);
            
            if self.orderContents.count == 0 {
                
                self.shopCarCoverBgClick();
                
            }else if CGFloat(self.orderContents.count) * ZFShoppingCartShowMenuContentCellHieght < ZFShoppingCartShowMenuContentViewMaxMoveY {
                
                //刷新表格
                let moveY : CGFloat = self.shopCarView.addMenuContentView(self.orderContents);
                
                //添加动画
                UIView.animateWithDuration(animateTime, animations: { () -> Void in
                    
                    //将shopCarView向下移
                    self.shopCarView.transform = CGAffineTransformMakeTranslation(0, -moveY);
                })
//                println(shopCarView.subviews.count)
                
            }else if CGFloat(self.orderContents.count) * ZFShoppingCartShowMenuContentCellHieght > ZFShoppingCartShowMenuContentViewMaxMoveY{
                
                //刷新表格
                let moveY : CGFloat = self.shopCarView.addMenuContentView(self.orderContents);
            }
            
        }
        
        if btnType == ZFShoppingCartShowMenuContentCellBtnType.AddBtn {
            self.badgeValue += 1;
        }else{
            self.badgeValue -= 1;
        }
        
        //设置提示数字
        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue;
        
        //修改数据
        self.orderSqlite.updateSeatOrder(menuContentCell.orderContent, btnType: btnType);
        
        //刷新购物车显示订单内容tableView的FooterView
        self.reloadMenuContentViewFooterViewAllPrice();
        
        
        
    }
    
    //刷新购物车显示订单内容tableView的FooterView
    func reloadMenuContentViewFooterViewAllPrice(){
        
        //设置总价
        let shopCarFooterView = self.shopCarView.menuContentView?.footerViewForSection(0) as? ZFShopCarFooterView;
        
        shopCarFooterView?.allPrice = self.allPrice;
    }
    
    //点击删除全部按钮
    func shopCarHeaderView(ShopCarHeaderView: ZFShopCarHeaderView, removeAllMenuConutBtn: UIButton) {
        //删除全部数据
        self.orderSqlite.removeAllSeatOrder(self.seat_id!);
        
        //删除标题
        self.badgeValue = 0;
        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue;
        
        //删除购物车
        self.shopCarCoverBgClick();
    }
    
    //刷新购物车FooterView 的 allPrice 
    func shoppingCartShowMenuContentView(showMenuContentView: ZFShoppingCartShowMenuContentView, reloadSectionFooterView: ZFShopCarFooterView) {
        reloadSectionFooterView.allPrice = self.allPrice;
    }
    
    //点击了选好了调用
    func shopCarFooterView(shopCarFooterView: ZFShopCarFooterView, yesSelectBtn: UIButton) {
        
        //定义提示框
        let acttion = UIAlertView(title: "提示您", message: "您要确定要提交订单吗？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定");
        
        //显示提示框
        acttion.show();
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.buttonTitleAtIndex(buttonIndex) == "确定" {
            
            //开始加载
            self.loadingView.statrLoad();
            
            self.postOrderContentsJson();
            
        }
    }
    
    //Post Json
    func postOrderContentsJson(){
        
        let order = ZFOrderHttp();
        
        order.delegate = self;
        
        order.postOrderContentsJsonData(self.orderContents, seat_id: self.seat_id!);
    
    }
    
    //订单成功调用
    func orderHttp(orderHttp: ZFOrderHttp, isOrder: String) {
        
        //结束加载
        self.loadingView.stopLoad();
        
        if isOrder == "successOrder" {
            //删除订单信息
            self.orderSqlite.removeAllSeatOrder(self.seat_id!);
            
            //删除购物车
            self.shopCarCoverBgClick();
            
            //删除标题
            self.badgeValue = 0;
            self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue;
            
            //进入评分界面
            let vc = ZFRatingStarViewController();
            self.navigationController?.pushViewController(vc, animated: true);
            
        }else{
            let label = UILabel();
            label.Toact("订单失败", fontSize: 17, view: self.view);
        }
    }
    
    deinit {
        
        println("ZFSinglePointViewController deinit")
        
    }

}
