//
//  ZFOrderHttp.swift
//  ShopApp
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFOrderHttpDelegate : NSObjectProtocol {
    optional func orderHttp(orderHttp: ZFOrderHttp, isOrder : String)
    
    optional func orderHttp(orderHttp: ZFOrderHttp,reloadAllOrder : Array<ZFOrdersModel>)
    
    optional func orderHttp(orderHttp: ZFOrderHttp,reloadEvenOrder : Array<ZFOrderContentModel>)
    
    optional func orderHttp(orderHttp: ZFOrderHttp,isSettle : String)
}

class ZFOrderHttp: NSObject {
    
    weak var delegate : ZFOrderHttpDelegate!
    
    
    //提交订单
    func postOrderContentsJsonData(orderContents: Array<ZFOrderContentModel>, seat_id : Int){
        var arrayM = Array<NSDictionary>()
        
        for orderContent in orderContents {
            
            let order = ZFOrderContentModel()
            
            arrayM.append(order.dictWithOrderContentModel(orderContent))
            
        }
        
        var dictM = Dictionary<String, AnyObject>()
        
        dictM["seat_id"] = seat_id
        
        dictM["orders"] = arrayM
        
        let data : NSData = NSJSONSerialization.dataWithJSONObject(dictM, options: NSJSONWritingOptions(0), error: nil)!
        let strHTTPBody : String = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        //        println(strHTTPBody)
        let request = ZFAsynHttp.sendPostHttp("insertOrder.php", strHTTPBody: "\(strHTTPBody)", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                
                //如果成功返回 successOrder
                let isOrder = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("orderHttp:isOrder:")){
                        self.delegate.orderHttp!(self, isOrder: isOrder)
                    }
                    
                })
            }
            
        }

    }
    
    //获取全部订单
    func getAllOrderData() {
        let request = ZFAsynHttp.sendGetHttp("selectOrder.php?gain=allOrder", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                var arrayM = Array<ZFOrdersModel>()
                
                if jsonArray != nil {
                    
                    for  dict in jsonArray! {
                        
                        let ordersModel = ZFOrdersModel.ordersModelWithDict(dict as! NSDictionary)
                        
                        arrayM.append(ordersModel)
                        
                    }
                    
                }
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("orderHttp:reloadAllOrder:")){
                        self.delegate.orderHttp!(self, reloadAllOrder:arrayM)
                    }
                })
                
                
            }
        }

    }
    
    //获得一桌的订单
    func gainOrderData(setat_id : Int){
        let request = ZFAsynHttp.sendGetHttp("selectOrder.php?gain=Content&seat_id=\(setat_id)", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                var arrayM = Array<ZFOrderContentModel>()
                
                for  dict in jsonArray! {
                    
                    let orderContentModel = ZFOrderContentModel.orderContentModelWithDict(dict as! NSDictionary)
                    
                    arrayM.append(orderContentModel)
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("orderHttp:reloadEvenOrder:")){
                        self.delegate.orderHttp!(self, reloadEvenOrder:arrayM)
                    }
                })
                
                
            }
        }
    }
    
    //结账
    func orderSettleData(seat_id : Int){
        let strHTTPBody = "seat_id=\(seat_id)"
        let request = ZFAsynHttp.sendPostHttp("orderSettle.php", strHTTPBody: "\(strHTTPBody)", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                
                //如果成功返回 YesSettle 否则返回 NoSettle
                let isOrder = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("orderHttp:isSettle:") ) {
                        self.delegate.orderHttp!(self, isSettle: isOrder)
                    }
                    
                })
            }
            
        }
    }
   
}
