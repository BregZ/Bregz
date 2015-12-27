//
//  ZFEmpheaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFEmpheaderView: UIView {

    weak var headImageView : ZFHeaPortraitView! ;        //头像
    
    weak var nameView : UILabel! ;                       //名称
    
    weak var iconView : UIImageView!;                    //背景图片
    
    weak var gradeView : UILabel!;                       //评分
    
    weak var rankView : UILabel!;                        //评分排名
    
    weak var statView : ZFStatView!;                     //星级
    
    var _emp : ZFEmpModel?;
    
    var emp : ZFEmpModel {
        set {
            self._emp = newValue;
            
            let call : String = self._emp!.emp_sex! ? "先生" : "女士";
            self.nameView.text = "Holle!,\(self._emp!.emp_name!)\(call)";
            
            if self._emp!.emp_rank != nil {
                
                self.rankView.text = "排名: \(self._emp!.emp_rank!)";
            }
            
            self.statView.scorePercent = self._emp!.emp_grade!;
        }
        get {
            return self._emp!;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        let iconView = UIImageView(frame: frame);
        iconView.image = UIImage(named: "emp_bg");
        //图片模糊
        iconView.insertBlurView(UIBlurEffectStyle.Light);
        self.addSubview(iconView);
        self.iconView = iconView;
        
        //头像
        let headImage : ZFHeaPortraitView = ZFHeaPortraitView(y: frame.origin.y + 30);
        let empPlist : ZFEmpTool = ZFEmpTool();
        let headerImage = empPlist.selectIsHeaderImage();
        if headerImage != nil {
            
          headImage.headImage = headerImage!
            
        }else {
            
            headImage.headImageName = "head";
        }
        self.addSubview(headImage);
        self.headImageView = headImage;
        
        //名称
        let name : UILabel = UILabel();
        name.textAlignment = NSTextAlignment.Center;
        name.textColor = UIColor.grayColor();
        name.frame = CGRectMake(0, CGRectGetMaxY(self.headImageView.frame) , CGRectGetMaxX(self.frame), 44);
        self.addSubview(name);
        self.nameView = name;
        
        //分数
        let frame : CGRect = CGRectMake(0, CGRectGetMaxY(self.nameView.frame), 150, 44);
        let stat : ZFStatView = ZFStatView(frame: frame, numberOfStars: 5);
        stat.allowIncompleteStar = true;
        stat.center.x = self.center.x;
        self.addSubview(stat);
        self.statView = stat;
        
        //评分
        let grade : UILabel = UILabel();
        grade.text = "星级:";
        grade.textAlignment = NSTextAlignment.Right;
        grade.textColor = UIColor.grayColor();
        let gradeW : CGFloat = 50;
        grade.frame = CGRectMake(CGRectGetMinX(self.statView.frame) - gradeW - PADDING, CGRectGetMinY(self.statView.frame) + PADDING , gradeW, 20);
        self.addSubview(grade);
        self.gradeView = grade;
        
        
        //评分排名
        let rank : UILabel = UILabel();
        rank.textColor = UIColor.grayColor();
        rank.frame = CGRectMake(CGRectGetMaxX(self.statView.frame) + PADDING, CGRectGetMinY(self.statView.frame) + PADDING, 100, 20);
        self.addSubview(rank);
        self.rankView = rank;
        
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        if self.iconView != nil {
            //删除图片模糊
            self.iconView.removeBlurView();
            //图片模糊
            self.iconView.insertBlurView(UIBlurEffectStyle.Light);
        }
    }

}
