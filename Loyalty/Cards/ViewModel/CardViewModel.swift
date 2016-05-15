//
//  CardViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/29.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias CardPresentable = protocol<TitlePresentable,WebIconPresentable,DetailPresentable,LocationPresentable,RatioPresentable>

struct CardViewModel:CardPresentable {
    var iconName: String
    var title: String
    var location: String
    var detail: String
    var currentCount: Int
    var totolCount: Int
    init(card:Card){
        self.iconName = card.activity.avatar.url
        self.title = card.activity.name
        self.location = card.activity.locationName
        self.detail = card.activity.activityDescription
        self.currentCount = card.currentCount
        self.totolCount = card.activity.loyaltyCoinMaxCount
    }
}