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
    var activityListViewModel:ActivityListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let activityType = self.activityType {
            self.activityListViewModel = ActivityListViewModel(tableView:self.tableView, activityType: activityType)
        }
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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