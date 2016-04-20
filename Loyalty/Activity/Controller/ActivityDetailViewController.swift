//
//  ActivityDetailViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController,HasHiddenNavigation {

    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var toolBar: ActivityToolBar!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var activityDetailDataSource:ActivityDetailDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItems()
        self.activityDetailDataSource = ActivityDetailDataSource(tableView: self.tableView, activity: Activity())
        self.toolBar.activityType = ActivityType.Loyalty
        self.tableView.tableHeaderView?.frame = self.targetImageViewFrame
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}


extension ActivityDetailViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.activityDetailDataSource?.heightForRowAtIndexPath(indexPath) ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.activityDetailDataSource?.isAbleToSelected(indexPath) ?? true
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.activityDetailDataSource?.heightForHeader(section) ?? 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.activityDetailDataSource?.viewForHeader(tableView, section: section)
    }
}

// MARK: - Action
extension ActivityDetailViewController {

}

// For Animation
extension ActivityDetailViewController:ImageTransitionTargetViewController {
    var targetImageView:UIImageView {
        get {
            return self.activityImageView
        }
    }
    
    var targetImageViewFrame: CGRect {
        get {
            return CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width * 8 / 15)
        }
    }
    
    var targetView:UIView {
        get {
            return self.view
        }
    }
}
