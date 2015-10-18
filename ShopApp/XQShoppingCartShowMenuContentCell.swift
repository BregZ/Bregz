//
//  XQShoppingCartShowMenuContentCell.swift
//  ShopApp
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

protocol XQShoppingCartShowMenuContentCellDelegate : NSObjectProtocol {
    func shoppingCartShowMenuContentCell( menuContentCell : XQShoppingCartShowMenuContentCell, btnType: XQShoppingCartShowMenuContentCellBtnType ,isRemvoeData : Bool)
}

let XQShoppingCartShowMenuContentCellHieght : CGFloat = 50

enum XQShoppingCartShowMenuContentCellBtnType : Int {
    case AddBtn
    case SubBtn
}

class XQShoppingCartShowMenuContentCell: UITableViewCell {
    
    static let menuContentCellId : String = "menuContentCellId"
    
    class func shoppingCartShowMenuContentCellWithtableView( tableView : UITableView ) -> XQShoppingCartShowMenuContentCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(menuContentCellId) as? XQShoppingCartShowMenuContentCell
        
        if cell == nil {
            cell = XQShoppingCartShowMenuContentCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: menuContentCellId)
            
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        
        return cell!
    }
    
    //名称
    var nameView : UILabel!

    //价格
    weak var priceView : UILabel!
    
    //数量
    weak var countView : UILabel!
    
    //增加按钮
    weak var addBtn : UIButton!
    
    //减少按钮
    weak var subBtn : UIButton!
    
    let padding : CGFloat = 10
    
    var delegate : XQShoppingCartShowMenuContentCellDelegate!
    
    var _orderContent : XQOrderContentModel!
    
    var orderContent : XQOrderContentModel{
        set{
            self._orderContent = newValue
            
            self.nameView.text = self._orderContent.orderContentName!
            self.priceView.text = "\(self._orderContent.orderContentPrice!)"
            self.countView.text = "\(self._orderContent.orderContentNumber)"
            
        }
        get{
            return self._orderContent
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //名称
        let name : UILabel = UILabel()
        name.backgroundColor = UIColor.greenColor()
        self.nameView = name
        self.contentView.addSubview(self.nameView)
        
        //价格
        let price : UILabel = UILabel()
        price.backgroundColor = UIColor.greenColor()
        self.priceView = price
        self.contentView.addSubview(self.priceView)
        
        //数量
        let count : UILabel = UILabel()
        count.backgroundColor = UIColor.greenColor()
        count.textAlignment = NSTextAlignment.Center
        self.countView = count
        self.contentView.addSubview(self.countView)
        
        //增加按钮
        let add : UIButton = UIButton()
        add.setBackgroundImage(UIImage(named: "addBtn_bg"), forState: UIControlState.Normal)
        add.addTarget(self, action: "addFoodCount:", forControlEvents: UIControlEvents.TouchDown)
        self.addBtn = add
        self.contentView.addSubview(self.addBtn)
        
        //减少按钮
        let sub : UIButton = UIButton()
        sub.setBackgroundImage(UIImage(named: "subBtn_bg"), forState: UIControlState.Normal)
        sub.addTarget(self, action: "subFoodCount:", forControlEvents: UIControlEvents.TouchDown)
        self.subBtn = sub
        self.contentView.addSubview(self.subBtn)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addFoodCount(add : UIButton){
        self._orderContent.orderContentNumber += 1
        self.countView.text = "\(self._orderContent.orderContentNumber)"
        
        //通知代理
//        if delegate != nil && self.delegate.respondsToSelector(Selector("shoppingCartShowMenuContentCell:btnType:isRemvoeData:")){
            self.delegate.shoppingCartShowMenuContentCell(self, btnType: XQShoppingCartShowMenuContentCellBtnType.AddBtn, isRemvoeData: false)
//        }

    }
    
    func subFoodCount(add : UIButton){
        
        self._orderContent.orderContentNumber -= 1
        
        //通知代理
//        if delegate != nil && self.delegate.respondsToSelector(Selector("shoppingCartShowMenuContentCell:btnType:isRemvoeData:")){
            self.delegate.shoppingCartShowMenuContentCell(self, btnType: XQShoppingCartShowMenuContentCellBtnType.SubBtn, isRemvoeData: self._orderContent.orderContentNumber == 0 ? true : false)
//        }
        
        self.countView.text = "\(self._orderContent.orderContentNumber)"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //名称
        self.setNameViewF(self.nameView)
        
        //增加按钮
        self.setAddBtnF(self.addBtn)
        
        //数量
        self.setCountViewF(self.countView)
        
        //减少按钮
        self.setSubBtnF(self.subBtn)
        
        //价格
        self.setPriceViewF(self.priceView)
    }
    
    //名称
    func setNameViewF(name : UILabel){
        
        let nameX : CGFloat = self.padding
        let nameY : CGFloat = 0
        let nameW : CGFloat = 120
        let nameH : CGFloat = self.frame.height
        
        name.frame = CGRectMake(nameX, nameY, nameW, nameH)
    }
    
    //价格
    func setPriceViewF(name : UILabel){
        
        let priceW : CGFloat = 50
        let priceH : CGFloat = self.frame.height
        let priceY : CGFloat = 0
        let priceX : CGFloat = CGRectGetMinX(self.subBtn.frame) - priceW - self.padding
        
        name.frame = CGRectMake(priceX, priceY, priceW, priceH)
    }
    
    //数量
    func setCountViewF(name : UILabel){
        
        let countW : CGFloat = 20
        let countH : CGFloat = self.frame.height
        let countX : CGFloat = CGRectGetMinX(self.addBtn.frame) - countW - self.padding
        let countY : CGFloat = 0
        
        name.frame = CGRectMake(countX, countY, countW, countH)
    }
    
    //增加按钮
    func setAddBtnF(add : UIButton) {
        let addW : CGFloat = 44
        let addH : CGFloat = 44
        let addX : CGFloat = self.frame.width - self.padding - addW
        let addY : CGFloat = (self.frame.height - addH) * 0.5
        
        add.frame = CGRectMake(addX, addY, addW, addH)
    }
    
    //减少按钮
    func setSubBtnF(sub : UIButton) {
        let subW : CGFloat = 44
        let subH : CGFloat = 44
        let subX : CGFloat = CGRectGetMinX(self.countView.frame) - subW - self.padding
        let subY : CGFloat = self.addBtn.frame.origin.y
        
        sub.frame = CGRectMake(subX, subY, subW, subH)
    }
    
}
