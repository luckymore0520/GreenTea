//
//  HasHiddenNavigation.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
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
        backButton.frame = CGRectMake(15, 25, image?.size.width ?? 0, image?.size.height ?? 0)
        self.view.addSubview(backButton)
        backButton.addTarget(backButton, action: "onBackButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
    }
}

class BackButton:UIButton {
    weak var viewController:UIViewController?
    func onBackButtonClicked(){
        viewController?.navigationController?.popViewControllerAnimated(true)
    }
}