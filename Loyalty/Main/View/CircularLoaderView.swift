//
//  CircularLoaderView.swift
//  MiBox2.0
//
//  Created by yangyang on 16/4/15.
//  Copyright © 2016年 MiBox. All rights reserved.
//

import UIKit

class CircularLoaderView: UIView {
    
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if (newValue > 1) {
                circlePathLayer.strokeEnd = 1
            } else if (newValue < 0) {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    func labelConfigure(){
        let label = UILabel()
        label.text = "Loading"
        label.textColor = UIColor.globalGreenColor()
        label.bounds = CGRectMake(0, CGRectGetMidY(circlePathLayer.bounds) - 80, circlePathLayer.bounds.maxX, 20)
        label.frame = label.bounds
        label.textAlignment = .Center
        self.addSubview(label)
    }
    
    func configure() {
        progress = 0
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clearColor().CGColor
        circlePathLayer.strokeColor = UIColor.globalGreenColor().CGColor
        layer.addSublayer(circlePathLayer)
        backgroundColor = UIColor.globalViewColor()
    }
    
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) -  CGRectGetMidY(circleFrame)
        return circleFrame
    }
    
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalInRect: circleFrame())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().CGPath
        labelConfigure()
    }
    
    func reveal() {
        // 1
        backgroundColor = UIColor.clearColor()
        progress = 1
        // 2
        circlePathLayer.removeAnimationForKey("strokeEnd")
        // 3
        circlePathLayer.removeFromSuperlayer()
        superview?.layer.mask = circlePathLayer
        
        
        // 1
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        let finalRadius = sqrt((center.x*center.x) + (center.y*center.y))
        let radiusInset = finalRadius - circleRadius
        let outerRect = CGRectInset(circleFrame(), -radiusInset, -radiusInset)
        let toPath = UIBezierPath(ovalInRect: outerRect).CGPath
        // 2
        let fromPath = circlePathLayer.path
        let fromLineWidth = circlePathLayer.lineWidth
        // 3
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circlePathLayer.lineWidth = 2*finalRadius
        circlePathLayer.path = toPath
        CATransaction.commit()
        // 4
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2*finalRadius
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        // 5
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        circlePathLayer.addAnimation(groupAnimation, forKey: "strokeWidth")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        superview?.layer.mask = nil
    }
}
