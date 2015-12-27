//
//  ZFOrderSqlite.swift
//  ShopApp
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//


//对Sqlite 对2次封装

import UIKit

class ZFOrderSqlite: NSObject {
    
    //db 对列
    var databaseQueue : ZFFMDatabaseQueue!
    
    override init() {
        super.init()
        self.databaseQueue = ZFFMDatabaseQueue.shareInstance()
    }
    
    ///查询座位全部还没有提交的全部内容
    func selectSeatOrderContent(seat_id : Int) -> Array<ZFOrderContentModel> {
        var arrayM = Array<ZFOrderContentModel>()
        
        self.databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let seatOrder = ZFSeatDBTool()
            arrayM = seatOrder.selectSeatOrders(db, seat_id: seat_id)
            
        }
        
        return arrayM
    }
    
    
    ///查询全部未提交订单的价格
    func selectAllOrderPrice(seat_id : Int) -> CGFloat{
        
        var allPice : CGFloat = 0
        
        self.databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let seatOrder = ZFSeatDBTool()
            
            allPice = seatOrder.selectAllPrice(db, seat_id: seat_id)
            
        }
        return allPice
    }
    
    //查询历史订单全部条数
    func selectOrderAllNumber(seat_id : Int) -> Int{
        
        var number : Int = 0
        
        self.databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let order = ZFSeatDBTool()
            
            number = order.selectOrderAllNumber(db, seat_id: seat_id)
            
        }
        
        return number
    }
    
    //删除全部订单信息
    func removeAllSeatOrder(seat_id : Int){
        
        self.databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let order = ZFSeatDBTool()
            
            //删除订单信息
            order.removeAllSeatOrder(db, seat_id: seat_id)
            
        }
    }
    
    //删除一条数据
    func removeSeatOrder(orderContent: ZFOrderContentModel){
        
        self.databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let order = ZFSeatDBTool()
            
            order.removeSeatOrder(db, order: orderContent)
        }

    }
    
    //修改数据
    func updateSeatOrder(orderContent: ZFOrderContentModel,btnType: ZFShoppingCartShowMenuContentCellBtnType){
        
        self.databaseQueue.queue!.inDatabase { (db : FMDatabase!) -> Void in
            
            let order = ZFSeatDBTool()
            //修改数量
            order.updateSeatOrder(db, order: orderContent,type: btnType)
            
        }
    }
    
}
