//
//  ZFSeatCollectionViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

///座位
class ZFSeatCollectionViewCell: UICollectionViewCell {
    
    weak var iconView : UIImageView!         //座位图片
    
    weak var titleView : UILabel!            //座位座位号
    
    weak var seatIdView : UILabel!          ////座位号
    
    var _seat : ZFSeatModel?                //座位座位信息
    
    ///没有客人颜色
    let galyColor : UIColor = UIColor(red: 213/225, green: 213/225, blue: 213/225, alpha: 1);
    
    ///有客人颜色
    let redColor : UIColor = UIColor(red: 253/255, green: 194/255, blue: 63/255, alpha: 1);
    
    var seat : ZFSeatModel{
        
        set{
            self._seat = newValue;
            
            self.titleView.text = self._seat!.seat_name;
            
            let imageName : String = self._seat!.seat_state!.boolValue ? "seat_can" : "seat_no_can";
            
            self.iconView.image = UIImage.resizableImage(name: imageName);
            
            self.seatIdView.backgroundColor = self._seat!.seat_state!.boolValue ? self.galyColor : self.redColor;
            
            self.seatIdView.text = "\(self._seat!.seat_id!)";
        }
        get{
            return _seat!;
        }
    }
    
    //初始化cell
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.whiteColor();
        
        //图片
        self.setupIconView();
        
        
        //座位名称
        self.setupTitleView();
        
        //座位号
        self.setupSeatIdView();
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //图片
    func setupIconView() {
        
        let iconX : CGFloat = PADDING;
        let iconY : CGFloat = PADDING;
        let iconW : CGFloat = self.frame.width - PADDING * 2;
        let iconH : CGFloat = 100;
        
        let iconView = UIImageView(frame: CGRectMake(iconX, iconY, iconW, iconH));
        
        self.contentView.addSubview(iconView);
        self.iconView = iconView;

    }
    
    //座位名称
    func setupTitleView(){
        
        let titleX : CGFloat = 0;
        let titleY : CGFloat = CGRectGetMaxY(self.iconView.frame) + PADDING;
        let titleW : CGFloat = self.frame.width;
        let titleH : CGFloat = 30;
        
        let titleView : UILabel = UILabel(frame: CGRectMake(titleX, titleY, titleW, titleH));
        
        titleView.backgroundColor = UIColor(patternImage: UIImage(named: "seat_name_bg")!);
        
        titleView.textColor = UIColor.whiteColor();
        
        titleView.textAlignment = NSTextAlignment.Center;

        self.contentView.addSubview(titleView);
        self.titleView = titleView;
    }
    

    //座位号
    func setupSeatIdView(){
        
        let seatIdViewX : CGFloat = 0;
        let seatIdViewY : CGFloat = 0;
        let seatIdViewW : CGFloat = 30;
        let seatIdViewH : CGFloat = 30;
        
        let seatIdView : UILabel = UILabel(frame: CGRectMake(seatIdViewX, seatIdViewY, seatIdViewW, seatIdViewH));
        
        seatIdView.center = self.iconView.center;
        
        seatIdView.textColor = UIColor.whiteColor();
        
        seatIdView.layer.cornerRadius = seatIdViewW * 0.5;
        
        seatIdView.layer.masksToBounds = true;
        
        seatIdView.textAlignment = NSTextAlignment.Center;
        
        self.addSubview(seatIdView);
        
        self.seatIdView = seatIdView;
        
    }
    
    
}
