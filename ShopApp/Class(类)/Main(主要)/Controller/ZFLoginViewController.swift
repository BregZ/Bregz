//
//  ZFLoginViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFLoginViewController: UIViewController,ZFEmpHttpDelegate {
    
    weak var empNameView : UITextField!                 //用户名输入框
    
    weak var empPwdView : UITextField!                  //用户密码输入框
    
    weak var headImageView : ZFHeaPortraitView! ;       //头像
    
    weak var loginBtn : UIButton!                       //登录按钮
    
    weak var loadingView : ZFLoadingView?               //加载过程显示的view
    
    weak var tapGesture : UITapGestureRecognizer!       //手势识别器
    
    var empHttp : ZFEmpHttp!                            //员工数据模型
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSThread.sleepForTimeInterval(0.5)      //延长3秒

        //初始化控件
        self.initView()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //读取保存的员工信息
        self.readSaveEmp();
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
//
    func initView(){
        
        self.view.backgroundColor = UIColor.whiteColor();
 
        //设置头像
        self.setUpHeadImageView()
        
        //输入用户名
        self.setEmpNameView();
        
        //输入密码
        self.setEmpPwdView();
        
        //登录按钮
        self.setLoginBtn();

        //设置手势识别器
        self.setTapGesture();
        
        //设置加载中显示的view
        self.setupLoadingView();
        
        //设置仿导航栏窗口
        self.setTitleView();
        
        //设置网络连接类
        self.setupEmpHttp();
        
    }
    
    //设置仿导航栏窗口
    func setTitleView(){
        let titleX : CGFloat = 0;
        let titleY : CGFloat = 0;
        let titleW : CGFloat = self.view.frame.size.width;
        let titleH : CGFloat = 64;
        
        let titleView : UIView = UIView(frame: CGRectMake(titleX, titleY, titleW, titleH));
        titleView.backgroundColor = THEME_COLOR;
        
        let titleText : UILabel = setTitleText();
        
        titleView.addSubview(titleText);
        
        self.view.addSubview(titleView);
    }
    
    //设置仿导航栏标题文字
    func setTitleText() -> UILabel{
        let titleX : CGFloat = 0;
        let titleY : CGFloat = 20;
        let titleW : CGFloat = self.view.frame.size.width;
        let titleH : CGFloat = 44;
        
        
        let titleView : UILabel = UILabel(frame: CGRectMake(titleX, titleY, titleW, titleH));
        titleView.textAlignment = NSTextAlignment.Center
        titleView.font = UIFont.boldSystemFontOfSize(17)
        titleView.text = "登录";
        titleView.textColor = UIColor.whiteColor();
        
        return titleView
    }
    
    //设置头像
    func setUpHeadImageView(){
        
        let headImage : ZFHeaPortraitView = ZFHeaPortraitView(y: 80);
        self.view.addSubview(headImage)
        
        self.headImageView = headImage;
    }
    
    //输入用户名
    func setEmpNameView(){
        let nameX : CGFloat = 20;
        let nameY : CGFloat = 250;
        let nameW : CGFloat = self.view.frame.size.width - nameX * 2;
        let nameH : CGFloat = 44;
        
        let nameView : UITextField = UITextField(frame: CGRectMake(nameX, nameY, nameW, nameH));
        nameView.placeholder = "请输入您的账号";
        nameView.clearButtonMode = UITextFieldViewMode.Always
        nameView.borderStyle = UITextBorderStyle.RoundedRect;
        
        self.view.addSubview(nameView);
        
        self.empNameView = nameView;
    }
    
    //输入密码
    func setEmpPwdView(){
        let pwdX : CGFloat = 20;
        let pwdY : CGFloat = CGRectGetMaxY(self.empNameView.frame) + 20;
        let pwdW : CGFloat = self.empNameView.frame.width;
        let pwdH : CGFloat = 44;
        
        let pwdView : UITextField = UITextField(frame: CGRectMake(pwdX, pwdY, pwdW, pwdH))
        pwdView.placeholder = "请输入您的密码";
        pwdView.secureTextEntry = true;
        pwdView.clearButtonMode = UITextFieldViewMode.Always
        pwdView.borderStyle = UITextBorderStyle.RoundedRect;
        
        self.view.addSubview(pwdView);
        
        self.empPwdView = pwdView;
        
    }
    
    //登录按钮
    func setLoginBtn(){
        let btnX : CGFloat = 20;
        let btnY : CGFloat = CGRectGetMaxY(self.empPwdView.frame) + 20;
        let btnW : CGFloat = self.empNameView.frame.width;
        let btnH : CGFloat = 44;
        
        let loginView : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        loginView.frame = CGRectMake(btnX, btnY, btnW, btnH);
        loginView.backgroundColor = THEME_MIN_COLOR;
        loginView.layer.cornerRadius = 5
        loginView.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginView.setTitle("登录", forState: UIControlState.Normal);
        loginView.setTitle("登录中...", forState: UIControlState.Selected);
        loginView.addTarget(self, action: "loginBtnClick", forControlEvents: UIControlEvents.TouchDown)
        
        
        self.view.addSubview(loginView);
        self.loginBtn = loginView;
    }
    
    //登录按钮被点击调用
    func loginBtnClick(){
        self.userTapRateView();
        let label : UILabel = UILabel()
        
        if (self.empNameView.text == "" ) {
            
            label.Toact("您的账号不能为空", fontSize: 17, view: self.view)
            return;
            
        }else if (self.empPwdView.text == "" ){
            
            label.Toact("您的密码不能为空", fontSize: 17, view: self.view)
            return;
        }
        
        //链接网络
        self.empHttp.LoginEmpData(self.empNameView.text, pwd: self.empPwdView.text);
        
        //开始加载
        self.statrLoad();
    }
    
    //设置加载中显示的view
    func setupLoadingView(){
        
        let loadingView : ZFLoadingView = ZFLoadingView(frame: self.view.frame)
        loadingView.hidden = true;
        self.view.addSubview(loadingView)
        
        self.loadingView = loadingView;
    }
    
    //开始加载
    func statrLoad(){
        self.loadingView?.hidden = false;
        self.loadingView?.doubleBounce.startAnimating();
    }
    
    //结束加载
    func stopLoad(){
        self.loadingView?.hidden = true;
        self.loadingView?.doubleBounce.stopAnimating();
    }

    //设置网络连接类
    func setupEmpHttp(){
        
        self.empHttp = ZFEmpHttp();
        self.empHttp.delegate = self;
        
    }
    
    //登录是否成功
    func empHttp(empHttp: ZFEmpHttp, isLoginSuccess isLogin: String) {
        
        //结束加载
        self.stopLoad();
        
        if (isLogin == "loginSuccess") {
            
            //保存员工id
            let empid : Int = self.empNameView.text.toInt()!;
            self.saveEmpId(empid);
            
            //存储用户信息
            self.saveEmp();
            
            //进入下一个界面
            self.nextViewController(true);
            
            self.empPwdView.text = nil
            
            
        } else if (isLogin == "loginFailure") {
            let label = UILabel()
            label.Toact("您的账号或密码错误", fontSize: 17, view: self.view)
        }else {
            let label = UILabel()
            label.Toact("找不到服务器", fontSize: 17, view: self.view)
        }
        
    }
    
    //保存员工id
    func saveEmpId(emp_id : Int){

        let saveEmp = ZFSaveEmpModel.shareInstance();
        saveEmp.emp_id = emp_id;
    }
    
    //存储用户信息
    func saveEmp(){
        let tool : ZFEmpTool = ZFEmpTool();
        
        let saveEmp : ZFSaveLoginEmpModel = self.newInest();
        
        tool.insertSaveEmp(saveEmp);
    }
    
    func newInest() -> ZFSaveLoginEmpModel{
        let saveEmp : ZFSaveLoginEmpModel = ZFSaveLoginEmpModel()
        saveEmp.emp_id = self.empNameView.text.toInt();
        saveEmp.isLoginState = true;
        
        return saveEmp;
    }
    
    //进入下一个界面
    func nextViewController(animated: Bool){
//        let vc = ZFTabBarViewController();
//        self.presentViewController(vc, animated: animated, completion: nil);
        
        //选择跟根控制器
        ZFShopTool.selectRootViewContrller()
    }
    
    //设置手势识别器
    func setTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: "userTapRateView")
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
        self.tapGesture = tapGesture
    }
    
    func userTapRateView(){
        self.view.endEditing(true)
    }
    
    //读取保存的员工信息
    func readSaveEmp(){
        let tool : ZFEmpTool = ZFEmpTool();
        
        let saveEmps : Array<ZFSaveLoginEmpModel>? = tool.selectSaveEmp()
        
        if saveEmps != nil {
            
            let saveEmp : ZFSaveLoginEmpModel = saveEmps![0]
            
            let emd_id : Int = saveEmp.emp_id
            
            //设置自定义图片
            self.setupheaderImage(emd_id);
            
            //设置保存的登录信息
            self.setupShowSaveLogin(emd_id);
            
        }else{
            
            self.setupDefaultheadImage();
        }
    }
    
    //设置自定义图片
    func setupheaderImage(empId: Int){
        
        let empPlist : ZFEmpTool = ZFEmpTool();
        let headerImage = empPlist.selectIsHeaderImage(empId);
        
        if headerImage != nil {
            
            self.headImageView.headImage = headerImage!
            
        }else{
            
            self.setupDefaultheadImage();
        }
    }
    
    func setupDefaultheadImage(){
        
        self.headImageView.headImageName = "head";
    }
    
    func setupShowSaveLogin(empId: Int){
        
        let empidStr : String = "\(empId)";
        
        self.empNameView.text = empidStr;
    }
    
    deinit {
        
        //删除手势识别器
        self.view.removeGestureRecognizer(self.tapGesture);
        
        println(" ZFLoginViewController deinit")
    }
    

}
