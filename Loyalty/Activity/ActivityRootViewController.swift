//
//  ActivityRootViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityRootViewController: UIViewController {
    let activityTypes = [ActivityType.Loyalty, .Promotion]
    var activityViewControllers:[ActivityListViewController]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildTitleView()
        self.buildChildViews()
        self.navigationController?.navigationBar.translucent = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
}

// MARK: - Draw UI
extension ActivityRootViewController {
    private func buildTitleView(){
        let segmentControl = UISegmentedControl(items: self.activityTypes.map({
            activity in activity.rawValue
        }))
        segmentControl.addTarget(self, action: Selector("onTitleChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        segmentControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentControl
    }
    
    private func buildChildViews(){
        self.activityViewControllers = []
        for activityType in self.activityTypes {
            let activityViewController = self.storyboard?.instantiateViewControllerWithIdentifier(String(ActivityListViewController.classForCoder())) as! ActivityListViewController
            activityViewController.activityType = activityType
            activityViewController.view.frame = self.view.frame
            activityViewController.view.hidden = true
            self.view.addSubview(activityViewController.view)
            self.addChildViewController(activityViewController)
            self.activityViewControllers?.append(activityViewController)
        }
        self.activityViewControllers![0].view.hidden = false
    }
}

// MARK: - Events
extension ActivityRootViewController {
    func onTitleChanged(segmentControl:UISegmentedControl) {
        log.info("\(segmentControl.selectedSegmentIndex)")
        for activityViewController in self.activityViewControllers! {
            activityViewController.view.hidden = true
        }
        self.activityViewControllers![segmentControl.selectedSegmentIndex].view.hidden = false
    }
}
