//
//  ActivityRootViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit


let LOAD_KEY = "LOAD_COMPLETED"

class ActivityRootViewController: UIViewController {
    let activityTypes = [ActivityType.Loyalty, .Promotion]
    var activityViewControllers:[ActivityListViewController] = []
    var locationManager = LocationManager()
    var progressIndicatorView: CircularLoaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = NavigationTransitionManager.sharedManager
        self.buildTitleView()
        self.buildChildViews()
        self.setLeftButton(UserDefaultTool.stringForKey(cityKey) ?? "选择城市",imageName: "定位_白", selector: #selector(ActivityRootViewController.showCityView))
        self.setRightButton("", imageName: "搜索", selector: #selector(ActivityRootViewController.onSearchButtonClicked))
        self.navigationController?.navigationBar.translucent = false
        locationManager.delegate = self
        locationManager.startLocationCity()
        self.progressIndicatorView = CircularLoaderView(frame: CGRectZero)
        self.navigationController?.view.addSubview(self.progressIndicatorView!)
        self.progressIndicatorView?.frame = UIScreen.mainScreen().bounds
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ActivityRootViewController.onContentLoaded), name: LOAD_KEY, object: nil)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func onSearchButtonClicked(){
        let searchViewController = ActivitySearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func onContentLoaded(){
        if let progressIndicatorView = self.progressIndicatorView {
            progressIndicatorView.progress += 0.5
            if progressIndicatorView.progress == 1.0 {
                progressIndicatorView.reveal()
                progressIndicatorView.removeFromSuperview()
                self.progressIndicatorView = nil
                NSNotificationCenter.defaultCenter().removeObserver(self)
            }
        }
    }
}



extension ActivityRootViewController:LocationManagerDelegate {
    func locationCity(cityName: String) {
        self.setLeftButton(cityName,imageName: "定位_白", selector: #selector(ActivityRootViewController.showCityView))
    }
    
    func showCityView(){
        let cityViewController = CityViewController()
        cityViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: cityViewController)
        cityViewController.setLeftButton("取消", selector: #selector(CityViewController.cancelSelect))
        self.presentViewController(navigationController, animated: true, completion: nil)
    }

}

extension ActivityRootViewController:CityViewControllerDelegate {
    func selectCity(city: String) {
        self.setLeftButton(city,imageName: "定位_白", selector:#selector(ActivityRootViewController.showCityView))
        UserDefaultTool.saveValueForKey(cityKey, value: city)
    }
}

// MARK: - Draw UI
extension ActivityRootViewController {
    private func buildTitleView(){
        let segmentControl = UISegmentedControl(items: self.activityTypes.map({
            activity in activity.rawValue
        }))
        segmentControl.addTarget(self, action: #selector(ActivityRootViewController.onTitleChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
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
