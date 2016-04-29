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
    var activityListViewModel:ActivityListDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let activityType = self.activityType {
            self.activityListViewModel = ActivityListDataSource(tableView:self.tableView, activityType: activityType)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.activityListViewModel?.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let nextViewController = segue.destinationViewController as? ActivityDetailViewController
            if let indexPath = sender as? NSIndexPath {
                nextViewController?.activity = self.activityListViewModel?.activityList?[indexPath.row]
            }
        }
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

extension ActivityListViewController:UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.activityListViewModel?.estimateHeightForEachRow() ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ActivityTableViewCell
        self.selectedImageView = cell.activityImageView
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
    }
}