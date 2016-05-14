//
//  ActivityListViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityListViewController: UIViewController {
    var activityType:ActivityType?
    var selectedImageView:UIImageView?
    @IBOutlet weak var tableView: UITableView!
    var activityListDataSource:ActivityListDataSource?
    
    //视图被加载 只执行一次
    override func viewDidLoad() {
        super.viewDidLoad()
        if let activityType = self.activityType {
            self.activityListDataSource = ActivityListDataSource(tableView:self.tableView, activityType: activityType)
        }
        // Do any additional setup after loading the view.
    }
    
    //视图显示 每次显示在屏幕均会执行一次
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.activityListDataSource?.loadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let nextViewController = segue.destinationViewController as? ActivityDetailViewController
            if let indexPath = sender as? NSIndexPath {
                nextViewController?.activity = self.activityListDataSource?.activityList?[indexPath.row]
            }
        }
    }

}

extension ActivityListViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.activityListDataSource?.estimateHeightForEachRow() ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityTableViewCell
        self.selectedImageView = cell.activityImageView
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
    }
}

extension ActivityListViewController:ImageTransitionFromViewController {
    var fromImageView:UIImageView? {
        get {
            return self.selectedImageView
        }
    }
    var fromView:UIView {
        get {
            return self.parentViewController?.view ?? self.view
        }
    }
}

