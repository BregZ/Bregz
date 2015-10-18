//
//  XQSeatCollectionViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQSeatCollectionViewCell: UICollectionViewCell {
    
    let padding : CGFloat = 10          //间距
    
    var iconView : UIImageView!         //图片
    
    var titleView : UILabel!            //座位号
    
    var _seat : XQSeatModel?            //座位信息
    
    var seat : XQSeatModel{
        
        set{
            self._seat = newValue
            
            self.titleView.text = self._seat!.seat_name
            
            let imageName : String = self._seat!.seat_state!.boolValue ? "seat_can" : "seat_no_can"
            
            self.iconView.image = UIImage.resizableImage(name: imageName)
            
            
        }
        get{
            return _seat!
        }
    }
    
    //初始化cell
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        //图片
        self.iconView = getIconView()
        self.contentView.addSubview(self.iconView)
        
        //座位号
        self.titleView = getTitleView()
        self.contentView.addSubview(self.titleView)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //图片
    func getIconView() -> UIImageView {
        
        let iconX : CGFloat = self.padding
        let iconY : CGFloat = self.padding
        let iconW : CGFloat = self.frame.width - self.padding * 2
        let iconH : CGFloat = 100
        
        let iconView = UIImageView(frame: CGRectMake(iconX, iconY, iconW, iconH))
        
        return iconView
    }
    
    //座位号
    func getTitleView() -> UILabel{
        
        let titleX : CGFloat = 0
        let titleY : CGFloat = CGRectGetMaxY(self.iconView.frame) + padding
        let titleW : CGFloat = self.frame.width
        let titleH : CGFloat = 30
        
        let titleView : UILabel = UILabel(frame: CGRectMake(titleX, titleY, titleW, titleH))
        
        titleView.backgroundColor = UIColor.greenColor()
        
        titleView.textAlignment = NSTextAlignment.Center
        
        
        return titleView
    }
    

    
    
}
