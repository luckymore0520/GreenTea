//
//  ShopInfoViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/24.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias ShopPresentable = protocol<TitlePresentable,WebIconPresentable>

struct ShopInfoViewModel:ShopPresentable {
    var title: String
    var iconName: String
    init(shop:Shop) {
        self.title = shop.shopName
        self.iconName = shop.avatar.url
    }
}