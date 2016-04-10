//
//  ImageTransitionable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol ImageTransitionTargetViewController {
    var targetImageView:UIImageView { get }
    var targetView:UIView { get }
    func prepareForAnimate()
    func doAnimation(duration:NSTimeInterval, completion:(finished:Bool) -> Void)
}

extension ImageTransitionTargetViewController {
    func prepareForAnimate() {
        self.targetImageView.alpha = 0
        self.targetView.alpha = 0
        self.targetView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen().bounds.size.height)
    }
    
    func doAnimation(duration:NSTimeInterval,completion:(finished:Bool) -> Void) {
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.targetView.transform = CGAffineTransformIdentity
            self.targetView.alpha = 1.0
            }) { (finished) -> Void in
                self.targetImageView.alpha = 1
                completion(finished: finished)
        }
    }
}