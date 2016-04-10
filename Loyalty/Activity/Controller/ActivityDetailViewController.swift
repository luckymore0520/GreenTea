//
//  ActivityDetailViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController,HasHiddenNavigation {

    @IBOutlet weak var toolBar: ActivityToolBar!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var activityDetailViewModel:ActivityDetailViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItems()
        self.activityDetailViewModel = ActivityDetailViewModel(tableView: self.tableView, activity: Activity())
        self.toolBar.activityType = ActivityType.Loyalty
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
        return self.activityDetailViewModel?.heightForRowAtIndexPath(indexPath) ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.activityDetailViewModel?.isAbleToSelected(indexPath) ?? true
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.activityDetailViewModel?.heightForHeader(section) ?? 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.activityDetailViewModel?.viewForHeader(tableView, section: section)
    }
}

// MARK: - Action
extension ActivityDetailViewController {

}