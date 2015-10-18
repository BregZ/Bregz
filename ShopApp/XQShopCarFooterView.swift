//
//  XQShopCarFooterView.swift
//  ShopApp
//
//  Created by mac on 15/10/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQShopCarFooterView: UITableViewHeaderFooterView {
    
    weak var priceAllView : UILabel!              //总价
    
    weak var yesSelectBtn : UIButton!              //确定选择

    class func shopCarFooterViewWithTable(tableView : UITableView) -> XQShopCarFooterView{
        let shopCarHeaderViewID : String = "FootId"
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(shopCarHeaderViewID) as? XQShopCarFooterView
        
        if header == nil {
            header = XQShopCarFooterView(reuseIdentifier: shopCarHeaderViewID)
            
        }
        return header!
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let priceAll : UILabel = UILabel()
        priceAll.textColor = UIColor.redColor()
        self.contentView.addSubview(priceAll)
        self.priceAllView = priceAll
        
        let yesSelect : UIButton = UIButton()
        yesSelect.backgroundColor = UIColor.redColor()
        yesSelect.setTitle("选好了", forState: UIControlState.Normal)
        self.addSubview(yesSelect)
        self.yesSelectBtn = yesSelect
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setPriceAllViewF(self.priceAllView)
        
        self.setYesSelectBtnF(self.yesSelectBtn)
    }
    
    func setPriceAllViewF(priceAll : UILabel){
        let priceAllX : CGFloat = 10
        let priceAllY : CGFloat = 0
        let priceAllH : CGFloat = self.frame.height
        let priceAllW : CGFloat = 110
        
        priceAll.frame = CGRectMake(priceAllX, priceAllY, priceAllH, priceAllW)
    }
    
    func setYesSelectBtnF(yesSelect : UIButton){
        let yseSelectW : CGFloat = 110
        let yseSelectH : CGFloat = self.frame.height
        let yseSelectX : CGFloat = self.frame.width - yseSelectW
        let yseSelectY : CGFloat = 0
        
        yesSelect.frame = CGRectMake(yseSelectX, yseSelectY, yseSelectW, yseSelectH)
    }
    

}
