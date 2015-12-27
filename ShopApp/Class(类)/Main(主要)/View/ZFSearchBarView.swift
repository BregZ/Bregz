//
//  ZFSearchBarView.swift
//  ShopApp
//
//  Created by mac on 15/11/18.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSearchBarView: UISearchBar {

    override init(frame : CGRect){
        super.init(frame: frame)
        
        //初始化
        self.initView();

        
    }
    
    //初始化
    func initView(){
        
        self.placeholder = "请您输入菜名";
//        self.barTintColor = UIColor.whiteColor();
        self.searchBarStyle = UISearchBarStyle.Minimal;
        
    }
    
   

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
