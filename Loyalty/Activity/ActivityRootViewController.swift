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
    var activityViewControllers:[ActivityListViewController] = []
    var locationManager = LocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = NavigationTransitionManager.sharedManager
        self.buildTitleView()
        self.buildChildViews()
        self.navigationController?.navigationBar.translucent = false
        locationManager.delegate = self
        locationManager.startLocationCity()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
}

extension ActivityRootViewController:LocationManagerDelegate {
    func locationCity(cityName: String) {
        self.setLeftButton(cityName, selector: "selectCity")
    }
    
    func selectCity(){
        let cityViewController = CityViewController()
        self.presentViewController(cityViewController, animated: true, completion: nil)
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
        for activityType in self.activityTypes {
            let activityViewController = self.storyboard?.instantiateViewControllerWithIdentifier(String(ActivityListViewController.classForCoder())) as! ActivityListViewController
            activityViewController.activityType = activityType
            activityViewController.view.frame = self.view.frame
            activityViewController.view.hidden = true
            self.view.addSubview(activityViewController.view)
            self.addChildViewController(activityViewController)
            self.activityViewControllers.append(activityViewController)
        }
        self.activityViewControllers[0].view.hidden = false
    }
    
    func currentViewController() -> ActivityListViewController? {
        if let segmentControl = self.navigationItem.titleView as? UISegmentedControl {
            return self.activityViewControllers[segmentControl.selectedSegmentIndex]
        }
        return nil
    }
}

// MARK: - Events
extension ActivityRootViewController {
    func onTitleChanged(segmentControl:UISegmentedControl) {
        log.info("\(segmentControl.selectedSegmentIndex)")
        for activityViewController in activityViewControllers {
            activityViewController.view.hidden = true
        }
        activityViewControllers[segmentControl.selectedSegmentIndex].view.hidden = false
    }
}
