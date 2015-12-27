//
//  ZFInformationSectionHeaderView.swift
//  ShopApp
//
//  Created by mac on 15/11/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

let informationSectionHeaderViewID : String = "informationSectionHeaderViewID"

class ZFInformationSectionHeaderView: UITableViewHeaderFooterView {
    
    weak var textTipsView : UIView!

    //返回一个 MJHeaderView －> 封装
    class func informationSectionHeaderViewWithTableView(tableView : UITableView) -> ZFInformationSectionHeaderView{
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(informationSectionHeaderViewID) as? ZFInformationSectionHeaderView;
        
        if header == nil {
            header = ZFInformationSectionHeaderView(reuseIdentifier: informationSectionHeaderViewID);
            
        }
        
        return header!;
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier);
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        if self.textTipsView == nil {
            
            //提示文字
            let textTipsView : UIView = UIView.ZFAlertView(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), title: "员工评分排名",titleColor: TITLE_BIG_COLOR,titleFont: UIFont.systemFontOfSize(20));
            
            self.addSubview(textTipsView);
            self.textTipsView = textTipsView;
        }
        
    }

}
