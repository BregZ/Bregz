//
//  ZFCultureHttp.swift
//  ShopApp
//
//  Created by mac on 15/11/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFCultureHttpDelegate : NSObjectProtocol {
    
    optional func cultureHttp(cultureHttp : ZFCultureHttp, newCultures: Array<ZFCultureModel>);
    
}

class ZFCultureHttp: NSObject {
    
    weak var delegate : ZFCultureHttpDelegate!
    
    
    func getulturesData(){
        
        let request = ZFAsynHttp.sendGetHttp("culture.php", isNSUTF8StringEncoding: false);
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                if jsonArray != nil {
                    
                    var arrayM = Array<ZFCultureModel>()
                    
                    for  dict in jsonArray! {
                        
                        let menuTitleModel = ZFCultureModel(dict: dict as! NSDictionary)
                        
                        arrayM.append(menuTitleModel)
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        if self.delegate != nil && self.delegate.respondsToSelector(Selector("cultureHttp:newCultures:")) {
                            self.delegate.cultureHttp!(self, newCultures: arrayM);
                        }
                        
                    })
                    
                }
                
                
            } else {
                NSLog("error : %@", error)
                
                
            }
        }

    }
}
