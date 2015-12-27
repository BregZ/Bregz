//
//  ZFRatingStarViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFRatingStarViewController: UIViewController,ZFRatingStarViewDelegate, ZFEmpHttpDelegate {
    
    weak var titleView : UIImageView!               //提示提交完成
    
    weak var ratingStarView :  ZFRatingStarView!    //评分api
    
    weak var adviceView : UITextView!               //评价内容View
    
    weak var cancelBtn : UIButton!                  //取消按钮
    
    weak var determineBtn : UIButton!               //确定按钮
    
    weak var tapGesture : UITapGestureRecognizer!   //通知
    
    weak var loadingView : ZFLoadingView!           //加载中显示的窗口
    
    var empHttp : ZFEmpHttp!                        //http链接

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化View
        self.initView()
       
        self.navigationController?.navigationBarHidden = true
    }
    
    
    
    //初始化View
    func initView(){
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //提示提交完成图片
        self.setupTitleView()
        
        //评分分界线
        let scoreSeparator : UIView = UIView.addSeparator(PADDING, y: CGRectGetMaxY(self.titleView.frame) + 5)
        self.view.addSubview(scoreSeparator)
        
        //提示文字
        let scoreLabel : UILabel = getAlertView("服务评分: ",y: CGRectGetMaxY(self.titleView.frame))
        self.view.addSubview(scoreLabel)
        
        //星星评分控件
        self.setupRatingStarView(CGRectGetMaxX(scoreLabel.frame))
        
        //评价顶部分界线
        let evaluationSeparatorTop : UIView = UIView.addSeparator(PADDING, y: CGRectGetMaxY(self.ratingStarView.frame) + PADDING )
        self.view.addSubview(evaluationSeparatorTop)
        
        ////提示文字
        let evaluationLabel : UILabel = getAlertView("服务评价: ",y: CGRectGetMaxY(evaluationSeparatorTop.frame))
        self.view.addSubview(evaluationLabel)
        
        //评价底部分界线
        let evaluationSeparatorBottom : UIView = UIView.addSeparator(PADDING, y: CGRectGetMaxY(evaluationLabel.frame))
        self.view.addSubview(evaluationSeparatorBottom)

        //评价内容
        self.setupAdviceView(CGRectGetMaxY(evaluationSeparatorBottom.frame) + PADDING)
        
        //设置两个按钮，确定与消除
        self.setBtn();
        
        self.empHttp = ZFEmpHttp();
        self.empHttp.delegate = self;
        
        //设置键盘通知
        self.setupNSNotificationCenter();
        
        //监听滑动
        self.setupTapGestureRecognizer();
        
        //设置加载中显示的view
        self.setupLoadingView();
//
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
        
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY)
        
    }
    
    //监听滑动
    func setupTapGestureRecognizer(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "userTapRateView:")
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
        self.tapGesture = tapGesture;
    }
    
    
    
    func userTapRateView(gesture : UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    //提示提交完成图片
    func setupTitleView(){
        let titleX : CGFloat = PADDING ;
        let titleY : CGFloat = PADDING * 3;
        let titleW : CGFloat = self.view.frame.width - PADDING * 2;
        let titleH : CGFloat = 200;
        
        let imageView : UIImageView = UIImageView(frame: CGRectMake(titleX, titleY, titleW, titleH))
        
        imageView.image = UIImage(named: "submit_success");
        
        self.view.addSubview(imageView)
        
        self.titleView = imageView

    }
    
    //获得一个提示label
    func getAlertView(name : String,y : CGFloat) -> UILabel {
        let label : UILabel = UILabel(frame: CGRectMake(PADDING, y, 80, 64))
        label.textColor = UIColor.grayColor()
        label.text = name
        
        return label
    }
    
    //初始化星星评分控件
    func setupRatingStarView(x : CGFloat){
        let ratingStarX : CGFloat = x + PADDING;
        let ratingStarY : CGFloat = CGRectGetMaxY(self.titleView.frame) + PADDING;
        let ratingStarW : CGFloat = 200;
        let ratingStarH : CGFloat = 44;
        
        let ratingStarView = ZFRatingStarView(frame: CGRectMake(ratingStarX, ratingStarY, ratingStarW, ratingStarH), numberOfStars: 5)
        ratingStarView.hasAnimation = true;
        //设置默认选中星星数
        ratingStarView.scorePercent = 0;
        self.view.addSubview(ratingStarView)
        self.ratingStarView = ratingStarView
    }
    
    //初始化评价内容View
    func setupAdviceView(y : CGFloat){
        
        let adviceX : CGFloat = PADDING;
        let adviceY : CGFloat = y;
        let adviceW : CGFloat = self.view.frame.width - PADDING * 2;
        let adviceH : CGFloat = 200;
        
        let adviceView = UITextView(frame: CGRectMake(adviceX, adviceY, adviceW, adviceH))
        adviceView.layer.cornerRadius = 5
        adviceView.layer.borderColor = UIColor.lightGrayColor().CGColor
        adviceView.layer.borderWidth = 1
        self.view.addSubview(adviceView)
        self.adviceView = adviceView
    }
    
    //设置按钮
    func setBtn(){
        
        let btnH : CGFloat = 44;
        let btnX : CGFloat = 0;
        let btnY : CGFloat = self.view.frame.size.height - btnH;
        
        let cancelBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        cancelBtn.frame = CGRectMake(btnX, btnY, WINDOW_WIDTH * 0.3 , btnH);
        cancelBtn.setTitle("取消", forState: UIControlState.Normal);
        cancelBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        cancelBtn.backgroundColor = UIColor.lightGrayColor();
        cancelBtn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchDown);
        self.view.addSubview(cancelBtn);
        
        let determineBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        determineBtn.frame = CGRectMake(WINDOW_WIDTH * 0.3, btnY, WINDOW_WIDTH * 0.7, btnH);
        determineBtn.setTitle("确定", forState: UIControlState.Normal);
        determineBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        determineBtn.backgroundColor = UIColor.redColor();
        determineBtn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchDown);
        self.view.addSubview(determineBtn);
    }
    
    //设置加载中显示的view
    func setupLoadingView(){
        
        let loadingView : ZFLoadingView = ZFLoadingView(frame: self.view.frame)
        loadingView.hidden = true;
        self.view.addSubview(loadingView)
        
        self.loadingView = loadingView;
    }
    
    //按钮点击事件调用
    func btnClick(btn : UIButton){
        if btn.titleLabel?.text == "取消" {
            
            //返回到tabBar界面
            self.returnNavigationController();
            
        }else if btn.titleLabel?.text == "确定"{
            
            if self.ratingStarView.scorePercent * 5 == 0 {
                
                let label = UILabel();
                label.Toact("请为服务员评分", fontSize: 17, view: self.view)
                
                return;
            }
            
            //开始加载
            self.loadingView.statrLoad();
            
            let empModel = ZFSaveEmpModel.shareInstance();
            
            //获取评价分数
            let ratingStar = self.ratingStarView.scorePercent * 5;
            
            //获取评价文字
            let text : String = self.adviceView.text;
            
            //调用http方法
            self.empHttp.RatingStarData(empModel.emp_id!, advice: text != "" ? text : nil, ratingStar: ratingStar);
        }

    }
    
    
    
    //返回到tabBar界面
    func returnNavigationController(){
        
        self.navigationController?.navigationBarHidden = false;
        
        let vc = self.navigationController?.viewControllers[0] as! UIViewController;
        self.navigationController?.popToViewController(vc, animated: true);
    }
    
    //收到服务器返回调用方法
    func empHttp(empHttp: ZFEmpHttp, isGradeSuccess isGrade: String) {
        
        //结束加载
        self.loadingView.stopLoad();
        
        if isGrade == "gradeSuccess" {
            
            //返回到tabBar界面
            self.returnNavigationController();
            
        }else if (isGrade == "gradeFailure" || isGrade == "An error occured. "){
            
            //提示提交失败
            let label : UILabel = UILabel();
            label.Toact("提交失败", fontSize: 17, view: self.view);
        }
    }
    
    //隐藏BarHidden
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        
        self.view.removeGestureRecognizer(self.tapGesture);
        
    }

    

}
