//
//  ZFEmpHttp.swift
//  ShopApp
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFEmpHttpDelegate : NSObjectProtocol {
    
    optional func empHttp(empHttp : ZFEmpHttp,reloadEmpModel : ZFEmpModel)
    
    optional func empHttp(empHttp : ZFEmpHttp,isLoginSuccess isLogin : String)
    
    optional func empHttp(empHttp : ZFEmpHttp,isGradeSuccess isGrade : String)
    
    optional func empHttp(empHttp : ZFEmpHttp,reloadEmpRank empM : Array<ZFEmpModel>?)
    
}

class ZFEmpHttp: NSObject {
    
    weak var delegate : ZFEmpHttpDelegate!
    
    func selectEvenEmpData(emp_id : Int){
        
        let strHTTPBody : String = "gain=gainEvenEmp&emp_id=\(emp_id)"
        
        let request = ZFAsynHttp.sendPostHttp("shopEmp.php", strHTTPBody: strHTTPBody, isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                
                
                let emp = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSDictionary
                
                var empModel : ZFEmpModel!
                
                if emp != nil {
                    
                    empModel = ZFEmpModel.empModelWithDict(emp!)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if self.delegate != nil && self.delegate.respondsToSelector(Selector("empHttp:reloadEmpModel:")) {
                            self.delegate.empHttp!(self, reloadEmpModel: empModel)
                        }
                        
                    })
                    
                }
                
            }
            
        }

        
    }
    
    func LoginEmpData(id : String, pwd: String){
        let strHTTPBody : String = "gain=login&emp_id=\(id)&emp_pwd=\(pwd)"
        
        let request = ZFAsynHttp.sendPostHttp("shopEmp.php", strHTTPBody: strHTTPBody, isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                let isLogin = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("empHttp:isLoginSuccess:")){
                        
                        self.delegate.empHttp!(self, isLoginSuccess: isLogin)
                    }
                })
                
            }
        }
    }
    
    func RatingStarData(emp_id : Int, advice : String?, ratingStar : CGFloat){
        
        var strHTTPBody : String!
        
        if advice == nil {
             strHTTPBody = "gain=ratingStar&emp_id=\(emp_id)&ratingStar=\(ratingStar)"
        }else {
            
            strHTTPBody = "gain=ratingStar&emp_id=\(emp_id)&advice=\(advice!)&ratingStar=\(ratingStar)"
        }
        
        let request = ZFAsynHttp.sendPostHttp("shopEmp.php", strHTTPBody: strHTTPBody, isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            if error == nil {
                let isGrade = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if self.delegate != nil && self.delegate.respondsToSelector(Selector("empHttp:isGradeSuccess:")){
                        
                        self.delegate.empHttp!(self, isGradeSuccess: isGrade)
                    }
                })
            }
            
        }
        
    }
    
    func selectEmpRankData(){
        let request = ZFAsynHttp.sendGetHttp("shopEmp.php?gain=empRank", isNSUTF8StringEncoding: false)
        
        //3.Connection（发送链接）
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response : NSURLResponse!, data : NSData!, error : NSError!) -> Void in
            
            
            if error == nil {
                
                let jsonEmps = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil) as? NSArray
                
                var empM = Array<ZFEmpModel>()
                
                if jsonEmps != nil {
                    
                    for emp in jsonEmps! {
                        
                        var empModel : ZFEmpModel!
                        
                        empModel = ZFEmpModel.empModelWithDict(emp as! NSDictionary)
                        
                        empM.append(empModel)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        if self.delegate != nil && self.delegate.respondsToSelector(Selector("empHttp:reloadEmpRank:")){
                            self.delegate.empHttp!(self, reloadEmpRank: empM)
                        }
                        
                    })
                    
                    
                }
                
                
            }
        }
    }
   
}
