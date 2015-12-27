//
//  ZFNewFeatureViewController.swift
//  ShopApp
//
//  Created by mac on 15/11/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFNewFeatureViewController: UIViewController {
    
    
    ///新特性窗口
    weak var newFeatureView : ZFNewFeatureView!
    
    
    var newFeature : Array<String> = {
        
        let path : String = NSBundle.mainBundle().pathForResource("newFeature.plist", ofType: nil)!
        
        let strArray : Array<String> = NSArray(contentsOfFile: path) as! Array<String>;
    
        
        return strArray;
        
        }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置新特性窗口
        self.setupNewFeatureView()
    }
    
    //设置新特性窗口
    func setupNewFeatureView(){
        
        let newFeatureView : ZFNewFeatureView = ZFNewFeatureView(frame: self.view.frame);
        
        newFeatureView.imagesM = self.newFeature;
        
        newFeatureView.statrExperienceBtnAddTarget(self, action: "statrExperienceBtnDidClick");
        
        self.view.addSubview(newFeatureView);
        
        self.newFeatureView = newFeatureView;
        
    }
    
    //开始按钮被点击调用方法
    func statrExperienceBtnDidClick(){
        
        self.view.window!.rootViewController = ZFTabBarViewController();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        println("ZFNewFeatureViewController deinit")
    }

}
