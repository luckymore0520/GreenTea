//
//  ActivityToolBar.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Cartography

class ActivityToolBar: UIView {
    var clickHandlers:[()->Void] = []
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    func updateView(colorArray:[UIColor] = [UIColor.globalLightGreenColor(),UIColor.globalLightBlueColor()],imageArray:[String]!,titleArray:[String]!, clickHandlers:[()->Void]) {
        var buttonArray:[UIButton] = []
        for i in 0...imageArray.count-1 {
            let button = UIButton(type: UIButtonType.Custom)
            button.setImage(UIImage(named: imageArray[i]), forState: UIControlState.Normal)
            button.setTitle(" \(titleArray[i])", forState: UIControlState.Normal)
            button.backgroundColor = colorArray[i]
            self.addSubview(button)
            button.tag = i
            button.addTarget(self, action: #selector(ActivityToolBar.onButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            buttonArray.append(button)
        }
        if imageArray.count == 1 {
            constrain(buttonArray[0],self) {
                button, view in
                button.left == view.left
                button.top == view.top
                button.height == view.height
                button.width == view.width
            }
        } else {
            constrain(buttonArray[0],self) {
                button, view in
                button.left == view.left
                button.top == view.top
                button.height == view.height
                button.width == view.width / 2.0
            }
            constrain(buttonArray[1],self) {
                button, view in
                button.right == view.right
                button.top == view.top
                button.height == view.height
                button.width == view.width / 2.0
            }
        }
        self.clickHandlers = clickHandlers
    }
    
    func onButtonClicked(sender:UIButton) {
        let tag = sender.tag
        clickHandlers[tag]()
    }
}
