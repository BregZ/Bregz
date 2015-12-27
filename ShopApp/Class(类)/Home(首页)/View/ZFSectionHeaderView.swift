//
//  ZFSectionHeaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFSectionHeaderViewDelegate : NSObjectProtocol{
    
    optional func sectionHeaderViewBtngClick(sectionHeaderView : ZFSectionHeaderView);
    
}

let ZFSectionHeaderViewID : String = "sectionHeaderView";

class ZFSectionHeaderView: UITableViewHeaderFooterView {
    
    weak var nameView : UIButton!;                      //菜单标题名称
    weak var countView : UILabel!;                      //菜单内容数量
    
    weak var delegate : ZFSectionHeaderViewDelegate?;   //代理
    
    var _menuTitle : ZFMenuTitleModel?;                 //菜单标题模型
    

    //返回一个 MJHeaderView －> 封装
    class func headerViewWithTableView(tableView : UITableView) -> ZFSectionHeaderView{
        
        var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ZFSectionHeaderViewID) as? ZFSectionHeaderView;
        
        if header == nil {
            header = ZFSectionHeaderView(reuseIdentifier: ZFSectionHeaderViewID);
            
        }
        return header!;
        
    }
    
    override init(reuseIdentifier: String?) {
        
        
        super.init(reuseIdentifier: reuseIdentifier);
        
        //添加菜单标题按钮
        self.setNameView()
        
        //设置菜单内容数量
        self.setCountView()
        
    }
    
    //添加菜单标题按钮
    func setNameView(){
        
        let nameView = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
        
        nameView.setBackgroundImage(UIImage.resizableImage(name: "buddy_header_bg"), forState: UIControlState.Normal);
        //        nameView.setBackgroundImage(UIImage(named: "buddy_header_bg_highled"), forState: UIControlState.Highlighted)
        
        nameView.setImage(UIImage(named: "buddy_header_arrow"), forState: UIControlState.Normal);
        
        //设置三角形填充模式为居中
        nameView.imageView?.contentMode = UIViewContentMode.Center;
        
        //设置图片超出bounds 照样显示
        nameView.imageView?.clipsToBounds = false;
        
        //设置对齐方式
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        
        //设置字体颜色
        nameView.setTitleColor(TITLE_BIG_COLOR, forState: UIControlState.Normal);
        
        
        nameView.contentEdgeInsets = UIEdgeInsets(top: 0, left: BIGPADDING, bottom: 0, right: 0);
        nameView.titleEdgeInsets = UIEdgeInsets(top: 0, left: PADDING, bottom: 0, right: 0);
        
        nameView.addTarget(self, action: "nameViewClick:", forControlEvents: UIControlEvents.TouchUpInside);
        self.contentView.addSubview(nameView);
        self.nameView = nameView;
    }
    
    //设置菜单内容数量
    func setCountView(){
        let countView = UILabel();
        //文字对齐方式
        countView.textAlignment = NSTextAlignment.Right;
        //文字颜色
        countView.textColor = TITLE_BIG_COLOR;
        
        self.contentView.addSubview(countView);
        self.countView = countView;
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    var menuTitle : ZFMenuTitleModel?{
        set{
            self._menuTitle = newValue;
            self.nameView.setTitle(newValue!.menuTitle_name, forState: UIControlState.Normal);
            if newValue!.menuContents != nil {
                self.countView.text = "\(newValue!.menuContents!.count)";
            }
            self.didMoveToSuperview();
        }
        get{
            return _menuTitle;
        }
    }
    
    //当一个控件 添加到 父控件中会调用
    
    override func didMoveToSuperview() {
        
        //旋转 三角形 的小图标
        if self._menuTitle!.opened.boolValue {
            //逆时针转90度
            self.nameView.imageView?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
            
        }else{
            
            //恢复没有旋转的样子
            self.nameView.imageView?.transform = CGAffineTransformMakeRotation(0);
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    
    /*
    *一般在这个方法内布局自控件
    *
    *在一个控件的frame发生改变时，系统会自动调用
    */
    
    
    override func layoutSubviews() {
        //必须调用
        super.layoutSubviews();
        /*
        * 设置nameView frame
        */
        self.nameView.frame = self.bounds;
        
        
        /*
        * 设置contenView frame
        */
        let countY : CGFloat = 0;
        let countH : CGFloat = self.frame.size.height;
        let countW : CGFloat = 150.0;
        let countX : CGFloat = self.frame.size.width - PADDING - countW;
        
        self.countView.frame = CGRectMake(countX, countY, countW, countH);
        
    }
    
    /*
    按钮的点击事件
    */
    func nameViewClick(btn : UIButton){
        //取相反值
        self._menuTitle!.opened =  !self._menuTitle!.opened;
        
        if self.delegate != nil && self.delegate!.respondsToSelector(Selector("sectionHeaderViewBtngClick:")) {
            
            delegate!.sectionHeaderViewBtngClick!(self);
            
        }
        
        
    }
    
    deinit {
//        println("ZFSectionHeaderView 被销毁了");
    }

}
