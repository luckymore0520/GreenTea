//
//  ShopInfoViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/24.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias ShopPresentable = protocol<TitlePresentable,WebIconPresentable,StarPresentable,HasHiddenComponent,SubTitlePresentable,LocationPresentable,DetailPresentable>

struct ShopInfoViewModel:ShopPresentable {
    var title: String
    var iconName: String
    var starCount: CGFloat
    var shouldHidden: Bool
    var subTitle: String
    var location:String
    var detail: String
    init(shop:Shop) {
        self.title = shop.shopName
        self.iconName = shop.avatar.url
        self.starCount = CGFloat(shop.rate.floatValue)
        self.shouldHidden = shop.isMine()
        self.subTitle = shop.phoneNumber
        self.location = shop.locationName
        self.detail = shop.shopDescription
    }
}