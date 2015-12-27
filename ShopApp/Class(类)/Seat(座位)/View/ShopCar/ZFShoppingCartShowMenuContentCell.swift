//
//  ZFShoppingCartShowMenuContentCell.swift
//  ShopApp
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

protocol ZFShoppingCartShowMenuContentCellDelegate : NSObjectProtocol {
    func shoppingCartShowMenuContentCell( menuContentCell : ZFShoppingCartShowMenuContentCell, btnType: ZFShoppingCartShowMenuContentCellBtnType ,isRemvoeData : Bool)
}

class ZFShoppingCartShowMenuContentCell: UITableViewCell {
    
    static let menuContentCellId : String = "menuContentCellId";
    
    class func shoppingCartShowMenuContentCellWithtableView( tableView : UITableView ) -> ZFShoppingCartShowMenuContentCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(menuContentCellId) as? ZFShoppingCartShowMenuContentCell;
        
        if cell == nil {
            cell = ZFShoppingCartShowMenuContentCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: menuContentCellId);
            
            cell!.selectionStyle = UITableViewCellSelectionStyle.None;
        }
        
        return cell!;
    }
    
    //名称
    var nameView : UILabel!;

    //价格
    weak var priceView : UILabel!;
    
    //数量
    weak var countView : UILabel!;
    
    //增加按钮
    weak var addBtn : UIButton!;
    
    //减少按钮
    weak var subBtn : UIButton!;

    //自定义代理
    weak var delegate : ZFShoppingCartShowMenuContentCellDelegate!;
    
    var _orderContent : ZFOrderContentModel!;
    
    var orderContent : ZFOrderContentModel{
        set{
            self._orderContent = newValue;
            
            self.nameView.text = self._orderContent.orderContentName!;
            self.priceView.text = "￥\(CGFloat(self._orderContent.orderContentPrice!) * CGFloat(self._orderContent.orderContentNumber))";
            self.countView.text = "\(self._orderContent.orderContentNumber)";
            
        }
        get{
            return self._orderContent;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        //名称
        let name : UILabel = UILabel();
        self.contentView.addSubview(name);
        self.nameView = name;
        
        //价格
        let price : UILabel = UILabel();
        price.textColor = UIColor.redColor();
        self.contentView.addSubview(price);
        self.priceView = price;
        
        //数量
        let count : UILabel = UILabel();
        count.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(count);
        self.countView = count;
        
        //增加按钮
        let add : UIButton = UIButton();
        add.setBackgroundImage(UIImage(named: "addBtn_bg"), forState: UIControlState.Normal);
        add.addTarget(self, action: "addFoodCount:", forControlEvents: UIControlEvents.TouchDown);
        self.contentView.addSubview(add);
        self.addBtn = add;
        
        //减少按钮
        let sub : UIButton = UIButton()
        sub.setBackgroundImage(UIImage(named: "subBtn_bg"), forState: UIControlState.Normal);
        sub.addTarget(self, action: "subFoodCount:", forControlEvents: UIControlEvents.TouchDown);
        self.contentView.addSubview(sub);
        self.subBtn = sub;
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addFoodCount(add : UIButton){
        //菜单数量加1
        self._orderContent.orderContentNumber += 1;
        //设置新的菜数量
        self.countView.text = "\(self._orderContent.orderContentNumber)";
        //设置新的价格
        self.priceView.text = "￥\(CGFloat(self._orderContent.orderContentNumber) * self.orderContent.orderContentPrice!)";
        
        
        
        //通知代理
//        if delegate != nil && self.delegate.respondsToSelector(Selector("shoppingCartShowMenuContentCell:btnType:isRemvoeData:")){
        self.delegate.shoppingCartShowMenuContentCell(self, btnType: ZFShoppingCartShowMenuContentCellBtnType.AddBtn, isRemvoeData: false);
//        }
        
    }
    
    func subFoodCount(add : UIButton){
        
        //菜单数量减1
        self._orderContent.orderContentNumber -= 1;
        //设置新的菜数量
        self.countView.text = "\(self._orderContent.orderContentNumber)";
        //设置新的价格
        self.priceView.text = "￥\(CGFloat(self._orderContent.orderContentNumber) * self.orderContent.orderContentPrice!)";
        
        //通知代理
//        if delegate != nil && self.delegate.respondsToSelector(Selector("shoppingCartShowMenuContentCell:btnType:isRemvoeData:")){
        self.delegate.shoppingCartShowMenuContentCell(self, btnType: ZFShoppingCartShowMenuContentCellBtnType.SubBtn, isRemvoeData: self._orderContent.orderContentNumber == 0 ? true : false);
//        }
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        //名称
        self.setNameViewF(self.nameView);
        
        //增加按钮
        self.setAddBtnF(self.addBtn);
        
        //数量
        self.setCountViewF(self.countView);
        
        //减少按钮
        self.setSubBtnF(self.subBtn);
        
        //价格
        self.setPriceViewF(self.priceView);
    }
    
    //名称
    func setNameViewF(name : UILabel){
        
        let nameX : CGFloat = PADDING;
        let nameY : CGFloat = 0;
        let nameW : CGFloat = 150;
        let nameH : CGFloat = self.frame.height;
        
        name.frame = CGRectMake(nameX, nameY, nameW, nameH);
    }
    
    //价格
    func setPriceViewF(name : UILabel){
        
        let priceW : CGFloat = 70;
        let priceH : CGFloat = self.frame.height;
        let priceY : CGFloat = 0;
        let priceX : CGFloat = CGRectGetMinX(self.subBtn.frame) - priceW;
        
        name.frame = CGRectMake(priceX, priceY, priceW, priceH);
    }
    
    //数量
    func setCountViewF(name : UILabel){
        
        let countW : CGFloat = 20;
        let countH : CGFloat = self.frame.height;
        let countX : CGFloat = CGRectGetMinX(self.addBtn.frame) - countW - PADDING;
        let countY : CGFloat = 0;
        
        name.frame = CGRectMake(countX, countY, countW, countH);
    }
    
    //增加按钮
    func setAddBtnF(add : UIButton) {
        let addW : CGFloat = 34;
        let addH : CGFloat = 34;
        let addX : CGFloat = self.frame.width - PADDING - addW;
        let addY : CGFloat = (self.frame.height - addH) * 0.5;
        
        add.frame = CGRectMake(addX, addY, addW, addH);
    }
    
    //减少按钮
    func setSubBtnF(sub : UIButton) {
        let subW : CGFloat = 34;
        let subH : CGFloat = 34;
        let subX : CGFloat = CGRectGetMinX(self.countView.frame) - subW - PADDING;
        let subY : CGFloat = self.addBtn.frame.origin.y;
        
        sub.frame = CGRectMake(subX, subY, subW, subH);
    }
    
}
