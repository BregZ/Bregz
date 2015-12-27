//
//  ZFTabBarViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTabBar()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabBar(){
        
        
        
        let homeVc = ZFHomeViewController();
        self.setupTabBarItem(homeVc, title: "首页", imageName: "tab_imgae_home", selectcedImageName: "tab_imgae_home_select");
        
        let seatVc = ZFSeatCollectionViewController();
        self.setupTabBarItem(seatVc, title: "座位", imageName: "tab_image_seat", selectcedImageName: "tab_image_seat_select");
        
        
        let ordersVc = ZFOrderViewController();
        self.setupTabBarItem(ordersVc, title: "订单", imageName: "tab_image_order", selectcedImageName: "tab_image_order_select");
        
        
        let empVc = ZFInformationViewController();
        self.setupTabBarItem(empVc, title: "个人", imageName: "tab_image_Emp", selectcedImageName: "tab_image_Emp_select");
        
    }
    
    func setupTabBarItem(vc : UIViewController, title : String, imageName: String, selectcedImageName: String){
        
        vc.title = title;
        let nav : UINavigationController = ZFNavigationViewController(rootViewController: vc);
        nav.tabBarItem.image = UIImage(named: imageName);
        nav.tabBarItem.selectedImage = UIImage(named: selectcedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        self.addChildViewController(nav)
    }
    
    deinit {
        println("ZFTabBarViewController 被销毁了")
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
