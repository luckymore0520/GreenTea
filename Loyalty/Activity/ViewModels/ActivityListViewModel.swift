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
    private var activityList:Array<Activity>?
    
    required init(tableView:UITableView, activityType:ActivityType){
        super.init()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.activityType = activityType
        self.tableView?.registerReusableCell(ActivityTableViewCell)
        self.loadData()
    }

    func loadData(){
    }
    
    func estimateHeightForEachRow() -> CGFloat{
        return ActivityTableViewCell.rowHeight
    }
}


extension ActivityListDataSource: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(indexPath: indexPath) as ActivityTableViewCell
        return tableViewCell
    }
    
}
