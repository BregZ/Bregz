//
//  XQOrderTableViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQOrderTableViewCell: UITableViewCell {
    
    class func orderTableViewCellWithTableView(tableView : UITableView) -> XQOrderTableViewCell{
        
        let orderTableViewCellId = "orderTableViewCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(orderTableViewCellId) as? XQOrderTableViewCell
        
        if cell == nil {
            cell = XQOrderTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: orderTableViewCellId)
        }
        
        return cell!
    }
    
    weak var seatTextView : UILabel!
    
    weak var priceView : UILabel!
    
    var _orders : XQOrdersModel?
    
    var orders : XQOrdersModel {
        set {
            self._orders = newValue
            
            self.seatTextView.text = self._orders!.orders_seatText
            
            self.priceView.text = "￥\(self._orders!.orders_price!)"
        }
        get {
            return self._orders!
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let seatText : UILabel = UILabel()
        seatText.textColor = UIColor.redColor()
        seatText.textAlignment = NSTextAlignment.Center
        seatText.backgroundColor = UIColor(patternImage: UIImage(named: "seat_no_can")!)
        self.contentView.addSubview(seatText)
        self.seatTextView = seatText
        
        let price : UILabel = UILabel()
        price.textColor = UIColor.redColor()
        self.contentView.addSubview(price)
        self.priceView = price
        
        //设置选中样式
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setSeatTextViewF(self.seatTextView)
        
        self.setPriceViewF(self.priceView)
    }
    
    func setSeatTextViewF(seatText : UILabel){
        let seatTextW : CGFloat =  50
        let seatTextH : CGFloat =  50
        let seatTextX : CGFloat =  10
        let seatTextY : CGFloat =  (self.frame.height - seatTextH) * 0.5
        
        seatText.frame = CGRectMake(seatTextX, seatTextY, seatTextW, seatTextH)
    }
    
    func setPriceViewF(price : UILabel) {
        
        let priceW : CGFloat = 100
        let priceH : CGFloat = self.frame.height
        let priceX : CGFloat = self.frame.width - priceW - 10
        let priceY : CGFloat = 0
        
        price.frame = CGRectMake(priceX, priceY, priceW, priceH)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
