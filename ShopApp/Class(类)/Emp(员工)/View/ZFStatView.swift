//
//  ZFStatView.swift
//  ShopApp
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

class ZFStatView: UIView {

    var _scorePercent : CGFloat!//得分值，范围为0--1，默认为1
    var hasAnimation : Bool!//是否允许动画，默认为NO
    var allowIncompleteStar : Bool! //评分时是否允许不是整星，默认为NO
    
    let FOREGROUND_STAR_IMAGE_NAME = "b27_icon_star_yellow"
    let BACKGROUND_STAR_IMAGE_NAME = "b27_icon_star_gray"
    let DEFALUT_STAR_NUMBER = 5
    let ANIMATION_TIME_INTERVAL = 0.2
    
    var foregroundStarView : UIView!
    var backgroundStarView : UIView!
    
    var numberOfStars : Int!
    
    var starW : CGFloat!
    
    weak var delegate : ZFRatingStarViewDelegate!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, numberOfStars : Int) {
        super.init(frame: frame)
        
        self.numberOfStars = numberOfStars
        
        self.starW = self.bounds.size.width / CGFloat(numberOfStars)
        
        self.buildDataAndUI()
    }
    
    func buildDataAndUI(){
        self.scorePercent = 1; //默认为1
        self.allowIncompleteStar = false; //默认为NO
        self.hasAnimation = false; //默认为NO
        self.foregroundStarView = self.createStarViewWithImage(FOREGROUND_STAR_IMAGE_NAME);
        self.backgroundStarView = self.createStarViewWithImage(BACKGROUND_STAR_IMAGE_NAME);
        
        self.addSubview(backgroundStarView);
        self.addSubview(foregroundStarView);
        
    }
    
    func createStarViewWithImage(imageName : String) -> UIView{
        let  view : UIView = UIView(frame: self.bounds);
        
        view.clipsToBounds = true;
        view.backgroundColor = UIColor.clearColor();
        for i in 0 ..< self.numberOfStars {
            let imageView : UIImageView = UIImageView(image: UIImage(named: imageName));
            imageView.frame = CGRectMake(CGFloat(i) * self.starW, 0, self.starW, self.bounds.size.height);
            imageView.contentMode = UIViewContentMode.ScaleAspectFit;
            view.addSubview(imageView)
        }
        
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let weakSelf : ZFStatView = self
        let animationTimeInterval = self.hasAnimation.boolValue ? ANIMATION_TIME_INTERVAL : 0;
        UIView.animateWithDuration(animationTimeInterval, animations: { () -> Void in
            weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
        })
    }
    
    var scorePercent : CGFloat {
        set {
            if self._scorePercent != nil && self._scorePercent == newValue {
                return
            }
            
            let value = newValue / CGFloat(self.numberOfStars)
            
            if (value < 0) {
                self._scorePercent = 0;
            } else if (value > 1) {
                self._scorePercent = 1;
            } else {
                self._scorePercent = value;
            }
            
            self.setNeedsLayout()
            
        }
        get {
            return self._scorePercent
        }
    }
   

}
