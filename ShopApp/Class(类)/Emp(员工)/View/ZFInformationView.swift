//
//  ZFInformationView.swift
//  ShopApp
//
//  Created by mac on 15/11/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFInformationViewDelegate : NSObjectProtocol {
    optional func informationView(informationView: ZFInformationView, tableViewBeginMove move: CGPoint)
}

class ZFInformationView: UITableView, UITableViewDataSource,UITableViewDelegate {
    
    weak var moveDelegate : ZFInformationViewDelegate!

    lazy var empsM : Array<ZFEmpModel> = {
        
        var emps : Array<ZFEmpModel> = Array<ZFEmpModel>()
        
        return emps
        
        }();
    
    var emps : Array<ZFEmpModel>{
        set{
            self.empsM = newValue;
            
            self.reloadData();
        }
        get{
            return self.empsM;
        }
    }
    
    lazy var empRankImageM : Array<ZFEmpRankImageModel> = {
        
        let path : String = NSBundle.mainBundle().pathForResource("empRank.plist", ofType: nil)!
        
        let dticArray : Array<NSDictionary> = NSArray(contentsOfFile: path) as! Array<NSDictionary>;
        
        var empRankImageArray = Array<ZFEmpRankImageModel>();
        
        for dict in dticArray {
            var empRankImage :  ZFEmpRankImageModel = ZFEmpRankImageModel.empRankImageWithDict(dict);
            
            empRankImageArray.append(empRankImage);
            
            //获取plist 文件
        }
        
        return empRankImageArray
        
        }();
    
    
    override init(frame : CGRect){
        super.init(frame: frame, style: UITableViewStyle.Plain)
        
        //行高
        self.rowHeight = 80;
        
        //分割线
        self.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        //滑动条
        self.showsVerticalScrollIndicator = false;
        
        //设置分区 hearderView 高度
        self.sectionHeaderHeight = 50;
        
        self.delegate = self;
        self.dataSource = self;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.empsM.count < 10 ? self.empsM.count : 10
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ZFEmpViewCell.empViewCellWithTableView(tableView)
        
        
        cell.emp = self.empsM[indexPath.row]
        
        cell.empRankImage = self.empRankImageM[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //提示view
        let textTipsView :ZFInformationSectionHeaderView = ZFInformationSectionHeaderView.informationSectionHeaderViewWithTableView(tableView)
        
        return textTipsView;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if self.moveDelegate != nil && self.moveDelegate.respondsToSelector(Selector("informationView:tableViewBeginMove:")){
            
            self.moveDelegate.informationView!(self, tableViewBeginMove: scrollView.contentOffset)
            
        }
    }

}
