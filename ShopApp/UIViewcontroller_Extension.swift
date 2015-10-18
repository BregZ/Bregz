//
//  UIViewcontroller_Extension.swift
//  ShopApp
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

import UIKit

extension UIViewController {
    

    class func viewControllerWithView(view : UIView) -> UIViewController? {
        
        for var next = view.superview; next != nil; next = next?.superview {
            
            let nextResponder : UIResponder = next!.nextResponder()!
            
            if nextResponder.isKindOfClass(UIViewController) {
                return next!.nextResponder()! as? UIViewController
            }
            
        }
        return nil
    }
}

