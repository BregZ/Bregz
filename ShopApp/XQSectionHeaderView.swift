//
//  XQSectionHeaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol XQSectionHeaderViewDelegate : NSObjectProtocol{
    
    optional func sectionHeaderViewBtngClick(sectionHeaderView : XQSectionHeaderView)
    
}

class XQSectionHeaderView: UITableViewHeaderFooterView {
    
    var nameView : UIButton!
    var countView : UILabel!
    
    var _menuTitle : XQMenuTitleModel?
    
    var delegate : XQSectionHeaderViewDelegate?

    //返回一个 MJHeaderView －> 封装
    class func headerViewWithTableView(tableView : UITableView) -> XQSectionHeaderView{
        
        let ID : String = "header"
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ID) as? XQSectionHeaderView
        
        if header == nil {
            header = XQSectionHeaderView(reuseIdentifier: ID)
            
        }
        return header!
        
    }
    
    override init(reuseIdentifier: String?) {
        
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        let nameView = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        
        nameView.setBackgroundImage(UIImage(named: "buddy_header_bg"), forState: UIControlState.Normal)
//        nameView.setBackgroundImage(UIImage(named: "buddy_header_bg_highled"), forState: UIControlState.Highlighted)
        
        nameView.setImage(UIImage(named: "buddy_header_arrow"), forState: UIControlState.Normal)
        
        //设置三角形填充模式为居中
        nameView.imageView?.contentMode = UIViewContentMode.Center
        //设置图片超出bounds 照样显示
        nameView.imageView?.clipsToBounds = false
        
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        nameView.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
        nameView.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        nameView.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        nameView.addTarget(self, action: "nameViewClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(nameView)
        self.nameView = nameView
        
        let countView = UILabel()
        //        countView.backgroundColor = UIColor.clearColor()
        countView.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(countView)
        self.countView = countView
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var menuTitle : XQMenuTitleModel?{
        set{
            self._menuTitle = newValue
            self.nameView.setTitle(newValue!.menuTitle_name, forState: UIControlState.Normal)
            if newValue!.menuContents != nil {
                self.countView.text = "\(newValue!.menuContents!.count)"
            }
        }
        get{
            return _menuTitle
        }
    }
    
    //当一个控件 添加到 父控件中会调用
    
    override func didMoveToSuperview() {
        //旋转 三角形 的小图标
        if self._menuTitle!.opened.boolValue {
            self.nameView.imageView?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            
        }else{
            self.nameView.imageView?.transform = CGAffineTransformMakeRotation(0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    /*
    *一般在这个方法内布局自控件
    *
    *在一个控件的frame发生改变时，系统会自动调用
    */
    
    
    override func layoutSubviews() {
        //必须调用
        super.layoutSubviews()
        /*
        * 设置nameView frame
        */
        self.nameView.frame = self.bounds
        
        
        /*
        * 设置contenView frame
        */
        let countY : CGFloat = 0
        let countH : CGFloat = self.frame.size.height
        let countW : CGFloat = 150.0
        let countX : CGFloat = self.frame.size.width - 10 - countW
        
        self.countView.frame = CGRectMake(countX, countY, countW, countH)
        
    }
    
    /*
    按钮的点击事件
    */
    func nameViewClick(btn : UIButton){
        //取相反值
        self._menuTitle!.opened =  !self._menuTitle!.opened
        
        if self.delegate != nil && self.delegate!.respondsToSelector(Selector("sectionHeaderViewBtngClick:")) {
            
            delegate!.sectionHeaderViewBtngClick!(self)
            
        }
        
        
    }
    
    

}
