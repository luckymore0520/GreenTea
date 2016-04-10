//
//  ImageTransitionFromViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol ImageTransitionFromViewController {
    var fromImageView:UIImageView? { get }
    var fromView:UIView { get }
    func doAnimation(duration:NSTimeInterval, completion:(finished:Bool) -> Void)
}

extension ImageTransitionFromViewController {
    func doAnimation(duration:NSTimeInterval,completion:(finished:Bool) -> Void) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.fromView.alpha = 0
            }, completion: completion)
    }
    
    func finishAnimation(){
        self.fromView.alpha = 1.0
    }
}