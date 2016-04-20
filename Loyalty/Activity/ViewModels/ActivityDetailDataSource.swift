//
//  ActivityDetailDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

enum ActivityDetailRowType:Int,TitlePresentable{
    case ShopInfo = 0;
    case LocationInfo = 1;
    case ActivityTimeInfo = 2;
    case ActivityDetailInfo = 3;
    static func allTypes() -> [[ActivityDetailRowType]]{
        return [[ActivityDetailRowType.ShopInfo,.LocationInfo],[.ActivityTimeInfo],[.ActivityDetailInfo]]
    }
    
    var title:String {
        get {
            switch self {
            case .ActivityTimeInfo:
                return "活动时间"
            case .ActivityDetailInfo:
                return "活动详情"
            default:
                return ""
            }
        }
    }
    
    var titleColor: UIColor {
        return UIColor.globalSectionHeaderColor()
    }
}

class ActivityDetailDataSource:NSObject {
    var tableView:UITableView?
    var activity:Activity?
    let rows = ActivityDetailRowType.allTypes()
    
    required init(tableView:UITableView, activity:Activity){
        super.init()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.activity = activity
    }
    
    func viewForHeader(tableView:UITableView,section:Int) -> UIView? {
        if section == 0 { return nil }
        let cell = tableView.dequeueReusableCell() as ActivityDetailSectionHeaderTableViewCell
        let sectionType = rows[section][0]
        if sectionType.title.length > 0 {
            sectionType.updateTitleLabel(cell.sectionNameLabel)
        }
        return cell
    }
    
    func heightForHeader(section:Int) -> CGFloat {
        return section == 0 ? 0 : 35
    }
    
    func heightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch rows[indexPath.section][indexPath.row] {
        case .ShopInfo:
            return 56
        case .LocationInfo:
            return 32
        case .ActivityTimeInfo:
            return 45
        case .ActivityDetailInfo:
            return 150
        }
    }
    
    func isAbleToSelected(indexPath:NSIndexPath) -> Bool{
        return rows[indexPath.section][indexPath.row].rawValue <= 1
    }
}

extension ActivityDetailDataSource:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return rows.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        switch rows[indexPath.section][indexPath.row] {
        case .ShopInfo:
            cell = tableView.dequeueReusableCell() as ShopInfoTableViewCell
        case .LocationInfo:
            cell = tableView.dequeueReusableCell() as LocationInfoTableViewCell
        case .ActivityTimeInfo:
            cell = tableView.dequeueReusableCell() as ActivityTimeInfoTableViewCell
        case .ActivityDetailInfo:
            cell = tableView.dequeueReusableCell() as ActivityDetailInfoTableViewCell
        }
        return cell!
    }
    
}