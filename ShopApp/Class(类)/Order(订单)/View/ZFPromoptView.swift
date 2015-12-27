//
//  ZFPromoptView.swift
//  ShopApp
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFPromoptView: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        self.setBackgroundImage(UIImage.resizableImage(name: "promopt_btn_bg"), forState: UIControlState.Normal);
        self.titleLabel?.font = UIFont.boldSystemFontOfSize(15);
        self.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal);
        self.userInteractionEnabled = false;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        println("ZFPromoptView deinit");
    }

}
