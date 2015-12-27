//
//  ZFShowEvenOrderHearderView.swift
//  ShopApp
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFShowEvenOrderSectionHearderView: UITableViewHeaderFooterView {
    
    weak var timeView : UILabel!                //订单时间
    
    weak var allPriceView : UILabel!            //订单总价
    
    var allPrice : CGFloat {
        set {
            self.allPriceView.text = "共:￥\(newValue)元"
        }
        get {
            return 0
        }
    }
    
    var time : String {
        set {
            
            //设置时间
            let timeTool : ZFTimeTool = ZFTimeTool();
            let timeStr : String = timeTool.getShowTime(newValue);
            self.timeView.text = timeStr;
            
        }
        get {
            return "No"
        }
        
    }

    
    //返回一个 MJHeaderView －> 封装
    class func headerViewWithTableView(tableView : UITableView) -> ZFShowEvenOrderSectionHearderView{
        
        let ID : String = "showEvenOrderSectionHearderView"
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ID) as? ZFShowEvenOrderSectionHearderView
        
        if header == nil {
            header = ZFShowEvenOrderSectionHearderView(reuseIdentifier: ID)
            
        }
        return header!
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //初始化tableView上的控件
        self.initView()
    
    }
    
    //初始化tableView上的控件
    func initView(){
        //初始化时间View
        let timeView: UILabel = UILabel()
        timeView.textColor = UIColor.grayColor()
        self.addSubview(timeView)
        self.timeView = timeView
        
        //初始化总价View
        let allPriceView: UILabel = UILabel()
        allPriceView.textColor = UIColor.redColor()
        allPriceView.textAlignment = NSTextAlignment.Right
        self.addSubview(allPriceView)
        self.allPriceView = allPriceView
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置时间View的frame
        self.setTimeViewF(self.timeView)
        
        //设置总价View的frame
        self.setAllPriceViewF(self.allPriceView)
        
    }
    
    //设置时间View的frame
    func setTimeViewF(timeView : UILabel){
        let timeX : CGFloat = PADDING;
        let timeY : CGFloat = 0;
        let timeW : CGFloat = 200;
        let timeH : CGFloat = self.frame.size.height;
        
        timeView.frame = CGRectMake(timeX, timeY, timeW, timeH)

    }
    
    //设置总价View的frame
    func setAllPriceViewF(allPriceView : UILabel){
        let priceW : CGFloat = 120;
        let priceH : CGFloat = self.frame.height;
        let priceX : CGFloat = self.frame.size.width - PADDING - priceW;
        let priceY : CGFloat = 0;
        
        allPriceView.frame = CGRectMake(priceX, priceY, priceW, priceH)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
