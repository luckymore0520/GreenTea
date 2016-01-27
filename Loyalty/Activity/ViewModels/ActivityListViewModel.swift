//
//  ActivityListViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit



class ActivityListViewModel: NSObject {
    var tableView:UITableView?
    var activityType:ActivityType?
    private var activityList:Array<Activity>?
    
    func setUp(tableView:UITableView, activityType:ActivityType){
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.activityType = activityType
        self.tableView?.registerNib(ActivityTableViewCell.nib(), forCellReuseIdentifier: ActivityTableViewCell.cellIdentifier())
        self.loadData()
    }
    
    func loadData(){
    }
}

extension ActivityListViewModel: UITableViewDelegate {
    
}

extension ActivityListViewModel: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(ActivityTableViewCell.cellIdentifier(), forIndexPath: indexPath)
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 260
    }
}
