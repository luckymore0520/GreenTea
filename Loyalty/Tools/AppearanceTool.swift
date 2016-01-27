//
//  AppearanceTool.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

func configureGlobalAppearce() {
    //导航栏
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(UIColor.globalGreenColor(), size: CGSizeMake(UIScreen.mainScreen().bounds.size.width, 64))
        , forBarMetrics: UIBarMetrics.Default)
    let backImage = UIImage(named: "nav_back")
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-2333, 0), forBarMetrics: UIBarMetrics.Default)
    let shadow = NSShadow()
    shadow.shadowOffset = CGSizeZero
    let titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSShadowAttributeName:shadow]
    UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
    UINavigationBar.appearance().backIndicatorImage = backImage
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
    UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    
    //TabBar
    UITabBar.appearance().tintColor = UIColor.globalGreenColor()
}
