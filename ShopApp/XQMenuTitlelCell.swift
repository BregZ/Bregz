//
//  XQMenuTitlelCell.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQMenuTitlelCell: UITableViewCell {
    
    var menuTitleView : UILabel!        //标题
    
    var _menuTile : String?
    
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
    
    class func menuTitleCellWithTableView(tableView : UITableView) -> XQMenuTitlelCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(menuTitleID) as? XQMenuTitlelCell
        
        if cell == nil {
            
            cell = XQMenuTitlelCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: menuTitleID)

            let imageView = UIImageView()
            
            imageView.image = UIImage.resizableImage(name: "select_menu_title_bg")
            cell!.selectedBackgroundView = imageView
            
//            cell!.backgroundView = UIImage(named: "")
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
