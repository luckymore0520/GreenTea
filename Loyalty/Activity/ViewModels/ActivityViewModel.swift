//
//  ActivityViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias ActivityDetailPresentable = protocol<TitlePresentable,WebIconPresentable,DetailPresentable,TagPresentable,LocationPresentable,SubTitlePresentable>
typealias ActivitySimplePresentable = protocol<TitlePresentable,WebIconPresentable,Checkable,LocationPresentable,SubTitlePresentable>

struct ActivitySimpleViewModel:ActivitySimplePresentable {
    var iconName: String
    var title: String
    var location: String
    var subTitle: String
    var isChecked: Bool?
    init(activity:Activity){
        self.iconName = activity.avatar.url
        self.title = activity.name
        self.location = activity.locationName
        self.subTitle = "\(activity.likeCount)"
        self.isChecked = activity.isLikedByMySelf
    }

}

struct ActivityDetaiViewModel:ActivityDetailPresentable {
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
        self.subTitle = "\(activity.startTime.formateToString("yyyy.MM.dd"))-\(activity.endTime.formateToString("yyyy.MM.dd"))"
    }
}