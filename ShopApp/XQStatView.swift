//
//  XQStatView.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class XQStatView: UIView {

    let viewWH : CGFloat = 32
    
    var _statcount : CGFloat?
    
    var statcount : CGFloat{
        set {
            self._statcount = newValue
            
            self.setNeedsDisplay()
        }
        get {
            return self._statcount!
        }
    }
    
    let statAllCount : CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, self.viewWH * self.statAllCount, self.viewWH))
        
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func drawRect(rect: CGRect) {
        
        if self._statcount != nil {
            
            for i in 0 ..< Int(statAllCount) {
                let image : UIImage!
                
                if i < Int(statcount) {
                    image = UIImage(named: "star_full")
                } else if i < Int(statcount) {
                    image = UIImage(named: "star_empty")
                }else{
                    
                    let imageName : String = self.statcount - CGFloat(i) < 0.5 ? "star_empty" : "star_full_empty"
                    image = UIImage(named: imageName)
                }
                
                image!.drawAtPoint(CGPoint(x: self.viewWH * CGFloat(i) , y: 0))
            }
            
        }
        
    }
   

}
