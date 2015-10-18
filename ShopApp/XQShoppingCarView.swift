//
//  XQShoppingCarView.swift
//  ShopApp
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol XQShoppingCarViewDelegate : NSObjectProtocol {
    
    //购物车按钮被点击
    optional func shoppingCarView(shoppingCarView : XQShoppingCarView , didClickShopCarBtn : XQShoppingCartBtn)
    
}

let XQShoppingCartShowMenuContentViewMaxMoveY : CGFloat = UIScreen.mainScreen().bounds.height * 0.7 //XQShoppingCarView中XQShoppingCartShowMenuContentView最大移动Y值

class XQShoppingCarView: UIView {
    
    let viewW : CGFloat = UIScreen.mainScreen().bounds.width        //屏幕宽度
    
    let viewH : CGFloat = 50                                        //高度
    
    weak var shopCarBtn : XQShoppingCartBtn!                        //购物车按钮
    
    var delegate : XQShoppingCarViewDelegate!
    
    weak var menuContentView : XQShoppingCartShowMenuContentView!   //订单显示的tableView
    
    let padding : CGFloat = 10                                      //间距

    init() {

        super.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - self.viewH, self.viewW, self.viewH))
        
        self.backgroundColor = UIColor.grayColor()
        
        let shopCar : XQShoppingCartBtn = XQShoppingCartBtn(frame: CGRectMake(10, -self.padding, viewH + self.padding, viewH + self.padding))
        self.shopCarBtn = shopCar
        self.shopCarBtn!.addTarget(self, action: "shopCarBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.shopCarBtn!)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shopCarBtnClick( btn : XQShoppingCartBtn ) {
        if self.delegate != nil && self.delegate.respondsToSelector(Selector("shoppingCarView:didClickShopCarBtn:")) {
            self.delegate.shoppingCarView!(self, didClickShopCarBtn: self.shopCarBtn!)
        }
    }
    
    
    func addMenuContentView(menuContents : Array<XQOrderContentModel>) -> CGFloat {
        
        let viewX : CGFloat = 0
        let viewY : CGFloat = self.shopCarBtn.frame.height - self.padding
        let viewW : CGFloat = self.viewW
        let viewH : CGFloat = XQShoppingCartShowMenuContentCellHieght * CGFloat(menuContents.count) + XQShoppingCartShowMenuContentViewSectionHeight * 2

        let view : XQShoppingCartShowMenuContentView = XQShoppingCartShowMenuContentView(frame: CGRectMake(viewX, viewY, viewW, viewH))
        
        view.menuContents = menuContents
        
        self.menuContentView = view
        
        self.addSubview(self.menuContentView)
        
        self.frame.size = CGSize(width: viewW, height: viewY + viewH)
        
        
        if XQShoppingCartShowMenuContentViewMaxMoveY < viewH {
            return XQShoppingCartShowMenuContentViewMaxMoveY
        }
        
        return viewH 

    }
    
    func removeMenuContentView(){
        
        self.menuContentView.removeFromSuperview()
        
    }

}
