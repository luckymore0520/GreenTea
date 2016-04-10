//
//  HasHiddenNavigation.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import Cartography
import UIKit

protocol HasHiddenNavigation {
    func configureNavigationItems();
}

extension HasHiddenNavigation where Self:UIViewController{
    func configureNavigationItems(){
        let backButton = BackButton(type: UIButtonType.Custom)
        backButton.viewController = self
        let image = UIImage(named: "nav_back_shadow")
        backButton.setImage(image, forState: UIControlState.Normal)
        self.view.addSubview(backButton)
        constrain(backButton, self.view) { backButton, view in
            backButton.left == view.left + 15
            backButton.top == view.top + 25
            backButton.width == image?.size.width ?? 0
            backButton.height == image?.size.height ?? 0
        }
        backButton.addTarget(backButton, action: "onBackButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
    }
}

class BackButton:UIButton {
    weak var viewController:UIViewController?
    func onBackButtonClicked(){
        viewController?.navigationController?.popViewControllerAnimated(true)
    }
}