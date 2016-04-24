//
//  ShopInfoDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/4/24.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit


enum ShopInfoRowType:Int,TitlePresentable{
    case ShopInfo = 0;
    case LocationInfo;
    case ShopDetailInfo;
    case ShopActivityInfo;
    case ContactInfo;
    case Review;
    static func allTypes(isMyOwnShop:Bool) -> [[ShopInfoRowType]]{
        return isMyOwnShop ? [[.ShopInfo,.LocationInfo],[.ShopDetailInfo,.ShopActivityInfo],[.ContactInfo] ] :
            [[.ShopInfo,.LocationInfo],[.ShopDetailInfo] ]
    }
    
    var title:String {
        get {
            switch self {
            case .ShopDetailInfo:
                return "店铺详情"
            case .ContactInfo:
                return "联系方式"
            case .Review:
                return "网友点评"
            default:
                return ""
            }
        }
    }
    
    var titleColor: UIColor {
        return UIColor.globalSectionHeaderColor()
    }
}


class ShopInfoDataSource: NSObject {
    weak var tableView:UITableView?
    var shop:Shop?
    var tableRowInfo:[[ShopInfoRowType]] = []
    init(shop:Shop, tableView:UITableView) {
        super.init()
        self.shop = shop
        self.tableView = tableView
        tableView.dataSource = self
        tableView.registerReusableCell(ShopInfoTableViewCell.self)
        tableView.registerReusableCell(LocationInfoTableViewCell.self)
        tableView.registerReusableCell(ActivityTimeInfoTableViewCell.self)
        tableView.registerReusableCell(ActivityDetailInfoTableViewCell.self)
        tableView.registerReusableCell(ActivityDetailSectionHeaderTableViewCell.self)
        tableRowInfo = ShopInfoRowType.allTypes(shop.isMine)
    }

    func viewForHeader(tableView:UITableView,section:Int) -> UIView? {
        if section == 0 { return nil }
        let cell = tableView.dequeueReusableCell() as ActivityDetailSectionHeaderTableViewCell
        let sectionType = tableRowInfo[section][0]
        if sectionType.title.length > 0 {
            cell.render(sectionType)
        }
        return cell
    }
    
    func heightForHeader(section:Int) -> CGFloat {
        return section == 0 ? 0 : 35
    }
    
    func heightForRowAtIndexPath(indexPath:NSIndexPath) -> CGFloat {
        switch tableRowInfo[indexPath.section][indexPath.row] {
        case .ShopInfo:
            return 56
        case .LocationInfo:
            return 32
        case .ContactInfo:
            return 45
        case .ShopActivityInfo:
            return 45
        case .Review:
            return 50
        case .ShopDetailInfo:
            return 150
        }
    }
}



extension ShopInfoDataSource:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableRowInfo.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tableRowInfo.count {
            return tableRowInfo[section].count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        switch tableRowInfo[indexPath.section][indexPath.row] {
        case .ShopInfo:
            cell = tableView.dequeueReusableCell() as ShopInfoTableViewCell
        case .LocationInfo:
            cell = tableView.dequeueReusableCell() as LocationInfoTableViewCell
        case .ContactInfo:
            cell = tableView.dequeueReusableCell() as ActivityTimeInfoTableViewCell
        case .ShopDetailInfo:
            cell = tableView.dequeueReusableCell() as ActivityDetailInfoTableViewCell
        case .ShopActivityInfo:
            cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "ShopActivityInfo")
            cell?.accessoryType = .DisclosureIndicator
            cell?.textLabel?.text = "我的活动"
            cell?.tintColor = UIColor.globalTitleBrownColor()
        default:
            break
        }
        return cell!
    }
    
}
