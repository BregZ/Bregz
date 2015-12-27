//
//  constant.swift
//  ShopApp
//
//  Created by mac on 15/11/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

///view小的间距
let PADDING : CGFloat = 10;

///view大的间距
let BIGPADDING : CGFloat = 20;

///获取沙盒中数据库文件名
let FILE_STRING : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as! String;

///屏幕宽度
let WINDOW_WIDTH : CGFloat = UIScreen.mainScreen().bounds.width;

///购物车显示菜单内容分区头高
let ZFShoppingCartShowMenuContentViewSectionHeight : CGFloat = 50;

///ZFShoppingCarView中ZFShoppingCartShowMenuContentView最大移动Y值
let ZFShoppingCartShowMenuContentViewMaxMoveY : CGFloat = UIScreen.mainScreen().bounds.height * 0.7;

///购物车菜单cell的高度
let ZFShoppingCartMenuContentCellHieght : CGFloat = 90;

///购物车显示菜单cell的高度
let ZFShoppingCartShowMenuContentCellHieght : CGFloat = 50;

///购物车显示菜单按钮的类型
enum ZFShoppingCartShowMenuContentCellBtnType : Int {
    case AddBtn
    case SubBtn
}

//员工头像名称
let EmpHeaderImageName : String = "EmpHeaderImageName";

///大标题颜色
let TITLE_BIG_COLOR : UIColor = UIColor.grayColor();

///小标题颜色
let TITLE_MIN_COLOR : UIColor = UIColor.lightGrayColor();

///主题色
let THEME_COLOR : UIColor = UIColor.orangeColor();
//UIColor(red: 240/255, green: 100/255, blue: 40/255, alpha: 1);

///小主题色
let THEME_MIN_COLOR : UIColor = UIColor(red: 253/255, green: 194/255, blue: 63/255, alpha: 1);

///存储emp信息的key值
let SAVE_EMPS_KEY : String = "saveEmpKey";

///导航栏的高度
let NAV_HEIGHT : CGFloat = 64;
