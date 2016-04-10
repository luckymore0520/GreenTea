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
    var needLoyaltyCard:Bool = true
    var activityType:ActivityType? {
        willSet {
            guard let activityType = newValue else { return }
            updateView(activityType)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    func updateView(activityType:ActivityType) {
        let guideButton = UIButton(type: UIButtonType.Custom)
        guideButton.setImage(UIImage(named: "导航"), forState: .Normal)
        guideButton.backgroundColor = UIColor.globalLightGreenColor()
        guideButton.setTitle("  导航", forState: .Normal)
        self.addSubview(guideButton)
        switch activityType {
        case .Promotion:
            constrain(guideButton,self) {
                guideButton, view in
                guideButton.left == view.left
                guideButton.top == view.top
                guideButton.height == view.height
                guideButton.width == view.width
            }
            break
        case .Loyalty:
            constrain(guideButton,self) {
                guideButton, view in
                guideButton.left == view.left
                guideButton.top == view.top
                guideButton.height == view.height
                guideButton.width == view.width / 2.0
            }
            let collectButton = UIButton(type: UIButtonType.Custom)
            collectButton.backgroundColor = UIColor.globalLightBlueColor()
            collectButton.setImage(UIImage(named: "集点"), forState: .Normal)
            collectButton.setTitle("  集点", forState: .Normal)
            self.addSubview(collectButton)
            constrain(collectButton,self) {
                collectButton, view in
                collectButton.right == view.right
                collectButton.top == view.top
                collectButton.height == view.height
                collectButton.width == view.width / 2.0
            }
            break
        }
    }
}
