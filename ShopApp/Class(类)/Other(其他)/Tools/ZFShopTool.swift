//
//  ZFShopTool.swift
//  ShopApp
//
//  Created by mac on 15/12/1.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFShopTool: NSObject {
    
    //选择跟根控制器
    class func selectRootViewContrller(){
        
        //沙盒中的版本号
        let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults();
        let lastVersion : String? = defaults.stringForKey("CFBundleVersion");
        
        let currrentVersion : String = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        
        if currrentVersion == lastVersion {
            
            //拿到根控制器
            UIApplication.sharedApplication().keyWindow!.rootViewController = ZFTabBarViewController()
            
        }else {
            
            //拿到根控制器
            UIApplication.sharedApplication().keyWindow!.rootViewController = ZFNewFeatureViewController();
            
            defaults.setObject(currrentVersion, forKey: "CFBundleVersion")
            defaults.synchronize();
            
        }

        
    }
    
    
    //原始方法
    //先出现版本控制器，后出现登录界面
    func selectRootVc(){
        //沙盒中的版本号
        /*
        let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults();
        let lastVersion : String? = defaults.stringForKey("CFBundleVersion");
        
        let currrentVersion : String = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        
        if currrentVersion == lastVersion {
            
            let tool : ZFEmpTool = ZFEmpTool();
            let saveEmps : Array<ZFSaveLoginEmpModel>? = tool.selectSaveEmp()
            
            let selectRootVc : Bool = saveEmps != nil && saveEmps![0].isLoginState == true
            
            if selectRootVc {
                let saveEmp = ZFSaveEmpModel.shareInstance();
                saveEmp.emp_id = saveEmps![0].emp_id
            }
            
            self.window?.rootViewController = selectRootVc ? ZFTabBarViewController() : ZFLoginViewController()
            
        }else {
            
            self.window?.rootViewController = ZFNewFeatureViewController();
            
            defaults.setObject(currrentVersion, forKey: "CFBundleVersion")
            defaults.synchronize();
            
        }
*/
        
    }
   
}
