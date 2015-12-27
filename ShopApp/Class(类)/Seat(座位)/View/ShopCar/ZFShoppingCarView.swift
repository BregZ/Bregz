//
//  ZFShoppingCarView.swift
//  ShopApp
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFShoppingCarViewDelegate : NSObjectProtocol {
    
    //购物车按钮被点击
    optional func shoppingCarView(shoppingCarView : ZFShoppingCarView , didClickShopCarBtn : ZFShoppingCartBtn)
    
}



class ZFShoppingCarView: UIView {
    

    
    let viewAllowBigH : CGFloat = 50                                //这个tabelView允许的最大高度
    
    weak var shopCarBtn : ZFShoppingCartBtn!                        //购物车按钮
    
    weak var menuContentView : ZFShoppingCartShowMenuContentView!   //订单显示的tableView
    
    weak var allPrice : UILabel!                                    //总价显示
    
    weak var delegate : ZFShoppingCarViewDelegate!                  //代理
    
    weak var backgroundView : UIImageView!                          //背景图片
    
    var setAllPrice : CGFloat {
        set {
            //如果setAllPrice为0，则不显示内容
            if newValue == 0 {
                self.allPrice.text = "";
            } else {
                
                self.allPrice.text = "共￥\(newValue)";
            }
        }
        
        get {
            
            return 0;
        }

    }
    

    init() {

        super.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - self.viewAllowBigH, WINDOW_WIDTH, self.viewAllowBigH));
        
        //设置背景图片
        self.setupBackgroundView();
        
        
        //设置购物车图标
        self.setupAllPriceView();
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置背景图片
    func setupBackgroundView(){
        let backgroundViewX : CGFloat = 0;
        let backgroundViewY : CGFloat = 0;
        let backgroundViewW : CGFloat = self.frame.size.width;
        let backgroundViewH : CGFloat = self.viewAllowBigH - 1 ;
        
        let backgroundView : UIImageView = UIImageView(frame: CGRectMake(backgroundViewX, backgroundViewY, backgroundViewW, backgroundViewH));
        backgroundView.image = UIImage.resizableImage(name: "top_separator");
        self.addSubview(backgroundView);
        
        self.backgroundView = backgroundView;
    }
    
    //设置购物车图标
    func setupShoppingCartBtn(){
        let shopCar : ZFShoppingCartBtn = ZFShoppingCartBtn(frame: CGRectMake(PADDING, -PADDING, self.viewAllowBigH + PADDING, self.viewAllowBigH + PADDING));
        self.shopCarBtn = shopCar;
        self.shopCarBtn!.addTarget(self, action: "shopCarBtnClick:", forControlEvents: UIControlEvents.TouchUpInside);
        self.addSubview(self.shopCarBtn!);
    }
    
    //设置显示总价的label
    func setupAllPriceView(){
        self.setupShoppingCartBtn();
        
        //设置显示总价的label
        let allPrice : UILabel = UILabel();
        allPrice.textColor = UIColor.redColor();
        //设置字体
        allPrice.font = UIFont.systemFontOfSize(24);
        //设置对齐方式
        allPrice.textAlignment = NSTextAlignment.Right;
        self.addSubview(allPrice);
        self.allPrice = allPrice;
    }
    
    //购物车按钮被点击
    func shopCarBtnClick( btn : ZFShoppingCartBtn ) {

        //通知代理
        if self.delegate != nil && self.delegate.respondsToSelector(Selector("shoppingCarView:didClickShopCarBtn:")) {
            self.delegate.shoppingCarView!(self, didClickShopCarBtn: self.shopCarBtn!);
        }
    }
    
    
    //添加显示订单的tableview
    func addMenuContentView(menuContents : Array<ZFOrderContentModel>) -> CGFloat {
        
        //设置显示订单的tableviewY值
        let viewY : CGFloat = self.shopCarBtn.frame.height - PADDING;
        //设置显示订单的tableview真实高值
        let viewTrueH : CGFloat = ZFShoppingCartShowMenuContentCellHieght * CGFloat(menuContents.count) + ZFShoppingCartShowMenuContentViewSectionHeight * 2;
        //设置显示订单的tableview要显示的高值
        let viewH : CGFloat = viewTrueH > ZFShoppingCartShowMenuContentViewMaxMoveY ? ZFShoppingCartShowMenuContentViewMaxMoveY : viewTrueH;
        
        //如果menuContentView为空，创建，如果不为空就继续用
        if self.menuContentView == nil {
            
            //设置显示订单的tableviewX值
            let viewX : CGFloat = 0;
            //设置显示订单的tableview宽值
            let viewW : CGFloat = WINDOW_WIDTH;
            
            //创建显示订单的tableview
            let view : ZFShoppingCartShowMenuContentView = ZFShoppingCartShowMenuContentView(frame: CGRectMake(viewX, viewY, viewW, viewH));
            
            //赋予数据
            view.menuContents = menuContents;
            
            //添加代理
            view.ZFDelegate = UIViewController.viewControllerWithView(self) as! ZFSinglePointViewController;
            
            //保留操作
            self.menuContentView = view;
            
            self.addSubview(view);
            
        }else {
            
            //赋予数据
            self.menuContentView.menuContents = menuContents;
            self.addSubview(self.menuContentView);

        }
        
        //设置显示订单的tableview的frame
        self.frame.size = CGSize(width: WINDOW_WIDTH, height: viewY + viewH);
        
        //判断要返回显示订单的tableview的高度
        if ZFShoppingCartShowMenuContentViewMaxMoveY < viewH {
            return ZFShoppingCartShowMenuContentViewMaxMoveY;
        }
        
        return viewH ;

    }
    
    //将显示订单的tableview从view中删除
    func removeMenuContentView(){
        
        self.menuContentView.removeFromSuperview();
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        //设置总价格的Frame
        self.setAllPriceF(self.allPrice);
    }
    
    //设置总价格的Frame
    func setAllPriceF(allPrice : UILabel){
        let allpriceW : CGFloat = 150;
        let allpriceH : CGFloat = 50;
        let allpriceX : CGFloat = self.frame.size.width - allpriceW - PADDING;
        let allpriceY : CGFloat = 0;
        
        allPrice.frame = CGRectMake(allpriceX, allpriceY, allpriceW, allpriceH);
        
    }

}
