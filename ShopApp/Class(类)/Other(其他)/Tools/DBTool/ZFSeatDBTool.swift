//
//  ZFSeatDBTool.swift
//  ShopApp
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFSeatDBTool: NSObject {
    
    class func createSeatOrderTable(db : FMDatabase){
        
        let sql : String = "create table if not exists t_order (order_id integer primary key, order_name text, order_price float, order_count integer, seat_id integer);"
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
            
//            println("t_order表创建成功")
        }else{
            NSLog("t_order表创建失败 %s", db.lastError())
        }
        
    }
    
    //查询全部订单
    func selectSeatOrders(db : FMDatabase, seat_id : Int) -> Array<ZFOrderContentModel>{
        let sql = "SELECT order_name,order_price,order_count,seat_id FROM t_order WHERE seat_id=\(seat_id)"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        var arrayM = Array<ZFOrderContentModel>()
        
        while set.next() {
            
            let seatOrder = ZFOrderContentModel()
            
            seatOrder.orderContentName = set.stringForColumn("order_name")
            seatOrder.orderContentPrice = CGFloat(set.doubleForColumn("order_price"))
            seatOrder.orderContentNumber = Int(set.intForColumn("order_count"))
            seatOrder.seat_id = Int(set.intForColumn("seat_id"))
            
            arrayM.append(seatOrder)
        }
        
        return arrayM
    }
    
    //添加订单
    func insertSeatOrder(db: FMDatabase, order: ZFOrderContentModel){
        let sql : String = "insert into t_order ( order_name, order_price, order_count, seat_id) values (?, ?, ?, ?);"
        
        let arrayM : NSMutableArray = NSMutableArray()
        arrayM.addObject(order.orderContentName!)
        arrayM.addObject(order.orderContentPrice!)
        arrayM.addObject(order.orderContentNumber)
        arrayM.addObject(order.seat_id!)
        
        if db.executeUpdate(sql, withArgumentsInArray: arrayM as [AnyObject]) {
//            println("t_order增加成功")
        }else{
            NSLog("t_order增加失败 %s", db.lastError())
        }
    }
    
    //修改订单
    func updateSeatOrder(db: FMDatabase, order: ZFOrderContentModel, type: ZFShoppingCartShowMenuContentCellBtnType){
        var sql : String!
        if type == ZFShoppingCartShowMenuContentCellBtnType.AddBtn {
            
            sql = "UPDATE t_order SET order_count=order_count+1 WHERE seat_id=\(order.seat_id!) AND order_name='\(order.orderContentName!)'"
            
        }else {
            
            sql = "UPDATE t_order SET order_count=order_count-1 WHERE seat_id=\(order.seat_id!) AND order_name='\(order.orderContentName!)'"
            
        }
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("t_order修改成功")
        }else{
            NSLog("t_order修改失败 %s", db.lastError())
        }
    }
    
    //查询是否存在这条订单
    func selectSeatOrder(db : FMDatabase, order: ZFOrderContentModel) -> Bool {
        let sql = "SELECT order_name FROM t_order WHERE seat_id=\(order.seat_id!) AND order_name='\(order.orderContentName!)'"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        var isOrder : Bool = false
        
        while set.next() {
            isOrder = true
        }
        return isOrder
    }
    
    //删除一条订单
    func removeSeatOrder(db : FMDatabase, order: ZFOrderContentModel) {
        let sql = "DELETE FROM t_order WHERE seat_id=\(order.seat_id!) AND order_name='\(order.orderContentName!)'"
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("t_order删除成功")
        }else{
            NSLog("t_order删除失败 %s", db.lastError())
        }
    }
    
    //删除全部订单
    func removeAllSeatOrder(db : FMDatabase, seat_id : Int) {
        let sql = "DELETE FROM t_order WHERE seat_id=\(seat_id)"
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
//            println("t_order删除成功")
        }else{
            NSLog("t_order删除失败 %s", db.lastError())
        }
    }
    
    //查询一共有多少条菜单
    func selectOrderAllNumber(db : FMDatabase, seat_id : Int) -> Int{
        
        var allCount : Int = 0
        
        let sql = "SELECT sum(order_count) as allCount FROM t_order WHERE seat_id=\(seat_id)"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        while set.next() {
            allCount = Int(set.intForColumn("allCount"))
        }
        
        return allCount
    }
    
    
    //查询订单总价
    func selectAllPrice(db : FMDatabase, seat_id : Int) -> CGFloat{
        
        var allPrice : CGFloat = 0
        
        let sql = "SELECT sum(order_count * order_price) as allPrice FROM t_order WHERE seat_id=\(seat_id)"
        
        let set : FMResultSet =  db.executeQuery(sql, withArgumentsInArray: nil)
        
        while set.next() {
            allPrice = CGFloat(set.doubleForColumn("allPrice"))
        }
        
        return allPrice
        
    }
}
