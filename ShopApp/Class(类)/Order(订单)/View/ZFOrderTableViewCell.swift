//
//  ZFOrderTableViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFOrderTableViewCell: UITableViewCell {
    
    //获取一个ZFOrderTableViewCell
    class func orderTableViewCellWithTableView(tableView : UITableView) -> ZFOrderTableViewCell{
        
        let orderTableViewCellId = "orderTableViewCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(orderTableViewCellId) as? ZFOrderTableViewCell
        
        if cell == nil {
            cell = ZFOrderTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: orderTableViewCellId)
            
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
        }
        
        return cell!
    }
    
    weak var seatTextView : UILabel!            //座位提示
    
    weak var seatNameView : UILabel!            //座位名称
    
    weak var priceView : UILabel!               //总价
    
    weak var timeView : UILabel!                //订餐时间
    
    var _orders : ZFOrdersModel?                //模型
    
    var orders : ZFOrdersModel {                //设置模型
        set {
            self._orders = newValue;
            
            //设置名称
            self.seatNameView.text = self._orders!.seat_name!;
            
            //设置座位号
            self.seatTextView.text = "\(self._orders!.seat_id!)";
            
            //设置价格
            self.priceView.text = "共￥\(self._orders!.orders_price!)";
            
            
            //设置时间
            let timeTool : ZFTimeTool = ZFTimeTool();
            let timeStr : String = timeTool.getShowTime(self._orders!.order_time!);
            self.timeView.text = timeStr;

        }
        get {
            return self._orders!;
        }
    }
    
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        
        //初始化
        self.initView();
        
        //设置座位提示
        self.setupSeatTextView()
        
        //设置座位名称
        self.setupSeatNameView();
        
        //设置订餐时间
        self.setupTimeView();
        
        //设置总价
        self.setupPriceView();
        
        
    }
    
    //初始化
    func initView(){
        
        //设置背景图片
        self.setupBackgroundView();
        
        //设置选中样式
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置背景图片
    func setupBackgroundView(){
        let backgroundView : UIImageView = UIImageView();
        backgroundView.image = UIImage.resizableImage(name: "below_Separator");
        self.backgroundView = backgroundView;
    }
    
    //设置座位提示
    func setupSeatTextView(){
        let seatTextWH : CGFloat =  50;
        
        let seatText : UILabel = UILabel();
        seatText.frame.size = CGSizeMake(seatTextWH, seatTextWH);
        seatText.backgroundColor = UIColor.redColor();
        seatText.layer.cornerRadius = seatTextWH * 0.5;
        seatText.layer.masksToBounds = true;
        seatText.font = UIFont.boldSystemFontOfSize(25)
        seatText.textColor = UIColor.whiteColor();
        seatText.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(seatText);
        
        
        self.seatTextView = seatText;
    }
    
    

    //设置座位名称
    func setupSeatNameView(){
        let seatNameW : CGFloat = 150;
        
        let seatNameView : UILabel = UILabel();
        seatNameView.frame.size.width = seatNameW;
        seatNameView.textColor = UIColor.grayColor();
        seatNameView.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(seatNameView);
        self.seatNameView = seatNameView;
    }
    
    //设置订餐时间
    func setupTimeView(){
        
        let timeView : UILabel = UILabel();
        timeView.text = "ddddd"
        timeView.frame.size.width = self.seatNameView.frame.size.width;
        timeView.textColor = UIColor.grayColor();
        timeView.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(timeView);
        self.timeView = timeView;
    }
    
    //设置总价
    func setupPriceView(){
        let priceW : CGFloat = 100;
        
        let price : UILabel = UILabel();
        price.frame.size.width = priceW;
        price.textColor = UIColor.redColor();
        self.contentView.addSubview(price);
        self.priceView = price;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        //设置座位提示信息frame
        self.setSeatTextViewF(self.seatTextView);
        
        //设置座位名称的frame
        self.setSeatNameViewF(self.seatNameView);
        
        //设置订餐时间的frame
        self.setTimeViewF(self.timeView);
        
        //设置价格frame
        self.setPriceViewF(self.priceView);
    }
    
    //设置座位提示信息frame
    func setSeatTextViewF(seatText : UILabel){
        
        let seatTextX : CGFloat =  PADDING * 3 ;
        let seatTextY : CGFloat =  (self.frame.height - seatText.frame.size.height) * 0.5;
        
        seatText.frame.origin = CGPointMake(seatTextX, seatTextY);
    }
    
    //设置座位名称的frame
    func setSeatNameViewF(seatNameView : UILabel){
        
        let seatNameH : CGFloat = self.frame.size.height / 2;
        let seatNameX : CGFloat = (self.frame.size.width - seatNameView.frame.size.width) * 0.5;
        let seatNameY : CGFloat = 0;
        
        seatNameView.frame.size.height = seatNameH
        seatNameView.frame.origin = CGPointMake(seatNameX, seatNameY);
    }
    
    //设置座位名称的frame
    func setTimeViewF(timeView : UILabel){
        
        let timeViewH : CGFloat = self.frame.size.height / 2 ;
        let timeViewX : CGFloat = self.seatNameView.frame.origin.x;
        let timeViewY : CGFloat = CGRectGetMaxY(self.seatNameView.frame);
        
        timeView.frame.size.height = timeViewH
        timeView.frame.origin = CGPointMake(timeViewX, timeViewY);
    }
    
    
    //设置价格frame
    func setPriceViewF(price : UILabel) {
    
        let priceH : CGFloat = self.frame.height;
        let priceX : CGFloat = self.frame.width - price.frame.size.width - PADDING;
        let priceY : CGFloat = 0;
        
        price.frame.size.height = priceH
        price.frame.origin = CGPointMake(priceX, priceY);
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);

        // Configure the view for the selected state
    }

}
