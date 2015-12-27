//
//  ZFMenuContentDBTool.swift
//  ShopApp
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuContentDBTool: NSObject {
    
    class func createMenuContentTable(db : FMDatabase){
        let sql : String = "create table if not exists t_menuContent (menuContent_id integer primary key, menuContent_name text, menuContent_pinYin text, menuContent_pinYinHead text, menuContent_price float, menuContent_introduce text, menuContent_measure integer, menuContent_img text, menuTitle_id integer, menuContent_isProvide text);"
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("t_menuContent表创建成功")
        }else{
            NSLog("t_menuContent表创建失败 %s", db.lastError())
        }
        
    }
    
    //插入一条菜单内容
    class func insertMenuContent(db : FMDatabase, menuContent : ZFMenuContentModel){
        let sql : String = "insert into t_menuContent ( menuContent_id, menuContent_name, menuContent_pinYin, menuContent_pinYinHead, menuContent_price, menuContent_introduce,menuContent_measure, menuContent_img, menuTitle_id, menuContent_isProvide) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        
        let arrayM : NSMutableArray = NSMutableArray()
        arrayM.addObject(menuContent.menuContent_id!)
        arrayM.addObject(menuContent.menuContent_name!)
        arrayM.addObject(menuContent.menuContent_pinYin!)
        arrayM.addObject(menuContent.menuContent_pinYinHead!)
        arrayM.addObject(menuContent.menuContent_price!)
        arrayM.addObject(menuContent.menuContent_introduce != nil ? menuContent.menuContent_introduce! : "Null")
        arrayM.addObject(menuContent.menuContent_measure!)
        arrayM.addObject(menuContent.menuContent_img != nil ? menuContent.menuContent_img! : "Null")
        arrayM.addObject(menuContent.menuTitle_id!)
        arrayM.addObject(menuContent.menuContent_isProvide!)
        
        if db.executeUpdate(sql, withArgumentsInArray: arrayM as [AnyObject]) {
//            println("t_menuContent增加成功")
        }else{
            NSLog("t_menuContent增加失败 %s", db.lastError())
        }
    }
    
    //删除全部菜单内容
    class func deleteMenuContent(db : FMDatabase) {
        
        let sql : String = "DELETE FROM t_menuContent;"
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("t_menuContent删除成功")
        }else{
            NSLog("t_menuContent删除失败 %s", db.lastError())
        }
    }
    
    //查询一条菜单内容
    class func selectMenuContent(db : FMDatabase, menuTitle_id : Int) -> Array<ZFMenuContentModel> {
        let sql : String = "select menuContent_id,menuContent_name,menuContent_price,menuContent_introduce,menuContent_measure,menuTitle_id,menuContent_img,menuContent_isProvide from t_menuContent where menuTitle_id=\(menuTitle_id);"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        var arrayM = Array<ZFMenuContentModel>()
        
        while set.next() {
            
            let menuContent = ZFMenuContentModel()
            
            menuContent.menuTitle_id = Int(set.intForColumn("menuTitle_id"))
            menuContent.menuContent_name = set.stringForColumn("menuContent_name")
            menuContent.menuContent_price = CGFloat(set.doubleForColumn("menuContent_price"))
            menuContent.menuContent_introduce = set.stringForColumn("menuContent_introduce")
            menuContent.menuContent_measure = Int(set.intForColumn("menuContent_measure"))
            menuContent.menuTitle_id = Int(set.intForColumn("menuTitle_id"))
            menuContent.menuContent_img = set.stringForColumn("menuContent_img")
            menuContent.menuContent_isProvide = set.stringForColumn("menuContent_isProvide")
            
            arrayM.append(menuContent)
        }
        
        return arrayM
    }
    
    class func searchMenuContent(db : FMDatabase, searchText : String) -> Array<ZFMenuContentModel>{
        
        let sql : String = "select menuContent_id, menuContent_name, menuContent_price, menuContent_introduce, menuContent_measure, menuTitle_id, menuContent_img, menuContent_isProvide from t_menuContent where menuContent_pinYin Like '%\(searchText)%' or menuContent_pinYinHead Like '%\(searchText)%' or menuContent_name Like '%\(searchText)%';"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        var arrayM = Array<ZFMenuContentModel>()
        
        while set.next() {
            
            let menuContent = ZFMenuContentModel()
            
            menuContent.menuTitle_id = Int(set.intForColumn("menuTitle_id"))
            menuContent.menuContent_name = set.stringForColumn("menuContent_name")
            menuContent.menuContent_price = CGFloat(set.doubleForColumn("menuContent_price"))
            menuContent.menuContent_introduce = set.stringForColumn("menuContent_introduce")
            menuContent.menuContent_measure = Int(set.intForColumn("menuContent_measure"))
            menuContent.menuTitle_id = Int(set.intForColumn("menuTitle_id"))
            menuContent.menuContent_img = set.stringForColumn("menuContent_img")
            menuContent.menuContent_isProvide = set.stringForColumn("menuContent_isProvide")
            
            arrayM.append(menuContent)
        }
        
        return arrayM
    }
}
