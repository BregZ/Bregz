//
//  ZFZFSetupContentCell.swift
//  ShopApp
//
//  Created by mac on 15/11/14.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

let setupContentCellId : String = "setupContentCellId"

class ZFSetupContentCell: UITableViewCell {
    
    var _setupContent :  ZFSetupContentModel!
    
    weak var iconView : UIImageView!
    
    weak var titleView : UILabel!
    
    var setupContent :  ZFSetupContentModel {
        set{
            self._setupContent = newValue;
            
            self.iconView?.image = UIImage(named: newValue.iconName)
            self.titleView?.text = newValue.title
            
        }
        get{
            return self._setupContent
        }
    }
    
    class func setupContentCellWithTableView(tableView : UITableView) -> ZFSetupContentCell{
        
        var cell : ZFSetupContentCell? = tableView.dequeueReusableCellWithIdentifier(setupContentCellId) as? ZFSetupContentCell
        
        if cell == nil {
            cell = ZFSetupContentCell(style: UITableViewCellStyle.Default, reuseIdentifier: setupContentCellId);
            
            cell!.selectionStyle = UITableViewCellSelectionStyle.None;
            
            cell?.backgroundColor = UIColor.clearColor();
        }
        
        return cell!;
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //设置图片View
        self.seupiconView();
        
        //设置标题View
        self.setupTitleView();
        
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置图片View
    func seupiconView(){
        
        let iconViewW : CGFloat = 44;
        let iconViewH : CGFloat = 44;
        
        let iconView : UIImageView = UIImageView();
        iconView.frame.size = CGSizeMake(iconViewW, iconViewH);
        iconView.contentMode = UIViewContentMode.Center;
        self.contentView.addSubview(iconView);
        
        self.iconView = iconView;
        
    }
    
    //设置标题View
    func setupTitleView(){
        let titleViewX : CGFloat = CGRectGetMaxY(self.iconView.frame);
        let titleViewY : CGFloat = 0;
        
        
        let titleView : UILabel = UILabel();
        
        titleView.frame.origin = CGPoint(x: titleViewX, y: titleViewY);
        
        titleView.textAlignment = NSTextAlignment.Center;
        
        
        titleView.textColor = UIColor.whiteColor();
        
        self.contentView.addSubview(titleView);
        
        self.titleView = titleView;
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        self.seupiconViewF();
        
        self.setupTitleViewF();
    }
    
    //设置图片View的frame
    func seupiconViewF(){
        let iconViewX : CGFloat = 10;
        let iconViewY : CGFloat = (self.frame.size.height - self.iconView.frame.size.width) * 0.5;
        
        self.iconView.frame.origin = CGPoint(x: iconViewX, y: iconViewY);
        
    }
    
    //设置标题View的frame
    func setupTitleViewF(){
        
        let titleViewW : CGFloat = self.frame.size.width - self.titleView.frame.origin.x;
        let titleViewH : CGFloat = self.frame.size.height;
        
        self.titleView.frame.size = CGSizeMake(titleViewW, titleViewH);
    }
    
    
    deinit{
//        println("ZFSetupContentCell 被销毁")
    }

}
