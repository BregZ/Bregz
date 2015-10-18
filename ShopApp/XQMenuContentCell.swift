//
//  XQMenuContentCell.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol XQMenuContentCellDelegate : NSObjectProtocol {
    
    optional func menuContentCell(menuContentCell : XQMenuContentCell , didClickAddBtn : UIButton, orderContent : XQOrderContentModel)
    
}

class XQMenuContentCell: UITableViewCell {
    
    var iconView : UIImageView!         //食品图片
    
    var nameView : UILabel!             //食品名称
    
    var measureView : UILabel!          //食品销量
    
    var priceView : UILabel!            //食品价格
    
    var addBtn : UIButton!              //增加按钮
    
    var padding : CGFloat = 10          //间距
    
    var delegate : XQMenuContentCellDelegate?
    
    var _menuContent : XQMenuContentModel?
    
    var menuContent : XQMenuContentModel{
        set{
            self._menuContent = newValue
            self.nameView.text = self._menuContent!.menuContent_name
            self.priceView.text = "\(self._menuContent!.menuContent_price!)"
        }
        get{
            return self._menuContent!
        }
    }
    
    static let menuContentID : String = "menuContentID"
    
    class func menuContentCellWithTableView(tableView : UITableView) -> XQMenuContentCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(menuContentID) as? XQMenuContentCell
        
        if cell == nil {
            
            cell = XQMenuContentCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: menuContentID)
            
//            cell!.selectedBackgroundView = UIImage(named: "")

//            cell!.backgroundView = UIImage(named: "")
        }
        
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //食品图片
        let iocn : UIImageView = UIImageView()
        self.iconView = iocn
        self.contentView.addSubview(self.iconView)
        
        //食品名称
        let name : UILabel = UILabel()
        self.nameView = name
        self.contentView.addSubview(self.nameView)
        
        //食品销量
        self.measureView = UILabel()
        self.contentView.addSubview(self.measureView)
        
        //食品价格
        self.priceView = UILabel()
        self.priceView.textColor = UIColor.redColor()
        self.priceView.font = UIFont.systemFontOfSize(30)
        self.contentView.addSubview(self.priceView)
        
        //增加按钮
        self.addBtn = UIButton()
        self.addBtn.addTarget(self, action: "addBtnDidClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(self.addBtn)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBtnDidClick(addBtn : UIButton) {
        if self.delegate != nil && self.delegate!.respondsToSelector(Selector("menuContentCell:didClickAddBtn:orderContent:")) {
            let orderContent = XQOrderContentModel()
            orderContent.orderContentName = self.nameView.text
            orderContent.orderContentPrice = self.menuContent.menuContent_price as? CGFloat
            self.delegate!.menuContentCell!(self, didClickAddBtn: self.addBtn,orderContent :orderContent)
        }
    }
    
    //食品图片
    func setIconViewF(icon : UIImageView) {
        
        let iconX : CGFloat = self.padding
        let iconY : CGFloat = self.padding
        let iconW : CGFloat = 70
        let iconH : CGFloat = 70
        
        icon.frame = CGRectMake(iconX, iconY, iconW, iconH)
        
        icon.backgroundColor = UIColor.redColor()
        
    }
    
    //食品名称
    func setNameViewF(name : UILabel) {
        let nameX : CGFloat = CGRectGetMaxX(self.iconView.frame) + self.padding
        let nameY : CGFloat = CGRectGetMinX(self.iconView.frame)
        let nameW : CGFloat = 100
        let nameH : CGFloat = 25
        
                
        name.frame = CGRectMake(nameX, nameY, nameW, nameH)
        
        name.backgroundColor = UIColor.redColor()
        
        }
    
    //食品销量
    func setMeasureViewF(measure : UILabel) {
        let measureX : CGFloat = CGRectGetMinX(self.nameView.frame)
        let measureY : CGFloat = CGRectGetMaxY(self.nameView.frame) + padding * 0.5
        let measureW : CGFloat = self.nameView.frame.width
        let measureH : CGFloat = 15
        
        measure.frame = CGRectMake(measureX, measureY, measureW, measureH)
    
        measure.backgroundColor = UIColor.redColor()
        
    }
    
    //食品价格
    func setPriceViewF(price : UILabel){

        let priceX : CGFloat = CGRectGetMinX(self.nameView.frame)
        let priceY : CGFloat = CGRectGetMaxY(self.measureView.frame) + padding * 0.5
        let priceW : CGFloat = self.nameView.frame.width
        let priceH : CGFloat = 20
        
        price.frame = CGRectMake(priceX, priceY, priceW, priceH)
        
        price.backgroundColor = UIColor.blueColor()
       
    }
    
    //增加按钮
    func setAddBtnF(addBtn : UIButton) {

        let addBtnW : CGFloat = 44
        let addBtnH : CGFloat = 44
        let addBtnX : CGFloat = self.frame.width - addBtnW - self.padding
        let addBtnY : CGFloat = self.frame.height - self.padding - addBtnH
        
        addBtn.frame = CGRectMake(addBtnX, addBtnY, addBtnW, addBtnH)
        
        addBtn.backgroundColor = UIColor.redColor()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.setIconViewF(self.iconView)
        
        self.setNameViewF(self.nameView)
        
        self.setMeasureViewF(self.measureView)
        
        self.setPriceViewF(self.priceView)
        
        self.setAddBtnF(self.addBtn)
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
