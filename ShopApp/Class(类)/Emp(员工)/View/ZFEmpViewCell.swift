//
//  ZFEmpViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFEmpViewCell: UITableViewCell {
    
    class func empViewCellWithTableView(tableView : UITableView) -> ZFEmpViewCell {
        let empViewID : String = "empViewID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(empViewID) as? ZFEmpViewCell
        
        if cell == nil {
            cell = ZFEmpViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: empViewID)
        }
        
        return cell!
    }
    
    weak var empImageView : UIImageView!;        //排名图片
    
    weak var empRankNumber : UILabel!            //排名
    
    weak var empNameView : UILabel!;             //名称
    
    weak var empStatView : ZFStatView! ;         //星级
    
    var _emp : ZFEmpModel?;
    
    var emp : ZFEmpModel {
        set {
            self._emp = newValue;
            
            self.empNameView.text = self.emp.emp_name!;
            self.empStatView.scorePercent = self.emp.emp_grade!;
            
        }
        get {
            return self._emp!;
        }
    }
    
    var empRankImage : ZFEmpRankImageModel? {
        set {
            if newValue != nil {
                
                self.imageView?.image = UIImage(named: newValue!.image);
                if newValue!.rank.toInt() > 3 {
                    self.empRankNumber.text = newValue!.rank;
                } else {
                    self.empRankNumber.text = "";
                }
            }
        }
        get {
            return nil;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.initView();
        
    }
    
    func initView(){
        
        //初始化
        self.initCell();
        
        //员工头像
        self.setupEmpImage();
        
        //排名的数字
        self.setupEmpRankNumber();
        
        
        //u员工名称
        self.setupEmpName();
        
        //员工星级
        self.setupEmpstart();
        
        
    }
    
    //初始化
    func initCell(){
        
        //清除分割线
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        
        //设置背景图片
        self.setupBackgroundView();
    }
    
    //设置背景图片
    func setupBackgroundView(){
        let backgroundView : UIImageView = UIImageView();
        backgroundView.image = UIImage.resizableImage(name: "below_Separator");
        self.backgroundView = backgroundView;
    }
    
    //员工头像
    func setupEmpImage(){
        let empImage : UIImageView = UIImageView(frame: CGRectMake(PADDING, PADDING, 75, 60));
        self.addSubview(empImage);
        self.empImageView = empImage;
    }

    //排名的数字
    func setupEmpRankNumber(){
        let empRankNumber : UILabel = UILabel();
        empRankNumber.font = UIFont.boldSystemFontOfSize(40);
        empRankNumber.textColor = UIColor.redColor();
        empRankNumber.textAlignment = NSTextAlignment.Center;
//        empRankNumber.backgroundColor = UIColor.grayColor();
        self.addSubview(empRankNumber);
        self.empRankNumber = empRankNumber;
    }
    
    //u员工名称
    func setupEmpName(){
        let empName : UILabel = UILabel();
        empName.textColor = UIColor(red: 242/255, green: 109/255, blue: 31/255, alpha: 1);
        empName.font = UIFont.boldSystemFontOfSize(19);
        self.addSubview(empName);
        self.empNameView = empName;
    }
    
    //员工星级
    func setupEmpstart(){
        let empStat : ZFStatView = ZFStatView(frame: CGRectMake(0, 0, 150, 44), numberOfStars: 5);
        self.addSubview(empStat);
        self.empStatView = empStat;

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        //设排名数字frame
        self.setEmpRankNumberF(self.empRankNumber);
        
        //设置名字的frame
        self.setEmpNameF(self.empNameView);
        
        //设置星星的frame
        self.setEmpStatF(self.empStatView);
        
    }
    
    //设排名数字
    func setEmpRankNumberF(empRankNumber : UILabel){
        let rankNumberW : CGFloat = 30;
        let rankNumberH : CGFloat = 50;
        let rankNumberX : CGFloat = (self.empImageView.frame.size.width - rankNumberW) * 0.5 + CGRectGetMinX(self.empImageView.frame) + 7;
        let rankNumberY : CGFloat = CGRectGetMinY(self.empImageView.frame) + 3;
        
        empRankNumber.frame = CGRectMake(rankNumberX, rankNumberY, rankNumberW, rankNumberH)
    }
    
    //设置名字的frame
    func setEmpNameF(empName : UILabel){
        let nameX : CGFloat = BIGPADDING * 2 + CGRectGetMaxX(self.empImageView.frame);
        let nameY : CGFloat = 0;
        let nameW : CGFloat = 50;
        let nameH : CGFloat = self.frame.height;
        
        empName.frame = CGRectMake(nameX, nameY, nameW, nameH);

    }
    //设置星星的frame
    func setEmpStatF(empStat : ZFStatView){
        
        let empStatX : CGFloat = self.frame.width - self.empStatView.frame.width - PADDING;
        let empStatY : CGFloat = (self.frame.height - self.empStatView.frame.height) * 0.5;
        
        empStat.frame.origin = CGPoint(x: empStatX, y: empStatY);
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);

        // Configure the view for the selected state
    }

}
