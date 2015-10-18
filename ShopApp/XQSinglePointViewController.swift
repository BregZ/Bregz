//
//  XQSinglePointViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQSinglePointViewController: UIViewController,XQMenuTitlelViewDelegate,XQMenuContentCellDelegate,XQShoppingCarViewDelegate,XQShoppingCartShowMenuContentCellDelegate,XQShopCarHeaderViewDelegate {
    
    weak var menuTitlelView : XQMenuTitlelView!          //菜单标题
    
    weak var menuContentView : XQMenuContentView!        //菜单内容
    
    weak var shopCarView : XQShoppingCarView!            //购物车
    
    var badgeValue : Int = 0                        //购物车提示信息
    
    weak var windowBg : UIButton!                        //购物车弹出后window背景
    
    var isOpenShopCar : Bool = true
    
    lazy var orderContents : Dictionary<String,XQOrderContentModel> = {
        return Dictionary<String,XQOrderContentModel>()
    }()
    
    lazy var menuTitles : Array<XQMenuTitleModel> = {
        var array = Array<XQMenuTitleModel>()
        for i in 0...2 {
            let menuTitle = XQMenuTitleModel()
            
            menuTitle.menuTitle_name = "menuTitle\(i)"
            
            
            var array2 = Array<XQMenuContentModel>()
            
            for j in 0...i+2 {
                let menuContent = XQMenuContentModel()
                
                menuContent.menuContent_id = j
                
                menuContent.menuContent_name = "menuContent\(j)"
                
                menuContent.menuContent_price = 10 + 10 * j
                
                array2.append(menuContent)
            }
            
            menuTitle.menuContents = array2
            
            array.append(menuTitle)
        }
        
        return array
        
        }()


    override func viewDidLoad() {
        super.viewDidLoad()

        //购物车
        let shopCar = XQShoppingCarView()
        self.shopCarView = shopCar
        self.shopCarView.delegate = self
        self.view.addSubview(self.shopCarView)
        
        //菜单标题
        let menuContent = self.getMenuContentView()
        self.menuContentView = menuContent
        self.view.addSubview(self.menuContentView)

        //菜单内容
        let menuTitle = getMenuTitlelView()
        self.menuTitlelView = menuTitle
        self.menuTitlelView.XQdelegate = self
        self.menuTitlelView.menuTitles = self.menuTitles
        self.view.addSubview(self.menuTitlelView)
        
        //购物车弹出后window背景
        let bg : UIButton = getWindowBg()
        self.windowBg = bg
        self.windowBg.backgroundColor = UIColor.blackColor()
        self.windowBg.alpha = 0.2
        self.windowBg.hidden = self.isOpenShopCar
        self.windowBg.addTarget(self, action: "windowBgClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.windowBg)
        
        //将 shopCarView 移到view子图层的最上面
        self.view.bringSubviewToFront(self.shopCarView)
    }
    
    func windowBgClick(){
        self.isOpenShopCar = !self.isOpenShopCar
        self.windowBg.hidden = self.isOpenShopCar
        
        self.shopCarView.transform = CGAffineTransformMakeTranslation(0, 0)
        //
        self.shopCarView.removeMenuContentView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //菜单内容
    func getMenuContentView() -> XQMenuContentView{
        let menuContentX : CGFloat = self.view.frame.width * 0.3
        let menuContentY : CGFloat = 0
        let menuContentW : CGFloat = self.view.frame.width - menuContentX
        let menuContentH : CGFloat = CGRectGetMinY(self.shopCarView.frame) - menuContentY
        
        return XQMenuContentView(frame: CGRectMake(menuContentX, menuContentY, menuContentW, menuContentH))
    }
    
    //菜单标题
    func getMenuTitlelView() -> XQMenuTitlelView{
        let menuTitleX : CGFloat = 0
        let menuTitleY : CGFloat = 66
        let menuTitleW : CGFloat = CGRectGetMinX(self.menuContentView.frame)
        let menuTitleH : CGFloat = self.menuContentView.frame.height
        
        return XQMenuTitlelView(frame: CGRectMake(menuTitleX, menuTitleY, menuTitleW, menuTitleH))
    }
    
    //购物车弹出后window背景
    func getWindowBg() -> UIButton{
        let btnX : CGFloat = 0
        let btnY : CGFloat = 66
        let btnW : CGFloat = self.view.frame.width
        let btnH : CGFloat = self.view.frame.height
        
        return UIButton(frame: CGRectMake(btnX, btnY, btnW, btnH))
        
    }
    
    func menuTitlelView(menuTitlelView: XQMenuTitlelView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menuContent : Array<XQMenuContentModel> = self.menuTitles[indexPath.row].menuContents as! Array<XQMenuContentModel>
        self.menuContentView.menuContents = menuContent
    }
    
    func menuContentCell(menuContentCell: XQMenuContentCell, didClickAddBtn: UIButton, orderContent: XQOrderContentModel) {
        self.badgeValue += 1
        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue
        
//        println(self.badgeValue)
        
        self.addOrderContent(orderContent)
    }
    
    //添加食品购物车
    func addOrderContent (orderContent: XQOrderContentModel) {
        if orderContents[orderContent.orderContentName!] == nil {
            orderContents[orderContent.orderContentName!] = orderContent
        } else {
            orderContents[orderContent.orderContentName!]?.orderContentNumber += 1
        }

    }
    
    func shoppingCarView(shoppingCarView: XQShoppingCarView, didClickShopCarBtn: XQShoppingCartBtn) {
        
        
        if self.badgeValue != 0 && self.isOpenShopCar {
            self.isOpenShopCar = !self.isOpenShopCar
            
            self.windowBg.hidden = self.isOpenShopCar

            let moveY : CGFloat = self.shopCarView.addMenuContentView(Array(self.orderContents.values))
            
            self.shopCarView.transform = CGAffineTransformMakeTranslation(0, -moveY)
        }
    }
    
    func shoppingCartShowMenuContentCell(menuContentCell: XQShoppingCartShowMenuContentCell, btnType: XQShoppingCartShowMenuContentCellBtnType, isRemvoeData: Bool) {
        
        if isRemvoeData {
            
            //删除数据
            self.orderContents.removeValueForKey(menuContentCell.nameView.text!)
            
            
            
            if self.orderContents.count == 0 {
                
                self.windowBgClick()
                
            }else if CGFloat(self.orderContents.count) * XQShoppingCartShowMenuContentCellHieght < XQShoppingCartShowMenuContentViewMaxMoveY {
                //刷新表格
                let moveY : CGFloat = self.shopCarView.addMenuContentView(Array(self.orderContents.values))
                
                self.shopCarView.transform = CGAffineTransformMakeTranslation(0, -moveY)
            }
            
        }
        
        if btnType == XQShoppingCartShowMenuContentCellBtnType.AddBtn {
            self.badgeValue += 1
        }else{
            self.badgeValue -= 1
        }
        
        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue
    }
    
    func shopCarHeaderView(ShopCarHeaderView: XQShopCarHeaderView, removeAllMenuConutBtn: UIButton) {
        //删除全部数据
        self.orderContents.removeAll(keepCapacity: true)
        
        //删除标题
        self.badgeValue = 0
        self.shopCarView.shopCarBtn!.badgeValue = self.badgeValue
        
        //删除购物车
        self.windowBgClick()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
