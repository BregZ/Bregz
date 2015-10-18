//
//  XQTabBarViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTabBar()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabBar(){
        
        let firstVc = XQHomeViewController()
        let firstNavigation : UINavigationController = XQNavigationViewController(rootViewController: firstVc)
        firstNavigation.tabBarItem.title = "首页"
        
        let secondVc = XQSeatCollectionViewController()
        let secondNavigation : UINavigationController = XQNavigationViewController(rootViewController: secondVc)
        secondNavigation.tabBarItem.title = "座位"
        
        let thirdVc = XQOrderViewController()
        let thirdNavigation : UINavigationController = XQNavigationViewController(rootViewController: thirdVc)
        thirdNavigation.tabBarItem.title = "订单"
        
        let fourthVc = XQInformationViewController()
        let fourtNavigation : UINavigationController = XQNavigationViewController(rootViewController: fourthVc)
        fourtNavigation.tabBarItem.title = "个人"
        
        self.viewControllers = [firstNavigation,secondNavigation,thirdNavigation,fourtNavigation]
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
