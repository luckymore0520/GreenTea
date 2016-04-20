//
//  UserSettingCellViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/2/1.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias SettingCellPresentable = protocol<TitlePresentable,IconPresentable>

struct UserSettingCellViewModel:SettingCellPresentable {
    var title:String
    var iconName:String
    init(type:SettingCellType) {
        self.title = type.rawValue
        self.iconName = type.rawValue
    }
}