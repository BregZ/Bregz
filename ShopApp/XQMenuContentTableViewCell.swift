//
//  XQMenuContentTableViewCell.swift
//  ShopApp
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQMenuContentTableViewCell: UITableViewCell {
    
    
    
    var iconView : UIImageView?
    
    var nameView : UILabel?
    
    var priceView : UILabel?
    
    var introduceView : UILabel?
    
    let padding : CGFloat = 10
    
    var _menuContentModel : XQMenuContentModel?
    
    var menuContentModel : XQMenuContentModel{
        set {
            self._menuContentModel = newValue
            
            self.nameView?.text = self.menuContentModel.menuContent_name
            
            self.priceView?.text = "￥\(self.menuContentModel.menuContent_price!)"
        }
        get {
            return _menuContentModel!
        }
    }
    
    class func menuContentWithTableView(tableView : UITableView) -> XQMenuContentTableViewCell{
        
        let cellId : String = "menuContent"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? XQMenuContentTableViewCell
        
        if cell == nil {
            cell = XQMenuContentTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellId)
        }
        
        
        
        return cell!
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        let iconView : UIImageView = UIImageView()
        self.iconView = iconView
        self.contentView.addSubview(self.iconView!)
        
        let nameView : UILabel = UILabel()
        self.nameView = nameView
        self.contentView.addSubview(self.nameView!)
        
        let priceView : UILabel = UILabel()
        self.priceView = priceView
        self.contentView.addSubview(self.priceView!)
        
        let introduceView : UILabel = UILabel()
        self.introduceView = introduceView
        self.contentView.addSubview(self.introduceView!)
        
        
        
    }
    
    /*
    *一般在这个方法内布局自控件
    *
    *在一个控件的frame发生改变时，系统会自动调用
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(UIView.addLine(0 , y : self.frame.height - 1))
        
        self.setIconViewF(self.iconView!)
        
        self.setNameViewF(self.nameView!)
        
        self.setPriceViewViewF(self.priceView!)
        
        self.setIntroduceViewF(self.introduceView!)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIconViewF(iconView : UIImageView){
        
        let imageX : CGFloat = self.padding
        let imageY : CGFloat = self.padding
        let imageH : CGFloat = 60
        let imageW : CGFloat = 60
        
        iconView.frame = CGRectMake(imageX, imageY, imageW, imageH)
        iconView.backgroundColor = UIColor.redColor()
    }
    
    func setNameViewF(nameView : UILabel) {
        
        let nameX : CGFloat = CGRectGetMaxX(self.iconView!.frame) + self.padding
        let nameY : CGFloat = self.padding
        let nameH : CGFloat = 25
        let nameW : CGFloat = 150
        
        nameView.frame = CGRectMake(nameX, nameY, nameW, nameH)
        
        }
    
    
    func setPriceViewViewF(priceView : UILabel) {
        
        let priceH : CGFloat = self.frame.height
        let priceW : CGFloat = 70
        let priceX : CGFloat = self.frame.width - priceW - self.padding
        let priceY : CGFloat = 0
        priceView.textColor = UIColor.redColor()
        priceView.font = UIFont.systemFontOfSize(23)
        priceView.frame = CGRectMake(priceX, priceY, priceW, priceH)
        
    }
    
    func setIntroduceViewF(introduceView : UILabel) {
        
        let introduceX : CGFloat = self.nameView!.frame.origin.x
        let introduceY : CGFloat = CGRectGetMaxY(self.nameView!.frame) + padding
        let introduceH : CGFloat = 30
        let introduceW : CGFloat = 70
        introduceView.backgroundColor = UIColor.redColor()
        introduceView.frame = CGRectMake(introduceX, introduceY, introduceW, introduceH)
        
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
