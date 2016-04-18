//
//  UIViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    func setRightButton(text: String, selector:Selector , fontSize : CGFloat = UIFont.systemFontSize() )->UIButton {
        let rightButton = UIButton.init(frame: CGRectMake(0, 0, 60, 40))
        rightButton.setTitle(text, forState: UIControlState.Normal)
        rightButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rightButton.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        let rightBarItem = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItems = [rightBarItem]
        return rightButton
    }
    
    func setLeftButton(text: String, imageName:String = "", selector:Selector ,  fontSize : CGFloat = UIFont.systemFontSize() )->UIButton {
        let leftButton = UIButton.init(frame:CGRectMake(0, 0, 100, 40))
        let trueText = imageName.length > 0 ? "  "+text : text
        leftButton.setTitle(text, forState: UIControlState.Normal)
        leftButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        leftButton.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        let leftBarBarItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItems = [leftBarBarItem]
        return leftButton
    }
}