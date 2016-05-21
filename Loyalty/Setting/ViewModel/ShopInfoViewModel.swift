//
//  ShopInfoViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/24.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias ShopPresentable = protocol<TitlePresentable,WebIconPresentable,StarPresentable,HasHiddenComponent,SubTitlePresentable,LocationPresentable,DetailPresentable,CountPresentable>

struct ShopInfoViewModel:ShopPresentable {
    var title: String
    var iconName: String
    var starCount: Double
    var shouldHidden: Bool
    var subTitle: String
    var location:String
    var detail: String
    var count: Int
    
    var comments:[Comment] = []
    var activityList:[Activity]?
    
    init(shop:Shop) {
        self.count = shop.commentCount
        self.title = shop.shopName
        self.iconName = shop.avatar.url
        self.starCount = shop.rate
        self.shouldHidden = shop.isMine()
        self.subTitle = shop.phoneNumber
        self.location = shop.locationName
        self.detail = shop.shopDescription
        self.activityList = shop.activitys
        self.comments = shop.comments
    }
}