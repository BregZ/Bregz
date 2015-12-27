//
//  RatingStarView.swift
//  ZFRatingViewDome
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

@objc protocol ZFRatingStarViewDelegate : NSObjectProtocol {
    
    optional func ratingStarView(ratingStarView : ZFRatingStarView, scroePercentDidChange scroePercent : CGFloat)
    
}

class ZFRatingStarView: UIView {
    
    var _scorePercent : CGFloat!//得分值，范围为0--1，默认为1
    var hasAnimation : Bool!//是否允许动画，默认为NO
    var allowIncompleteStar : Bool! //评分时是否允许不是整星，默认为NO

    let FOREGROUND_STAR_IMAGE_NAME = "b27_icon_star_yellow"
    let BACKGROUND_STAR_IMAGE_NAME = "b27_icon_star_gray"
    let DEFALUT_STAR_NUMBER = 5
    let ANIMATION_TIME_INTERVAL = 0.2
    
    var numberOfStars : Int!
    
    var starW : CGFloat!

    weak var foregroundStarView : UIView!
    weak var backgroundStarView : UIView!
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
        self.scorePercent = 1 //默认为1
        self.hasAnimation = false //默认为NO
        self.allowIncompleteStar = false //默认为NO
        
        let foregroundStarView = self.createStarViewWithImage(FOREGROUND_STAR_IMAGE_NAME);
        self.foregroundStarView = foregroundStarView;
        
        let backgroundStarView = self.createStarViewWithImage(BACKGROUND_STAR_IMAGE_NAME);
        self.backgroundStarView = backgroundStarView;
        
        self.addSubview(backgroundStarView)
        self.addSubview(foregroundStarView)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "userTapRateView:")
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)

    }
    
    func userTapRateView(gesture : UITapGestureRecognizer){
        
        let tapPoint : CGPoint = gesture.locationInView(self)
        let offset : CGFloat = tapPoint.x
        let realStarScore : CGFloat = offset / (self.starW)
        let starScore : CGFloat = self.allowIncompleteStar.boolValue ? realStarScore : CGFloat(ceilf(Float(realStarScore)));
        self.scorePercent = starScore / CGFloat(self.numberOfStars);
        
    }
    
    func createStarViewWithImage(imageName : String) -> UIView{
        let  view : UIView = UIView(frame: self.bounds)
        
        view.clipsToBounds = true;
        view.backgroundColor = UIColor.clearColor()
        for i in 0 ..< self.numberOfStars {
            let imageView : UIImageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = CGRectMake(CGFloat(i) * self.starW, 0, self.starW, self.bounds.size.height)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            view.addSubview(imageView)
        }
        
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let weakSelf : ZFRatingStarView = self
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
            
            
            if (newValue < 0) {
                self._scorePercent = 0;
            } else if (newValue > 1) {
                self._scorePercent = 1;
            } else {
                self._scorePercent = newValue;
            }
            
            if self.delegate != nil && self.delegate.respondsToSelector(Selector("ratingStarView:scroePercentDidChange:")){
                self.delegate.ratingStarView!(self, scroePercentDidChange: newValue)
            }
            
            self.setNeedsLayout()
            
        }
        get {
            return self._scorePercent
        }
    }

}
