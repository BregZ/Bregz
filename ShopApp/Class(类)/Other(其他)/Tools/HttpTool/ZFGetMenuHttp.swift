//
//  ZFGetMenu.swift
//  ShopApp
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFGetMenuDelegate : NSObjectProtocol {
    optional func getMenuHttp(MenuHttp: ZFGetMenuHttp, newMenuTitleModel: Array<ZFMenuTitleModel>)
}

class ZFGetMenuHttp: NSObject {
    
    weak var delegate : ZFGetMenuDelegate!
    
    func GetJsonMenuData() {
        
        var arrayM = Array<ZFMenuTitleModel>()
        
        let request = ZFAsynHttp.sendGetHttp("meunContent.php", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                if jsonArray != nil {
                    
                    for  dict in jsonArray! {
                        
                        let menuTitleModel = ZFMenuTitleModel.menuTitleWithDict(dict as! NSDictionary)
                        
                        arrayM.append(menuTitleModel)
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        if self.delegate != nil && self.delegate.respondsToSelector(Selector("getMenuHttp:newMenuTitleModel:")){
                            self.delegate.getMenuHttp!(self, newMenuTitleModel: arrayM)
                        }
                    })
                    
                }
            } else {
                NSLog("error : %@", error)
            }
        }

    }
    
}
