//
//  UserInfoViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/23.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

typealias UserInfoPresentable = protocol<TitlePresentable,WebIconPresentable>


struct UserInfoViewModel:UserInfoPresentable {
    var title: String
    var iconName: String
    init(user: User?) {
        self.title = user?.nickName ?? ""
        self.iconName = user?.avatar?.url ?? ""
    }
}