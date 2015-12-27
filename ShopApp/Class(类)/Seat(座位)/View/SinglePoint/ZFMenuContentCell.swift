//
//  ZFMenuContentCell.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFMenuContentCellDelegate : NSObjectProtocol {
    
    optional func menuContentCell(menuContentCell : ZFMenuContentCell , didClickAddBtn : UIButton, orderContent : ZFOrderContentModel)
    
}

class ZFMenuContentCell: UITableViewCell {

    weak var iconView : UIImageView!         //食品图片
    
    weak var nameView : UILabel!             //食品名称
    
    weak var measureView : UILabel!          //食品销量
    
    weak var priceView : UILabel!            //食品价格
    
    weak var addBtn : UIButton!              //增加按钮
    
    weak var soldOutView : UIImageView!      //售空图标
    
    weak var delegate : ZFMenuContentCellDelegate?
    
    var _menuContent : ZFMenuContentModel?
    
    var menuContent : ZFMenuContentModel{
        set{
            self._menuContent = newValue
            self.nameView.text = self._menuContent!.menuContent_name;
            self.priceView.text = "￥\(self._menuContent!.menuContent_price!)";
            self.measureView.text = "销量: \(self._menuContent!.menuContent_measure!)";
            
            let imageURL = menuContent.menuContent_img;
            
            if imageURL != "Null" {
//                let data : NSData = NSData(contentsOfURL: NSURL(string: "http://\(ZFAsynHttp.IP)/\(imageURL!)")!)!;
//                
//                //从本地
////                let data : NSData = NSData(contentsOfFile: "\(FILE_STRING)/\(imageURL!)")!;
//                
//                self.iconView?.image = UIImage(data: data);
                
                let url : NSURL = NSURL(string: "http://\(ZFAsynHttp.IP)/\(imageURL!)")!;
                
                self.iconView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "NoPicture"));
            }
            
            //设置按钮是否能点击
            self.addBtn.enabled = menuContent.menuContent_isProvide == "1";
            //设置是否显示以售完图标
            self.soldOutView.hidden = menuContent.menuContent_isProvide == "1";
        }
        get{
            return self._menuContent!;
        }
    }
    
    static let menuContentID : String = "menuContentID";
    
    //获得ZFMenuContentCell
    class func menuContentCellWithTableView(tableView : UITableView) -> ZFMenuContentCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(menuContentID) as? ZFMenuContentCell;
        
        if cell == nil {
            
            cell = ZFMenuContentCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: menuContentID);
            
            cell?.selectionStyle = UITableViewCellSelectionStyle.None;
            
            
        }
        
        return cell!;
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        //食品图片
        self.setupIconView();
        
        //食品名称
        self.setupNameView();
        
        //食品销量
        self.setupMeasureView();
        
        //食品价格
        self.setupPriceView();
        
        //增加按钮
        self.setupAddBtn();
        
        //售空图标
        self.setupSoldOutView();

    }
    
    //设置食品图片
    func setupIconView(){
        let iocn : UIImageView = UIImageView();
        self.contentView.addSubview(iocn);
        self.iconView = iocn;
    }
    
    //设置食品名称
    func setupNameView(){
        let name : UILabel = UILabel();
        self.contentView.addSubview(name);
        self.nameView = name;
    }
    
    //设置食品销量
    func setupMeasureView(){
        let measure : UILabel = UILabel();
        measure.textColor = UIColor.grayColor();
        measure.font = UIFont.systemFontOfSize(14);
        self.contentView.addSubview(measure);
        self.measureView = measure;
    }
    
    //设置食品价格
    func setupPriceView(){
        let price : UILabel = UILabel();
        price.textColor = UIColor.redColor();
        price.font = UIFont.systemFontOfSize(25);
        self.contentView.addSubview(price);
        self.priceView = price;
    }
    
    //设置增加按钮
    func setupAddBtn(){
        let add : UIButton = UIButton();
        add.addTarget(self, action: "addBtnDidClick:", forControlEvents: UIControlEvents.TouchUpInside);
        add.setImage(UIImage(named: "addBtn_bg"), forState: UIControlState.Normal);
        self.contentView.addSubview(add);
        self.addBtn = add;
    }
    
    //设置售空图标
    func setupSoldOutView(){
        
        
        let soldOutView : UIImageView = UIImageView();
        soldOutView.hidden = true;
        soldOutView.image = UIImage.resizableImage(name: "soldOut");
        self.iconView.addSubview(soldOutView);
        
        self.soldOutView = soldOutView;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBtnDidClick(addBtn : UIButton) {
        
        
        if self.delegate != nil && self.delegate!.respondsToSelector(Selector("menuContentCell:didClickAddBtn:orderContent:")) {
            let orderContent = ZFOrderContentModel()
            orderContent.orderContentName = self.nameView.text
            orderContent.orderContentPrice = self.menuContent.menuContent_price as? CGFloat
            self.delegate!.menuContentCell!(self, didClickAddBtn: self.addBtn,orderContent :orderContent)
        }
    }
    
    //设置食品图片frame
    func setIconViewF(icon : UIImageView) {
        
        let iconX : CGFloat = PADDING;
        let iconY : CGFloat = PADDING;
        let iconW : CGFloat = 90;
        let iconH : CGFloat = 70;
        
        icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
    }
    
    //设置食品名称的frame
    func setNameViewF(name : UILabel) {
        let nameX : CGFloat = CGRectGetMaxX(self.iconView.frame) + PADDING;
        let nameY : CGFloat = CGRectGetMinX(self.iconView.frame);
        let nameW : CGFloat = 150;
        let nameH : CGFloat = 25;
        
                
        name.frame = CGRectMake(nameX, nameY, nameW, nameH);
        
        }
    
    //设置食品销量的frame
    func setMeasureViewF(measure : UILabel) {
        let measureX : CGFloat = CGRectGetMinX(self.nameView.frame);
        let measureY : CGFloat = CGRectGetMaxY(self.nameView.frame) + PADDING * 0.5;
        let measureW : CGFloat = self.nameView.frame.width;
        let measureH : CGFloat = 15;
        
        measure.frame = CGRectMake(measureX, measureY, measureW, measureH);
        
    }
    
    //设置食品价格的frame
    func setPriceViewF(price : UILabel){

        let priceX : CGFloat = CGRectGetMinX(self.nameView.frame);
        let priceY : CGFloat = CGRectGetMaxY(self.measureView.frame) + PADDING * 0.5;
        let priceW : CGFloat = self.nameView.frame.width;
        let priceH : CGFloat = 20;
        
        price.frame = CGRectMake(priceX, priceY, priceW, priceH);
       
    }
    
    //设置增加按钮frame
    func setAddBtnF(addBtn : UIButton) {

        let addBtnW : CGFloat = 44;
        let addBtnH : CGFloat = 44;
        let addBtnX : CGFloat = self.frame.width - addBtnW - PADDING;
        let addBtnY : CGFloat = self.frame.height - PADDING - addBtnH;
        
        addBtn.frame = CGRectMake(addBtnX, addBtnY, addBtnW, addBtnH);
        
    }
    
    //设置售空图标frame
    func setupSoldOutViewF(soldOutView : UIImageView) {
        
        let soldOutY : CGFloat = 0;
        let soldOutW : CGFloat = 44;
        let soldOutH : CGFloat = 44;
        let soldOutX : CGFloat = self.iconView.frame.size.width - soldOutW;
        
        
        soldOutView.frame = CGRectMake(soldOutX, soldOutY, soldOutW, soldOutH);
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        //设置食品图片frame
        self.setIconViewF(self.iconView);
        
        //设置食品名称frame
        self.setNameViewF(self.nameView);
        
        //设置食品销量frame
        self.setMeasureViewF(self.measureView);
        
        //设置食品价格frame
        self.setPriceViewF(self.priceView);
        
        //设置增加按钮frame
        self.setAddBtnF(self.addBtn);
        
        //设置售空图标frame
        self.setupSoldOutViewF(self.soldOutView);
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
