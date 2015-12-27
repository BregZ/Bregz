//
//  ZFShopCarFooterView.swift
//  ShopApp
//
//  Created by mac on 15/10/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFShopCarFooterViewDelegate : NSObjectProtocol {
    
    optional func shopCarFooterView(shopCarFooterView : ZFShopCarFooterView , yesSelectBtn : UIButton)
    
}

class ZFShopCarFooterView: UITableViewHeaderFooterView {
    
    weak var priceAllView : UILabel!;              //总价
    
    weak var yesSelectBtn : UIButton!;              //确定选择
    
    weak var delegate : ZFShopCarFooterViewDelegate!;
    
    var _allPrice : CGFloat?;
    
    var allPrice : CGFloat {
        set {
            //更新总价
            self._allPrice = newValue;
            self.priceAllView.text = "共￥\(self.allPrice)";
        }
        get {
            return self._allPrice!;
        }
    }

    //获得ZFShopCarFooterView
    class func shopCarFooterViewWithTable(tableView : UITableView) -> ZFShopCarFooterView{
        let shopCarHeaderViewID : String = "FootId";
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(shopCarHeaderViewID) as? ZFShopCarFooterView;
        
        if header == nil {
            header = ZFShopCarFooterView(reuseIdentifier: shopCarHeaderViewID);
            
        }
        return header!;
    }
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //创建总价
        let priceAll : UILabel = UILabel();
        priceAll.textColor = UIColor.redColor();
        self.contentView.addSubview(priceAll);
        self.priceAllView = priceAll;
        
        //创建选好按钮
        let yesSelect : UIButton = UIButton();
        //设置背景色
        yesSelect.backgroundColor = UIColor.redColor();
        //设置文字
        yesSelect.setTitle("选好了", forState: UIControlState.Normal);
        //设置点击方法
        yesSelect.addTarget(self, action: "yesSelectDidClick", forControlEvents: UIControlEvents.TouchDown);
        self.addSubview(yesSelect);
        self.yesSelectBtn = yesSelect;
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        
        //设置全部订单价格的frame
        self.setPriceAllViewF(self.priceAllView);
        
        //设置选好了按钮的frame
        self.setYesSelectBtnF(self.yesSelectBtn);
    }
    
    //设置全部订单价格的frame
    func setPriceAllViewF(priceAll : UILabel){
        let priceAllX : CGFloat = PADDING;
        let priceAllY : CGFloat = 0;
        let priceAllH : CGFloat = self.frame.height;
        let priceAllW : CGFloat = 200;
        
        priceAll.frame = CGRectMake(priceAllX, priceAllY, priceAllW, priceAllH);
    }
    
    //设置选好了按钮的frame
    func setYesSelectBtnF(yesSelect : UIButton){
        let yseSelectW : CGFloat = 110;
        let yseSelectH : CGFloat = self.frame.height;
        let yseSelectX : CGFloat = self.frame.width - yseSelectW;
        let yseSelectY : CGFloat = 0;
        
        yesSelect.frame = CGRectMake(yseSelectX, yseSelectY, yseSelectW, yseSelectH);
    }
    
    //选好了 按钮被点击
    func yesSelectDidClick(){
        //通知代理
        if self.delegate != nil && self.delegate.respondsToSelector(Selector("shopCarFooterView:yesSelectBtn:")) {
            self.delegate.shopCarFooterView!(self, yesSelectBtn: self.yesSelectBtn);
        }
    }
    

}
