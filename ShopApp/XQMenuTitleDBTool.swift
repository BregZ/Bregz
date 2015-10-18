//
//  MenuTitleDBTool.swift
//  ShopApp
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQMenuTitleDBTool: NSObject {
    
    class func createMenuTitleTable(db : FMDatabase){
        let sql : String = "create table if not exists t_menuTitle (menuTitle_id integer primary key, menuTitle_name text);"

        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("t_menuTitle表创建成功")
        }else{
            NSLog("t_menuTitle表创建失败 %s", db.lastError())
        }

    }
    
    class func insertMenuTitle(db : FMDatabase,menuTitle : XQMenuTitleModel){
        let sql : String = "insert into t_menuTitle (menuTitle_id, menuTitle_name) values (?, ?);"
        
        if db.executeUpdate(sql, withArgumentsInArray: [menuTitle.menuTitle_id!,menuTitle.menuTitle_name!]) {
//            println("menuTitle增加成功")
        }else{
            NSLog("menuTitle增加失败 %s", db.lastError())
        }
    }
    
    class func deleteMenuTitle(db : FMDatabase) {
        
        let sql : String = "DELETE FROM t_menuTitle;"
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("menuTitle删除成功")
        }else{
            NSLog("menuTitle删除失败 %s", db.lastError())
        }
    }
    
    class func selectMenuTitleAll(db : FMDatabase) -> Array<XQMenuTitleModel>{
        let sql : String = "select menuTitle_id, menuTitle_name from t_menuTitle;"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        var arrayM = Array<XQMenuTitleModel>()
        
        while set.next() {
            
            let menuTitle = XQMenuTitleModel()
            
            menuTitle.menuTitle_id = Int(set.intForColumn("menuTitle_id"))
            menuTitle.menuTitle_name = set.stringForColumn("menuTitle_name")
            
            menuTitle.menuContents = XQMenuContentDBTool.selectMenuContent(db, menuTitle_id: menuTitle.menuTitle_id! as Int)
            
            arrayM.append(menuTitle)
            
        }
        
        return arrayM
    }
   
}
