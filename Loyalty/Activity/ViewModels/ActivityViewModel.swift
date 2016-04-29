//
//  ActivityViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias ActivityPresentable = protocol<TitlePresentable,WebIconPresentable,DetailPresentable,TagPresentable,LocationPresentable,SubTitlePresentable>

struct ActivityViewModel:ActivityPresentable {
    var iconName: String
    var title: String
    var detail: String
    var tagName: String
    var location: String
    var subTitle: String
    var shop:Shop?
    init(activity:Activity){
        self.iconName = activity.avatar.url
        self.title = activity.name
        self.detail = activity.activityDescription ?? ""
        self.tagName = activity.activityType == ActivityType.Loyalty ? "集点卡" : "优惠信息"
        self.location = activity.locationName
        self.shop = activity.shopInfo
        self.subTitle = "\(activity.startTime.formateToString("yyyy.mm.dd"))-\(activity.endTime.formateToString("yyyy.mm.dd"))"
    }
}