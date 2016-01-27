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
    @IBOutlet weak var tableView: UITableView!
    var activityListViewModel:ActivityListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let activityType = self.activityType {
            self.activityListViewModel = ActivityListViewModel()
            self.activityListViewModel?.setUp(self.tableView, activityType: activityType)
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
