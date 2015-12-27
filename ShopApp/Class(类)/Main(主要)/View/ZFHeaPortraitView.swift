//
//  ZFHeaPortraitView.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFHeaPortraitView: UIView {
    
    //创建手势识别器
    weak var gesture : UITapGestureRecognizer?
    
    let headRadius : CGFloat = 65
    
    let lineW : CGFloat = 6
    
    let headY : CGFloat = 100
    
    //以图片名字画头像
    var _headImageName : String?
    
    var headImageName : String {
        set {
            self._headImageName = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return self._headImageName!
        }
    }
    
    //以图片画头像
    var _headImage : UIImage!
    
    var headImage : UIImage {
        set {
            self._headImage = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return self._headImage!
        }
    }
    
    
    init(y : CGFloat) {
        let viewH : CGFloat = (self.headRadius + self.lineW) * 2;
        let viewW : CGFloat = viewH;
        let viewX : CGFloat = (WINDOW_WIDTH - viewW) * 0.5;
        super.init(frame: CGRectMake(viewX, y, viewW,  viewH))
        
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext();
        
        UIColor.whiteColor().set();
        let headerImageBorderWH : CGFloat = (self.headRadius + self.lineW) * 2;
        CGContextAddEllipseInRect(context, CGRectMake(0, 0, headerImageBorderWH, headerImageBorderWH));
        CGContextFillPath(context);
        
        
        //画圆
        let headerImageWH : CGFloat = self.headRadius * 2;
        let headerImageXY : CGFloat = lineW
        CGContextAddEllipseInRect(context, CGRectMake(headerImageXY, headerImageXY, headerImageWH, headerImageWH));
        
        //将超出所画形状的图片像素 剪掉
        CGContextClip(context);
        
        CGContextFillPath(context);
        
        var image : UIImage = UIImage()
        
        if self._headImageName != nil {
 
            image = UIImage(named: self.headImageName)!;
            
            self._headImageName = nil;

        }else if self._headImage != nil {
            
            image = self.headImage;
            
            self._headImage = nil;
            
        }
        image.drawInRect(CGRectMake(headerImageXY, headerImageXY, headerImageBorderWH-headerImageXY, headerImageBorderWH-headerImageXY));
    }
    
    func setGestureRecognizer(target: AnyObject, action: Selector){
        //创建手势识别器
        let gesture : UITapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        //点击一次
        gesture.numberOfTapsRequired = 1
        //添加手势识别器
        self.addGestureRecognizer(gesture)
        
        self.gesture = gesture;
        
    }
   /* */
    
    deinit {
        
        if self.gesture != nil {
            
            //删除手势识别器
            self.removeGestureRecognizer(self.gesture!)
        }
    }

}
