//
//  ZFViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化navigationBar
        self.initNavigationBar()
        
        //初始化tabBarItem
        self.initTabBarItem()
    }
    
    //初始化navigationBar
    func initNavigationBar(){
        self.navigationBar.barTintColor = THEME_COLOR;
        
        let textAttributes : Dictionary<String, AnyObject> = [
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        self.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    //初始化tabBarItem
    func initTabBarItem(){
        
        let attr : Dictionary<NSObject, AnyObject> = [
            NSForegroundColorAttributeName: THEME_MIN_COLOR
        ];
        
        self.tabBarItem.setTitleTextAttributes(attr, forState: UIControlState.Selected);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        
        if self.viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true;
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
