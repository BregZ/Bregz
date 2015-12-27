//
//  ZFOrderContentCell.swift
//  ShopApp
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFOrderContentCell: UITableViewCell {

    var _orderContent : ZFOrderContentModel!
    
    var orderContent : ZFOrderContentModel {
        set {
            self._orderContent = newValue;
            
            self.nameView.text = "\(orderContent.orderContentName!)";
            self.priceView.text = "￥\(orderContent.orderContentPrice)";
            self.numberView.text = "共 \(orderContent.orderContentNumber) 份";
        }
        get{
            return self._orderContent!;
        }
    }
    
    weak var nameView : UILabel!            //名称
    
    weak var priceView : UILabel!           //价格
    
    weak var numberView : UILabel!          //数量
    
    static let cellid = "ZFOrderContentCellId";
    
    class func orderContentCellWithTabelView(tableView : UITableView) -> ZFOrderContentCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellid) as? ZFOrderContentCell;
        
        if cell == nil {
            cell = ZFOrderContentCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellid);
        }
        
        return cell!;
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        //初始化 contentView 上的控件
        self.initView();
    }
    
    //初始化 contentView 上的控件
    func initView(){
        
        //初始化名称View
        let nameView : UILabel = UILabel();
        nameView.textColor = UIColor.grayColor();
        self.contentView.addSubview(nameView);
        self.nameView = nameView;
        
        //初始化价格View
        let priceView : UILabel = UILabel();
        priceView.textColor = UIColor.redColor();
        self.contentView.addSubview(priceView);
        self.priceView = priceView;
        
        //初始化数量View
        let numberView : UILabel = UILabel();
        numberView.textColor = UIColor.grayColor();
        self.contentView.addSubview(numberView);
        self.numberView = numberView;
        
        //设置选中样式
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        
        //设置名称View的frame
        self.setNameViewF(self.nameView);
        
        //设置数量View的frame
        self.setNumberViewF(self.numberView);
        
        //设置价格View的frame
        self.setPriceViewF(self.priceView);
    }

    //设置名称View的frame
    func setNameViewF(nameView : UILabel) {
        let nameX : CGFloat = PADDING * 2;
        let nameY : CGFloat = 0;
        let nameW : CGFloat = 150;
        let nameH : CGFloat = self.frame.size.height;
        
        nameView.frame = CGRectMake(nameX, nameY, nameW, nameH)
        
    }
    
    //设置价格View的frame
    func setPriceViewF(priceView : UILabel) {
        let priceW : CGFloat = 80;
        let priceH : CGFloat = self.frame.size.height;
        let priceX : CGFloat = CGRectGetMinX(self.numberView.frame) - PADDING - priceW;
        let priceY : CGFloat = 0;
        
        priceView.frame = CGRectMake(priceX, priceY, priceW, priceH)
        
        
    }
    
    //设置数量View的frame
    func setNumberViewF(numberView : UILabel) {
        let numberW : CGFloat = 70;
        let numberH : CGFloat = self.frame.size.height;
        let numberX : CGFloat = self.frame.size.width - PADDING - numberW;
        let numberY : CGFloat = 0;
        
        numberView.frame = CGRectMake(numberX, numberY, numberW, numberH)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

