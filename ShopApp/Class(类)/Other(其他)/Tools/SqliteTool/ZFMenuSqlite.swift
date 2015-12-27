//
//  ZFSaveMenu.swift
//  ShopApp
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuSqlite: NSObject {
    
    
    //保存菜单
    func saveMenu(menuTitles : Array<ZFMenuTitleModel>){
        
        var databaseQueue : ZFFMDatabaseQueue = ZFFMDatabaseQueue.shareInstance()
        
        databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            ZFMenuTitleDBTool.deleteMenuTitle(db)
            ZFMenuContentDBTool.deleteMenuContent(db)
            
            for menuTitle in menuTitles {
                
                ZFMenuTitleDBTool.insertMenuTitle(db, menuTitle: menuTitle)
                
                if menuTitle.menuContents != nil {
                    
                    for menuContent in menuTitle.menuContents! {
                        
                        let newMenuContent = menuContent as! ZFMenuContentModel
                        ZFMenuContentDBTool.insertMenuContent(db, menuContent: newMenuContent)
                        
                        
//                        if newMenuContent.menuContent_img != "Null"{
//                            //保存图片
//                            self.saveImage(menuContent.menuContent_img!!)
//                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    //查询数据库里的全部菜单
    func selectMenu() -> Array<ZFMenuTitleModel> {
        
        var array = Array<ZFMenuTitleModel>();
        
        var databaseQueue : ZFFMDatabaseQueue = ZFFMDatabaseQueue.shareInstance();
        
        databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            array = ZFMenuTitleDBTool.selectMenuTitleAll(db);
        }
        
        return array;
    }
    
    //保存图片
    func saveImage(imageName : String){
        
        //获取沙盒中数据库文件名
        let fileString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last as! String;
        
        let data : NSData = NSData(contentsOfURL: NSURL(string: "http://\(ZFAsynHttp.IP)/\(imageName)")!)!;
        
        let pathTo : String = "\(fileString)/\(imageName)";
        
        let isWriteSuccess : Bool = data.writeToFile(pathTo, atomically: true);
        
        if isWriteSuccess {
//            println("写入成功");
        }else{
            println("写入图片失败");
        }

    }
    
    //搜索菜谱
    func searchMenuContent(searchText : String) -> Array<ZFMenuContentModel> {
        
        var array = Array<ZFMenuContentModel>();
        
        var databaseQueue : ZFFMDatabaseQueue = ZFFMDatabaseQueue.shareInstance();
        
        databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            array = ZFMenuContentDBTool.searchMenuContent(db, searchText: searchText);
            
        }
        
        return array;
    }
    
}
