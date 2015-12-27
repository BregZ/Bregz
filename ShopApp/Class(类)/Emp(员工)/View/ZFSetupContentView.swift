//
//  ZFSetupContentView.swift
//  ShopApp
//
//  Created by mac on 15/11/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFSetupContentViewDelegate : NSObjectProtocol{
    
    optional func setupContentView(setupContentView : ZFSetupContentView, didDeselectRowAtIndexPath indexPath: NSIndexPath) ;
    
}

class ZFSetupContentView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    weak var setupContentViewdelegate : ZFSetupContentViewDelegate!
    
    var setupContent : Array<ZFSetupContentModel> = {
        let path : String = NSBundle.mainBundle().pathForResource("setupContent.plist", ofType: nil)!
        
        let dticArray : Array<NSDictionary> = NSArray(contentsOfFile: path) as! Array<NSDictionary>;
        
        var setupContentArray = Array<ZFSetupContentModel>();
        
        for dict in dticArray {
            var setupContent :  ZFSetupContentModel = ZFSetupContentModel(dict: dict);
            
            setupContentArray.append(setupContent);
            
            //获取plist 文件
        }
        
        return setupContentArray
    }()
    
    let setupContentViewRowHeight : CGFloat = 50;
    
    let setupContentViewTopEdgeInset : CGFloat = 10;

    override init(frame: CGRect) {
        
        var newFrame : CGRect = frame
        newFrame.size.height = CGFloat(setupContent.count) * setupContentViewRowHeight + setupContentViewTopEdgeInset
        
        super.init(frame: newFrame, style: UITableViewStyle.Plain)
        
        self.rowHeight = setupContentViewRowHeight
        
        self.backgroundView = UIImageView(image: UIImage.resizableImage(name: "emp_alrat_bg"));
        
        self.backgroundColor = UIColor.clearColor();
        
        self.contentInset = UIEdgeInsets(top: setupContentViewTopEdgeInset, left: 0, bottom: 0, right: 0)
        
        
        
        self.delegate = self;
        self.dataSource = self;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setupContent.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ZFSetupContentCell = ZFSetupContentCell.setupContentCellWithTableView(tableView)
        
        cell.setupContent =  self.setupContent[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.setupContentViewdelegate != nil && self.setupContentViewdelegate.respondsToSelector("setupContentView:didDeselectRowAtIndexPath:") {
            self.setupContentViewdelegate.setupContentView!(self, didDeselectRowAtIndexPath: indexPath);
        }
    }
    
    deinit{
//        println("ZFSetupContentView 被销毁")
    }

}
