//
//  ActivityListDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit



class ActivityListDataSource: NSObject {
    var tableView:UITableView?
    var activityType:ActivityType?
    var activityList:[Activity]?
    
    required init(tableView:UITableView, activityType:ActivityType){
        super.init()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.activityType = activityType
        self.tableView?.registerReusableCell(ActivityTableViewCell)
    }
    
    required init(tableView:UITableView, keyword:String){
        super.init()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.registerReusableCell(ActivityTableViewCell)
        self.search(keyword)
    }

    func loadData(){
        if let activityType = self.activityType {
            var point:CGPoint?
            let latitute = UserDefaultTool.floatForKey(latituteKey)
            let longitute = UserDefaultTool.floatForKey(longituteKey)
            if latitute != nil && longitute != nil {
                point = CGPointMake(latitute!, longitute!)
            }
            Activity.query(point, type: activityType) { (activities) in
                self.activityList = activities
                self.tableView?.reloadData()
                NSNotificationCenter.defaultCenter().postNotificationName(LOAD_KEY, object: nil)
            }
        }
    }
    
    func search(keyword:String?) {
        guard let keyword = keyword else { return }
        if keyword.length == 0 {
            return
        }
        Activity.query(keyword) { (activities) in
            self.activityList = activities
            self.tableView?.reloadData()
        }
    }
    
    func estimateHeightForEachRow() -> CGFloat{
        return ActivityTableViewCell.rowHeight
    }
}


extension ActivityListDataSource: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityList?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(indexPath: indexPath) as ActivityTableViewCell
        if let activity = self.activityList?[indexPath.row] {
            if self.activityType != nil {
                activity.queryIsLikedBySelf({ (like) in
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                })
            }
            let activityViewModel = ActivitySimpleViewModel(activity: activity)
            tableViewCell.render(activityViewModel)
        }

        return tableViewCell
    }
    
}
