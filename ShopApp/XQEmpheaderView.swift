//
//  XQEmpheaderView.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQEmpheaderView: UIView {

    weak var headImageView : XQHeaPortraitView!         //头像
    
    weak var nameView : UILabel!                        //名称
    
    weak var gradeView : UILabel!                       //评分
    
    weak var rankView : UILabel!                        //评分排名
    
    weak var statView : XQStatView!
    
    let padding : CGFloat = 10                          //间距
    
    
    
    var _emp : XQEmpModel?
    
    var emp : XQEmpModel {
        set {
            self._emp = newValue
            
            let call : String = self._emp!.Emp_sex! ? "先生" : "女士"
            self.nameView.text = "Holle!,\(self._emp!.Emp_name!)\(call)"
            
            self.rankView.text = "排名: \(self._emp!.Emp_rank!)"
            
            self.statView.statcount = self._emp!.Emp_grade!
        }
        get {
            return self._emp!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //头像
        let headImage : XQHeaPortraitView = XQHeaPortraitView(y: 30)
        headImage.headImageName = "head"
        self.addSubview(headImage)
        self.headImageView = headImage
        
        //名称
        let name : UILabel = UILabel()
        name.textAlignment = NSTextAlignment.Center
        name.textColor = UIColor.grayColor()
        name.frame = CGRectMake(0, CGRectGetMaxY(self.headImageView.frame) , CGRectGetMaxX(self.frame), 20)
        self.addSubview(name)
        self.nameView = name
        
        //分数
        let stat : XQStatView = XQStatView(frame: CGRectMake(0, CGRectGetMaxY(self.nameView.frame) + self.padding, 0, 0))
        stat.center.x = self.center.x
        self.addSubview(stat)
        self.statView = stat
        
        //评分
        let grade : UILabel = UILabel()
        grade.text = "星级:"
        grade.textAlignment = NSTextAlignment.Right
        grade.textColor = UIColor.grayColor()
        let gradeW : CGFloat = 50
        grade.frame = CGRectMake(CGRectGetMinX(self.statView.frame) - gradeW - self.padding, CGRectGetMinY(self.statView.frame) + self.padding , gradeW, 20)
        self.addSubview(grade)
        self.gradeView = grade
        
        
        //评分排名
        let rank : UILabel = UILabel()
        rank.textColor = UIColor.grayColor()
        rank.frame = CGRectMake(CGRectGetMaxX(self.statView.frame) + self.padding, CGRectGetMinY(self.statView.frame) + self.padding, 100, 20)
        self.addSubview(rank)
        self.rankView = rank
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
