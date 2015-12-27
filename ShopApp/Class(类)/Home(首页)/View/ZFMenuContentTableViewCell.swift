//
//  ZFMenuContentTableViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuContentTableViewCell: UITableViewCell {
    
    weak var iconView : UIImageView?;           //菜单内容图片
    
    weak var nameView : UILabel?;               //菜单内容名称
    
    weak var priceView : UILabel?;              //菜单内容价格
    
    weak var measureView : UILabel?;            //菜单内容销量
    
    weak var soldOutView : UIImageView!         //售空图标
    
    var _menuContentModel : ZFMenuContentModel?;//菜单内容模型
    
    var menuContentModel : ZFMenuContentModel{
        
        set {
            
            self._menuContentModel = newValue;
            
            self.nameView?.text = newValue.menuContent_name;
            
            self.priceView?.text = "￥\(newValue.menuContent_price!)";
            
            self.measureView?.text = "销量: \(newValue.menuContent_measure!)";
            
            //设置是否显示以售完图标
            self.soldOutView.hidden = newValue.menuContent_isProvide == "1";
            
            let imageURL = newValue.menuContent_img;
            
            if imageURL != "Null" {
                
//                let data : NSData = NSData(contentsOfURL: NSURL(string: "http://\(ZFAsynHttp.IP)/\(imageURL!)")!)!
//                
//                //从本地
////                let data : NSData = NSData(contentsOfFile: "\(FILE_STRING)/\(imageURL!)")!;
//                
//                self.iconView?.image = UIImage(data: data);
                
                let url : NSURL = NSURL(string: "http://\(ZFAsynHttp.IP)/\(imageURL!)")!;
                
                self.iconView?.sd_setImageWithURL(url, placeholderImage: UIImage(named: "NoPicture"));
                
            }
        }
        get {
            return _menuContentModel!;
        }
    }
    
    class func menuContentWithTableView(tableView : UITableView) -> ZFMenuContentTableViewCell{
        
        let cellId : String = "menuContent";
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ZFMenuContentTableViewCell;
        
        if cell == nil {
            cell = ZFMenuContentTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellId);
            
            
            
        }
        
        
        
        return cell!;
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        //设置选择样式
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        
        //设置右边图标样式
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        //设置背景图片
        self.setupBackgroundView();
        
        //设置图片
        self.setupIconView();
        
        //设置名称
        self.setupNameView();
        
        //设置价格
        self.setupPriceView();
        
        //设置销量的
        self.setupMeasureView();
        
        //售空图标
        self.setupSoldOutView();
        
    }
    
    //设置背景图片
    func setupBackgroundView(){
        let backgroundView : UIImageView = UIImageView();
        backgroundView.image = UIImage.resizableImage(name: "below_Separator");
        self.backgroundView = backgroundView;
    }
    
    /*
    *一般在这个方法内布局自控件
    *
    *在一个控件的frame发生改变时，系统会自动调用
    */
    override func layoutSubviews() {
        super.layoutSubviews();
        
        //设置图片的frame
        self.setIconViewF(self.iconView!);
        
        //设置名称的frame
        self.setNameViewF(self.nameView!);
        
        //设置价格的frame
        self.setPriceViewViewF(self.priceView!);
        
        //设置销量的frame
        self.setMeasureViewF(self.measureView!);
        
        //设置售空图标frame
        self.setupSoldOutViewF(self.soldOutView);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    //设置图片
    func setupIconView(){
        let iconView : UIImageView = UIImageView();
        self.contentView.addSubview(iconView);
        self.iconView = iconView;
    }
    
    //设置图片的frame
    func setIconViewF(iconView : UIImageView){
        
        let imageH : CGFloat = 70;
        let imageW : CGFloat = 90;
        let imageX : CGFloat = BIGPADDING + PADDING;
        let imageY : CGFloat = (self.frame.size.height - imageH) * 0.5;
        
        iconView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    }
    
    //设置名称
    func setupNameView(){
        let nameView : UILabel = UILabel();
        nameView.textColor = TITLE_BIG_COLOR;
        self.contentView.addSubview(nameView);
        self.nameView = nameView;
    }
    
    //设置名称的frame
    func setNameViewF(nameView : UILabel) {
        
        let nameX : CGFloat = CGRectGetMaxX(self.iconView!.frame) + BIGPADDING;
        let nameY : CGFloat = CGRectGetMinY(self.iconView!.frame) + PADDING * 0.5;
        let nameH : CGFloat = 25;
        let nameW : CGFloat = 150;

        nameView.frame = CGRectMake(nameX, nameY, nameW, nameH);
        
    }
    
    //设置价格
    func setupPriceView(){
        let priceView : UILabel = UILabel();
        self.contentView.addSubview(priceView);
        self.priceView = priceView;
    }
    
    //设置价格的frame
    func setPriceViewViewF(priceView : UILabel) {
        
        let priceH : CGFloat = self.frame.height;
        let priceW : CGFloat = 90;
        let priceX : CGFloat = self.frame.width - priceW - PADDING;
        let priceY : CGFloat = 0;
        priceView.textColor = UIColor.redColor();
        priceView.font = UIFont.systemFontOfSize(28);
        priceView.frame = CGRectMake(priceX, priceY, priceW, priceH);
        
    }
    
    //设置销量
    func setupMeasureView(){
        let measureView : UILabel = UILabel();
        measureView.textColor = TITLE_MIN_COLOR;
        measureView.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(measureView);
        self.measureView = measureView;
    }
    
    //设置销量的frame
    func setMeasureViewF(measureView : UILabel) {
        
        let measureX : CGFloat = CGRectGetMaxX(self.iconView!.frame) + BIGPADDING;
        let measureY : CGFloat = CGRectGetMaxY(self.nameView!.frame) + PADDING;
        let measureH : CGFloat = 25;
        let measureW : CGFloat = 100;
        measureView.frame = CGRectMake(measureX, measureY, measureW, measureH);
        
    }

    //设置售空图标
    func setupSoldOutView(){
        
        
        let soldOutView : UIImageView = UIImageView();
        soldOutView.hidden = true;
        soldOutView.image = UIImage.resizableImage(name: "soldOut");
        self.iconView!.addSubview(soldOutView);
        
        self.soldOutView = soldOutView;
    }
    
    //设置售空图标frame
    func setupSoldOutViewF(soldOutView : UIImageView) {
        
        let soldOutY : CGFloat = 0;
        let soldOutW : CGFloat = 44;
        let soldOutH : CGFloat = 44;
        let soldOutX : CGFloat = self.iconView!.frame.size.width - soldOutW;
        
        
        soldOutView.frame = CGRectMake(soldOutX, soldOutY, soldOutW, soldOutH);
        
    }
    

    deinit {
        println("ZFMenuContentTableViewCell 被销毁了");
    }
}
