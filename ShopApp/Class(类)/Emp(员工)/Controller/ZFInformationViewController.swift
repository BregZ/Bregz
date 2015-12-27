//
//  ZFInformationViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFInformationViewController: UIViewController, ZFInformationViewDelegate, ZFEmpHttpDelegate, UIActionSheetDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZFSetupContentViewDelegate, ZFAboutViewDelegate {
    
    //Http 工具类
    var empHttp : ZFEmpHttp!;
    
    //tableView 头部Vew
    weak var headerView : ZFEmpheaderView!;
    
    //显示员工排名tableView
    weak var tableView : ZFInformationView!
    
    //自定义显示刷新的titleView
    weak var navTitleView : ZFNavTitleView!
    
    //关于窗口
    weak var aboutView : ZFAboutView!
    
    var quitAction : UIActionSheet!
    
    var headerAction : UIActionSheet!
    
    let headerHeight : CGFloat = 270;
    
    lazy var emp : ZFEmpModel = {
        
        let emp : ZFEmpModel = ZFEmpModel()
        return emp
        
        }();
    
    weak var setupContentView : ZFSetupContentView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化view
        self.initView()


        
    }
    
    //初始化view
    func initView(){
        
        //设置窗口内容
        self.setupTabaleView();
        
        //设置窗口内容头部
        self.setupTabaleHeaderView();
        
        //添加刷新功能
        self.addRefreshControl();
        
        //添加导航栏右边按钮
        self.addRightBarButtonItem();
        
        //添加自定义标题
        self.addNavTitleView();
        
        //设置退出提示
        self.setupQiutAction();
        
        //设置网络连接累
        self.setupEmpHttp();
        
        //设置头像点击提示
        self.setupHeaderaction();
    }
    
    //设置窗口内容
    func setupTabaleView(){
        let tableView = ZFInformationView(frame: self.view.frame);
        tableView.moveDelegate = self;
        self.view.addSubview(tableView);
        self.tableView = tableView;
    }
    
    //设置窗口内容头部
    func setupTabaleHeaderView(){
        //头部view
        let headerView = ZFEmpheaderView(frame: CGRectMake(0, 0, self.view.frame.width, headerHeight));
        headerView.headImageView.setGestureRecognizer(self, action: "headerImageClick");
        self.tableView.tableHeaderView = headerView;
        self.headerView = headerView;
    }
    
    
    //view显示完毕
    override func viewDidAppear(animated: Bool) {
        //刷新数据
        self.reloadEmpData();
    }
    
    //头像图标被点击
    func headerImageClick(){
        
        if self.setupContentView != nil {
            
            self.setupContentView!.removeFromSuperview();
        }
        
        
        
        self.headerAction.showInView(self.view);
    }
    
    //设置头像点击提示
    func setupHeaderaction(){
        
        //创建提示框
        let headerAction : UIActionSheet = UIActionSheet();
        headerAction.addButtonWithTitle("取消");
        headerAction.addButtonWithTitle("拍照");
        headerAction.addButtonWithTitle("相册");
        headerAction.cancelButtonIndex = 0;
        
        headerAction.delegate = self;
        
        self.headerAction = headerAction
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        //actionSheet的title
        let actionSheetTitle : String = actionSheet.buttonTitleAtIndex(buttonIndex);
        
        if actionSheet == self.headerAction {
            
            switch (actionSheetTitle) {
                
                
            case "拍照":
                
                break;
                
            case "相册":
                self.LocalPhoto();
                break;
            case "取消":
                break;
            default :
                println("没有此选项")
                
            }
            
        }else if actionSheet == self.quitAction {
            
            switch (actionSheetTitle) {
                
            case "退出":
                
                //退出登录
                self.quitLogin(actionSheet);
  
                break;
            case "取消":
                break;
            default :
                println("没有此选项")
            }
            
        }
    }
    
    //打开相册
    func LocalPhoto(){
        let picker : UIImagePickerController = UIImagePickerController();
        
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = true;
        
        self.presentViewController(picker, animated: true, completion: nil);
    }
    
    //当选择一张图片后进入这里
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let dict : Dictionary = info as Dictionary;
        
        
        let type : NSString = info[UIImagePickerControllerMediaType] as! NSString;
        
        if type.isEqualToString("public.image") {
            var image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage;

            headerView.headImageView.headImage = image;
            
            
            //保存图片
            let empPlist : ZFEmpTool = ZFEmpTool();
            empPlist.saveEmpHeaderImage(image);
        }
        picker.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    //添加刷新功能
    func addRefreshControl() {
        
        self.tableView.addHeaderWithTarget(self, action: "reloadEmpData")
        
    }
    
    //刷新数据方法
    func reloadEmpData(){
        
        self.navTitleView.titleBeginRefreshing();
        
        let empMedol = ZFSaveEmpModel.shareInstance();
        
        empHttp.selectEvenEmpData(empMedol.emp_id);
        
        empHttp.selectEmpRankData();
        
    }
    
    //添加右边按钮
    func addRightBarButtonItem(){
        //添加设置按钮
        let rightBarButtonItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "emp_setup_barItem_bg"), style: UIBarButtonItemStyle.Plain, target: self, action: "rightBarButtonItemDidClick:");
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
    
    //导航栏右边的ButtonItem被点击
    func rightBarButtonItemDidClick(rightBarButtonItem : UIBarButtonItem){
        
        if self.setupContentView == nil {
            
            if self.aboutView != nil {
                self.aboutView.removeFromSuperview();
                
                //显示tabbar
                self.tabBarController?.tabBar.hidden = false
            }
            
            let setupContentW : CGFloat = 150;
            let setupContentX : CGFloat = WINDOW_WIDTH - PADDING - setupContentW - 5;
            let setupContentY : CGFloat = 64;
            
            let setupContentView : ZFSetupContentView = ZFSetupContentView(frame: CGRectMake(setupContentX, setupContentY, setupContentW, 0));
            setupContentView.setupContentViewdelegate = self;
            
            self.view.addSubview(setupContentView)
            
            self.setupContentView = setupContentView;
        }else {
            
            self.setupContentView?.removeFromSuperview();
            

        }
        
        
    }
    
    //设置退出提示
    func setupQiutAction(){
        
        let quitAction : UIActionSheet = UIActionSheet()
        
        quitAction.title = "请您确定要退出吗？";
        quitAction.delegate = self;
        quitAction.addButtonWithTitle("退出");
        quitAction.addButtonWithTitle("取消");
        quitAction.destructiveButtonIndex = 0;
        quitAction.cancelButtonIndex = 1;

        self.quitAction = quitAction;
    }
    
    //设置网络连接类
    func setupEmpHttp(){
        
        self.empHttp = ZFEmpHttp();
        self.empHttp.delegate = self;
    }
    
    //员工评分表移动调用
    func informationView(informationView: ZFInformationView, tableViewBeginMove move: CGPoint) {
        if self.setupContentView != nil {
            
            self.setupContentView!.removeFromSuperview();
        }
      
        if move.y < -NAV_HEIGHT && move.y >= -(NAV_HEIGHT + 64) {
            
            let moveY : CGFloat = -NAV_HEIGHT - move.y;
            
            self.headerView.iconView.frame.origin.y = -moveY;
            self.headerView.iconView.frame.size.height = self.headerHeight + moveY;
            
        }
    }
    
    //选项栏被点击
    func setupContentView(setupContentView: ZFSetupContentView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            //关于按钮

            //展示tabBar
            self.tabBarController?.tabBar.hidden = true;
            
            let aboutView : ZFAboutView = ZFAboutView(frame: self.view.bounds);
            aboutView.delegate = self
            self.aboutView = aboutView
            self.view.addSubview(aboutView)
            
        }else if indexPath.row == 1 {
            //退出按钮
 
            self.quitAction.showInView(self.view);
            
        }
        
        self.setupContentView!.removeFromSuperview();
    }
    
    func aboutView(aboutView: ZFAboutView, closeButtonDidClick closeBtn: UIButton) {
        
        //展示tabBar
        self.tabBarController?.tabBar.hidden = false;
    }
    
    //退出登录
    func quitLogin(actionSheet: UIActionSheet){
        
        var saveLoginEmp : ZFSaveLoginEmpModel = ZFSaveLoginEmpModel();
        let emp_id = ZFSaveEmpModel.shareInstance().emp_id;
        saveLoginEmp.emp_id = emp_id
        saveLoginEmp.isLoginState = false;
        
        let tool : ZFEmpTool = ZFEmpTool();
        tool.insertSaveEmp(saveLoginEmp);
        
        self.view.window!.rootViewController = ZFLoginViewController();
        
        
        
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
        // Dispose of any resources that can be recreated.
    }
    
    //刷新头像数据
    func empHttp(empHttp: ZFEmpHttp, reloadEmpModel: ZFEmpModel) {
        
        self.headerView.emp = reloadEmpModel;
        
    }
    
    //星级数据获取完成，刷新表格
    func empHttp(empHttp: ZFEmpHttp, reloadEmpRank empM: Array<ZFEmpModel>?) {
        
        if empM != nil {
            
            self.tableView.emps = empM!

        }
        
        //结束刷新
        self.tableView.headerEndRefreshing();
        self.navTitleView.titleEndRefreshing();
    }
    
    deinit {
        println("ZFInformationViewController deinit");
    }

    
}
