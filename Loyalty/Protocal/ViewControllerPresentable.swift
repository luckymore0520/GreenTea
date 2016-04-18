//
//  ViewControllerPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerPresentable {
    func configureNavigationItem()
}

extension ViewControllerPresentable where Self:UIViewController{
    func configureNavigationItem(){
        let leftButton = CancelButton.init(frame:CGRectMake(0, 0, 100, 40))
        leftButton.setTitle("取消", forState: UIControlState.Normal)
        leftButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        leftButton.addTarget(leftButton, action: #selector(CancelButton.onCancelButtonClicked), forControlEvents: UIControlEvents.TouchUpInside)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(UIFont.systemFontSize())
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        let leftBarBarItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItems = [leftBarBarItem]
    }
}

class CancelButton:UIButton {
    func onCancelButtonClicked(){
        self.viewController()?.dismissViewControllerAnimated(true, completion: nil)
    }
}

