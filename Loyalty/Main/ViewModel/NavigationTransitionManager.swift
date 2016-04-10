//
//  NavigationTransitionManager.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

class NavigationTransitionManager:NSObject {
    private static let sharedInstance:NavigationTransitionManager = NavigationTransitionManager()
    let activityTransitioning:ActivityTransitioning = ActivityTransitioning()
    class var sharedManager : NavigationTransitionManager {
        return sharedInstance
    }
    
    
}

extension NavigationTransitionManager:UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC.isKindOfClass(ActivityRootViewController.classForCoder()) && toVC.isKindOfClass(ActivityDetailViewController.classForCoder()) {
            return self.activityTransitioning
        }
        return nil
    }
}