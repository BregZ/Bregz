//
//  XQEmpViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQEmpViewCell: UITableViewCell {
    
    class func empViewCellWithTableView(tableView : UITableView) -> XQEmpViewCell {
        let empViewID : String = "empViewID"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(empViewID) as? XQEmpViewCell
        
        if cell == nil {
            cell = XQEmpViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: empViewID)
        }
        
        return cell!
    }
    
    weak var empImageView : UIImageView!        //排名图片
    
    weak var empNameView : UILabel!             //名称
    
    weak var empStatView : XQStatView!          //星级
    
    let padding : CGFloat = 10
    
    var _emp : XQEmpModel?
    
    var emp : XQEmpModel {
        set {
            self._emp = newValue
            
            self.empNameView.text = self.emp.Emp_name!
            self.empStatView.statcount = self.emp.Emp_grade!
            
        }
        get {
            return self._emp!
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let empImage : UIImageView = UIImageView(frame: CGRectMake(self.padding, self.padding, 60, 60))
        self.addSubview(empImage)
        self.empImageView = empImage
        
        let empName : UILabel = UILabel()
        self.addSubview(empName)
        self.empNameView = empName
        
        let empStat : XQStatView = XQStatView(frame: CGRectMake(0, 0, 0, 0))
        self.addSubview(empStat)
        self.empStatView = empStat
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.setEmpNameF(self.empNameView)
        
        self.setEmpStatF(self.empStatView)
        
    }
    
    func setEmpNameF(empName : UILabel){
        let nameX : CGFloat = self.padding + CGRectGetMaxX(self.empImageView.frame)
        let nameY : CGFloat = 0
        let nameW : CGFloat = 50
        let nameH : CGFloat = self.frame.height
        
        empName.frame = CGRectMake(nameX, nameY, nameW, nameH)
        
        empName.backgroundColor  = UIColor.redColor()
    }
    
    func setEmpStatF(empStat : XQStatView){
        
        let empStatX : CGFloat = self.frame.width - self.empStatView.frame.width - self.padding
        let empStatY : CGFloat = (self.frame.height - self.empStatView.frame.height) * 0.5
        
        empStat.frame.origin = CGPoint(x: empStatX, y: empStatY)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
