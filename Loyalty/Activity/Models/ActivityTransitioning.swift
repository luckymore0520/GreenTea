//
//  ActivityTransitioning.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit 

class ActivityTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func transitionWithoutAnimation(transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView()!.addSubview((transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view)!)
        transitionContext.completeTransition(true)
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? ActivityRootViewController
            else {
            transitionWithoutAnimation(transitionContext)
            return
        }
        guard let imageTransitionFromViewController = fromViewController.currentViewController() as? ImageTransitionFromViewController else {
            transitionWithoutAnimation(transitionContext)
            return
        }
        guard let imageTransitionTargetViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? ImageTransitionTargetViewController else {
            transitionWithoutAnimation(transitionContext)
            return
        }
        guard let containerView = transitionContext.containerView() else {
            transitionWithoutAnimation(transitionContext)
            return
        }
        guard let selectedImageView = imageTransitionFromViewController.fromImageView else {
            transitionWithoutAnimation(transitionContext)
            return
        }
        
        containerView.addSubview(imageTransitionTargetViewController.targetView)
        // draw a snapshot of the imageView
        let absoluteFromImageViewFrame = selectedImageView.superview?.convertRect(selectedImageView.frame, toView: containerView) ?? selectedImageView.frame
        let snapShotImageView = UIImageView(frame: absoluteFromImageViewFrame)
        snapShotImageView.image = selectedImageView.image
        snapShotImageView.alpha = 0.0
        containerView.addSubview(snapShotImageView)
        snapShotImageView.frame = absoluteFromImageViewFrame
        snapShotImageView.contentMode = selectedImageView.contentMode
        let absoluteTargetImageViewFrame = imageTransitionTargetViewController.targetImageViewFrame
        // from view prepare for animation
        imageTransitionTargetViewController.prepareForAnimate()
        // start the first animation
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            snapShotImageView.frame = absoluteTargetImageViewFrame
            snapShotImageView.alpha = 1.0
            }, completion: nil)
        imageTransitionFromViewController.doAnimation(0.5) { (finished) -> Void in
            imageTransitionTargetViewController.doAnimation(0.3, completion: { (finished) -> Void in
                snapShotImageView.removeFromSuperview()
                imageTransitionFromViewController.finishAnimation()
                transitionContext.completeTransition(true)
            })
        }
        
        
        
    }
}
