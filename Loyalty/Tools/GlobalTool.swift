//
//  GlobalTool.swift
//  Loyalty
//
//  Created by WangKun on 16/5/14.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation


func appDelegate() -> AppDelegate {
    return UIApplication.sharedApplication().delegate as! AppDelegate
}

func tabBarController()->UITabBarController? {
    guard let window = appDelegate().window else { return nil}
    return window.rootViewController as? UITabBarController
}

func showCard(activityId:String) {
    guard let window = appDelegate().window else { return }
    guard let rootViewController = window.rootViewController as? UITabBarController else { return }
    guard let navigationController = rootViewController.childViewControllers[1] as? UINavigationController else { return }
    guard let myCardViewController = navigationController.viewControllers[0] as? MyCardViewController else { return }
    rootViewController.selectedIndex = 1
    myCardViewController.setSelectedActivity(activityId)
    
    
}