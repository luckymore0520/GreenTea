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

    //传入按钮颜色的数组（提供默认参数）、图片数组、按钮标题数组以及回调数组
    func updateView(colorArray:[UIColor] = [UIColor.globalLightGreenColor(),UIColor.globalLightBlueColor()],imageArray:[String]!,titleArray:[String]!, clickHandlers:[()->Void]) {
        var buttonArray:[UIButton] = []
        let buttonWidth = self.frame.size.width / CGFloat(titleArray.count)
        for i in 0...imageArray.count-1 {
            let button = UIButton(type: UIButtonType.Custom)
            button.setImage(UIImage(named: imageArray[i]), forState: UIControlState.Normal)
            button.setTitle(" \(titleArray[i])", forState: UIControlState.Normal)
            button.backgroundColor = colorArray[i]
            self.addSubview(button)
            button.tag = i
            button.addTarget(self, action: #selector(ActivityToolBar.onButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            buttonArray.append(button)
            constrain(button,self) {
                button,view in
                button.left == view.left + buttonWidth * CGFloat(i)
                button.top == view.top
                button.height == view.height
                button.width == buttonWidth
            }
        }
        self.clickHandlers = clickHandlers
    }
    
    func onButtonClicked(sender:UIButton) {
        let tag = sender.tag
        clickHandlers[tag]()
    }
}
