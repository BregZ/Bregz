//
//  ZFSeatHttp.swift
//  ShopApp
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFSeatHttpDelegate : NSObjectProtocol {
    
    optional func seatHttp(seatHttp: ZFSeatHttp, newSeats: Array<ZFSeatModel>)
    
    optional func seatHttp(seatHttp: ZFSeatHttp, isSeat : String)
    
    optional func seatHttp(seatHttp: ZFSeatHttp, isRefundSeat : String, seat_id : Int)
    
}

enum SeatType: String {
    case YES = "YesSeat"
    case NO = "NoSeat"
}

class ZFSeatHttp: NSObject {
    
    weak var delegate : ZFSeatHttpDelegate!
    
    //获得新的座位信息
    func getSeatData() {
        
        let request = ZFAsynHttp.sendGetHttp("shopSeat.php?gain=getSeat", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                if jsonArray != nil {
                    
                    var arrayM = Array<ZFSeatModel>()
                    
                    for  dict in jsonArray! {
                        
                        let menuTitleModel = ZFSeatModel.seatWithDict(dict as! NSDictionary)
                        
                        arrayM.append(menuTitleModel)
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        if self.delegate != nil && self.delegate.respondsToSelector(Selector("seatHttp:newSeats:")) {
                            self.delegate.seatHttp!(self, newSeats: arrayM)
                        }
                        
                    })
                    
                }
                
                
            } else {
                NSLog("error : %@", error)
                
                
            }
        }
    }
    
    //选择座位
    func sendSeatStateData(seat: ZFSeatModel) {
        let strHTTPBody : String = "gain=setSeat&seat_id=\(seat.seat_id!)&seat_state=\(seat.seat_state!)"
        
        let request = ZFAsynHttp.sendPostHttp("shopSeat.php", strHTTPBody: strHTTPBody, isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let isSeat = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                    
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("seatHttp:isSeat:")) {
                        self.delegate.seatHttp!(self, isSeat: isSeat)
                    }
                    
                })
                
                
            }
            
        }

    }
    
    //退桌
    func sendRefundSeatStateData(seat: ZFSeatModel) {
        let strHTTPBody : String = "gain=refundSeat&seat_id=\(seat.seat_id!)&seat_state=\(seat.seat_state!)"
        
        let request = ZFAsynHttp.sendPostHttp("shopSeat.php", strHTTPBody: strHTTPBody, isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let isRefundSeat = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                    
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("seatHttp:isRefundSeat:seat_id:")) {
                        self.delegate.seatHttp!(self, isRefundSeat: isRefundSeat, seat_id: seat.seat_id!)
                    }
                    
                })

            }
            
        }
        
    }

    
}
