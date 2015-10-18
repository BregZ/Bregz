//
//  XQShowFootViewController.swift
//  ShopApp
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQShowFootViewController: UIViewController {
    
    let padding : CGFloat = 10          //间距
    
    weak var iconView : UIImageView!         //食品图片
    
    weak var priceView : UILabel!            //食品价格
    
    weak var nameView : UILabel!             //食品名字
    
    weak var introduceView : UITextField!        //食品内容
    
    weak var promptTextView : UILabel!
    
    var windowW : CGFloat = UIScreen.mainScreen().bounds.width
    
    var _menuContent : XQMenuContentModel?
    
    var menuContent : XQMenuContentModel {
        set {
            self._menuContent = newValue
            
            self.nameView.text = "名称："+self.menuContent.menuContent_name!
            self.priceView.text = "￥\(self.menuContent.menuContent_price!)"
            if self.menuContent.menuContent_introduce != nil {
                self.introduceView.text = self.menuContent.menuContent_introduce!
            }
            
        }
        
        get {
            return self._menuContent!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //self.veiw的属性配置
    func initView(){
        self.view.backgroundColor = UIColor.whiteColor()
        
        //食品图片
        let iconView : UIImageView =  UIImageView()
        self.setIconViewF(iconView)
        self.iconView = iconView
        self.view.addSubview(iconView)
        
        //食品名字
        let nameView : UILabel = UILabel()
        nameView.textColor = UIColor.grayColor()
        self.nameView = nameView
        self.setNameViewF(nameView)
        self.view.addSubview(nameView)
        
        //食品价格
        let priceView : UILabel = UILabel()
        self.priceView = priceView
        priceView.textAlignment = NSTextAlignment.Right
        self.setPriceViewViewF(priceView)
        self.view.addSubview(priceView)
        
        //分割线
        self.view.addSubview(UIView.addLine(0, y: CGRectGetMaxY(self.nameView.frame) + padding))
        
        //提示
        let  promptText : UILabel = getPromptTextViewl()
        promptTextView = promptText
        self.view.addSubview(promptTextView)
        
        //分割线
        self.view.addSubview(UIView.addLine(0, y: CGRectGetMaxY(promptTextView.frame) + padding))
        
        //食品内容
        let introduceView : UITextField = UITextField()
        introduceView.enabled = false
        self.introduceView = introduceView
        self.setIntroduceViewF(introduceView)
        self.view.addSubview(introduceView)
        
        
    }
    
    //食品图片
    func setIconViewF(iconView : UIImageView){
        
        let imageX : CGFloat = self.padding
        let imageY : CGFloat = self.padding + 66
        let imageH : CGFloat = 200
        let imageW : CGFloat = windowW - 2 * self.padding
        
        iconView.frame = CGRectMake(imageX, imageY, imageW, imageH)
        iconView.backgroundColor = UIColor.redColor()
    }
    
    //食品名字
    func setNameViewF(nameView : UILabel) {
        
        let nameX : CGFloat = self.padding
        let nameY : CGFloat = CGRectGetMaxY(self.iconView.frame) + self.padding
        let nameH : CGFloat = 44
        let nameW : CGFloat = windowW * 0.5 - self.padding
        
        nameView.frame = CGRectMake(nameX, nameY, nameW, nameH)
        
    }
    
    //食品价格
    func setPriceViewViewF(priceView : UILabel) {
        
        let priceH : CGFloat = self.nameView.frame.height
        let priceW : CGFloat = windowW * 0.4
        let priceX : CGFloat = self.nameView.frame.width
        let priceY : CGFloat = self.nameView.frame.origin.y
        
        priceView.font = UIFont.systemFontOfSize(25)
        priceView.textColor = UIColor.redColor()
        priceView.frame = CGRectMake(priceX, priceY, priceW, priceH)
        
    }
    
    //食品内容
    func setIntroduceViewF(introduceView : UITextField) {
        
        let introduceX : CGFloat = self.nameView!.frame.origin.x
        let introduceY : CGFloat = CGRectGetMaxY(self.promptTextView!.frame) + padding * 2
        let introduceH : CGFloat = UIScreen.mainScreen().bounds.height - self.padding - introduceY
        let introduceW : CGFloat = windowW - 2 * self.padding
        introduceView.backgroundColor = UIColor.redColor()
        introduceView.frame = CGRectMake(introduceX, introduceY, introduceW, introduceH)
        
    }
    
    //提示
    func getPromptTextViewl() -> UILabel {
        
        let PromptTextX : CGFloat = self.padding
        let PromptTextY : CGFloat = CGRectGetMaxY(self.nameView.frame) + self.padding
        let PromptTextW : CGFloat = windowW - self.padding * 2
        let PromptTextH : CGFloat = 30
        
        let label : UILabel = UILabel()
        
        label.text = " 介 绍 "
        
        label.frame = CGRectMake(PromptTextX, PromptTextY, PromptTextW, PromptTextH)
        
        
        
        return label
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
