//
//  ActivityDetailViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

class ActivityDetailViewModel:NSObject {
    var tableView:UITableView?
    var activity:Activity?
    
    required init(tableView:UITableView, activity:Activity){
        super.init()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.activity = activity
    }
}

extension ActivityDetailViewModel:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default :
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell() as ShopInfoTableViewCell
        return cell
    }
    
}