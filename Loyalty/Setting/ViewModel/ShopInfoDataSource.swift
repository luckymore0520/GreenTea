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
        return isMyOwnShop ? [[.ShopInfo,.LocationInfo],[.ShopDetailInfo],[.ShopActivityInfo],[.ContactInfo],[.Review] ] :
            [[.ShopInfo,.LocationInfo],[.ShopDetailInfo],[.Review] ]
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
            case .ShopActivityInfo:
                return "我的活动"
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
    var shopViewModel:ShopInfoViewModel?
    var tableRowInfo:[[ShopInfoRowType]] = []
    
    init(shop:Shop, tableView:UITableView) {
        super.init()
        self.shopViewModel = ShopInfoViewModel(shop: shop)
        self.tableView = tableView
        self.tableRowInfo = ShopInfoRowType.allTypes(shop.isMine())
        tableView.dataSource = self
        tableView.registerReusableCell(ShopInfoTableViewCell.self)
        tableView.registerReusableCell(LocationInfoTableViewCell.self)
        tableView.registerReusableCell(ActivityTimeInfoTableViewCell.self)
        tableView.registerReusableCell(ActivityDetailInfoTableViewCell.self)
        tableView.registerReusableCell(ActivityDetailSectionHeaderTableViewCell.self)
        tableView.registerReusableCell(SimpleActivityTableViewCell.self)
    }
    
    func render(imageView:UIImageView) {
        self.shopViewModel?.updateImageView(imageView)
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
        if tableRowInfo[indexPath.section][0] == .ShopActivityInfo {
            return 90
        }
        switch tableRowInfo[indexPath.section][indexPath.row] {
        case .ShopInfo:
            return 56
        case .LocationInfo:
            return 32
        case .ContactInfo:
            return 45
        case .Review:
            return 50
        case .ShopDetailInfo:
            return 30 + (self.shopViewModel?.detail.minHeight(UIScreen.mainScreen().bounds.width - 30) ?? 0)
        default:
            return 0
        }
    }
}



extension ShopInfoDataSource:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableRowInfo.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tableRowInfo.count {
            if tableRowInfo[section][0] == .ShopActivityInfo {
                return self.shopViewModel?.activityList?.count ?? 0
            }
            return tableRowInfo[section].count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let staticRowArray = tableRowInfo[indexPath.section]
        if staticRowArray[0] == .ShopActivityInfo {
            let activityCell = tableView.dequeueReusableCell(indexPath: indexPath) as SimpleActivityTableViewCell
            if let activity = self.shopViewModel?.activityList?[indexPath.row] {
                activityCell.render(ActivityDetaiViewModel(activity: activity))
            }
            return activityCell
        }
        var cell:UITableViewCell?
        switch tableRowInfo[indexPath.section][indexPath.row] {
        case .ShopInfo:
            let shopInfoCell = tableView.dequeueReusableCell(indexPath: indexPath) as ShopInfoTableViewCell
            shopInfoCell.render(self.shopViewModel)
            cell = shopInfoCell
        case .LocationInfo:
            let locationInfoCell = tableView.dequeueReusableCell(indexPath: indexPath) as LocationInfoTableViewCell
            locationInfoCell.render(self.shopViewModel)
            cell = locationInfoCell
        case .ContactInfo:
            let contactInfoCell = tableView.dequeueReusableCell(indexPath: indexPath) as ActivityTimeInfoTableViewCell
            contactInfoCell.render(self.shopViewModel)
            cell = contactInfoCell
        case .ShopDetailInfo:
            let detailCell = tableView.dequeueReusableCell(indexPath: indexPath) as ActivityDetailInfoTableViewCell
            detailCell.render(self.shopViewModel)
            cell = detailCell
        default:
            cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "ShopActivityInfo")
        }
        return cell!
    }
    
}
