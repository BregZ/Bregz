//
//  ZFShopCarHeaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFShopCarHeaderViewDelegate : NSObjectProtocol {
    optional func shopCarHeaderView(ShopCarHeaderView : ZFShopCarHeaderView, removeAllMenuConutBtn : UIButton)
}

class ZFShopCarHeaderView: UITableViewHeaderFooterView {
    
    weak var titleView : UILabel!             //提示购物车字样
    
    weak var removeAllMenuConutBtn : UIButton!   //删除全部信息
    
    weak var delegate : ZFShopCarHeaderViewDelegate!
    
    //获得一个ZFShopCarHeaderView
    class func shopCarHeaderViewWithTable(tableView : UITableView) -> ZFShopCarHeaderView{
        let shopCarHeaderViewID : String = "headerId"
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(shopCarHeaderViewID) as? ZFShopCarHeaderView
        
        if header == nil {
            header = ZFShopCarHeaderView(reuseIdentifier: shopCarHeaderViewID)
            
        }
        return header!
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //创建提示label
        let title : UILabel = UILabel()
        title.text = "购物车"
        title.textColor = UIColor.lightGrayColor()
        title.font = UIFont.systemFontOfSize(14)
        self.titleView = title
        self.contentView.addSubview(self.titleView)
        
        //创建全部删除的按钮
        let removeAll : UIButton = UIButton()
        //设置文字
        removeAll.setTitle("删除全部", forState: UIControlState.Normal)
        //设置颜色
        removeAll.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        //设置图片
        removeAll.setImage(UIImage(named: "remove_bg"), forState: UIControlState.Normal)
        //设置字体大小
        removeAll.titleLabel!.font = UIFont.systemFontOfSize(14)
        //设置点击调用方法
        removeAll.addTarget(self, action: "removeAllBtnClick", forControlEvents: UIControlEvents.TouchDown)
        self.contentView.addSubview(removeAll)
        self.removeAllMenuConutBtn = removeAll
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        //设置背景
        let view = UIImageView(frame: self.frame)
        view.image = UIImage.resizableImage(name: "shopCar_header_bg")
        self.backgroundView = view
        
        self.setTitleViewF(self.titleView)
        
        self.setRemoveAllMenuConutBtnF(self.removeAllMenuConutBtn)
    }
    
    //提示购物车字样
    func setTitleViewF(title : UILabel){
        let titleW : CGFloat = 80
        let titleH : CGFloat = 20
        let titleX : CGFloat = PADDING
        let titleY : CGFloat = self.frame.height / 3 * 2 - titleH / 2
        
        title.frame = CGRectMake(titleX, titleY, titleW, titleH)
    }
    
    //删除全部信息
    func setRemoveAllMenuConutBtnF(removeAll : UIButton) {
        let removeAllW : CGFloat = 100
        let removeAllH : CGFloat = 20
        let removeAllX : CGFloat = self.frame.width - removeAllW - PADDING
        let removeAllY : CGFloat = self.frame.height / 3 * 2 - removeAllH / 2
        
        removeAll.frame = CGRectMake(removeAllX, removeAllY, removeAllW, removeAllH)
    }
    
    func removeAllBtnClick() {
        //通知代理
        if self.delegate != nil && self.delegate.respondsToSelector(Selector("shopCarHeaderView:removeAllMenuConutBtn:")) {
            self.delegate.shopCarHeaderView!(self, removeAllMenuConutBtn: self.removeAllMenuConutBtn)
        }
    }

}
