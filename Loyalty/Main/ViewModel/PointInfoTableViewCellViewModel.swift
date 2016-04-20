//
//  PointInfoTableViewCellViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias PointPresentable = protocol<TitlePresentable,SubTitlePresentable,Checkable>

struct PointInfoTableViewCellViewModel:PointPresentable {
    var isChecked: Bool
    var title: String
    var subTitle: String
    init(poi:AMapPOI?,isChecked:Bool = false) {
        self.title = poi?.name ?? ""
        self.subTitle = poi?.address ?? ""
        self.isChecked = isChecked
    }
}