//
//  ZFMenuTitlelCell.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFMenuTitlelCell: UITableViewCell {
    
    var menuTitleView : UILabel!        //标题View
    
    var _menuTile : String?             //标题
    
    var menuTile : String {
        set {
            self._menuTile = newValue
            self.menuTitleView.text = self._menuTile
        }
        get {
            return self._menuTile!
        }
    }
    
    static let menuTitleID : String = "menuTitleID"
    
    //获得ZFMenuTitlelCell
    class func menuTitleCellWithTableView(tableView : UITableView) -> ZFMenuTitlelCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(menuTitleID) as? ZFMenuTitlelCell
        
        if cell == nil {
            
            cell = ZFMenuTitlelCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: menuTitleID)

            let selectimageView = UIImageView(image: UIImage.resizableImage(name: "select_menu_title_bg"))
            cell!.selectedBackgroundView = selectimageView
            
            let imageView = UIImageView(image: UIImage.resizableImage(name: "shop_title_bg"))
            cell!.backgroundView = imageView
        }
        
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //添加
        let meunTltle : UILabel = UILabel()
        self.menuTitleView = meunTltle
        self.contentView.addSubview(self.menuTitleView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置MenuTitleView 的 frame
    func setMenuTitleViewF(menuTitleView : UILabel){
        
        let menuTitleX : CGFloat = 0
        let menuTitleY : CGFloat = 0
        let menuTitleW : CGFloat = self.frame.width
        let menuTitleH : CGFloat = self.frame.height
        
        menuTitleView.frame = CGRectMake(menuTitleX, menuTitleY, menuTitleW, menuTitleH)
        
        menuTitleView.textAlignment = NSTextAlignment.Center

    }
    
    /*
    *一般在这个方法内布局自控件
    *
    *在一个控件的frame发生改变时，系统会自动调用
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置MenuTitleView 的 frame
        self.setMenuTitleViewF(self.menuTitleView)
        
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
