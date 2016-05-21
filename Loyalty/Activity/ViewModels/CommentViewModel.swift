//
//  CommentViewModel.swift
//  Loyalty
//
//  Created by WangKun on 16/5/21.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

typealias CommmentPresentable = protocol<TitlePresentable,WebIconPresentable,HasHiddenComponent,StarPresentable,DetailPresentable>

struct CommentViewModel:CommmentPresentable {
    var iconName: String
    var title: String
    var detail: String
    var shouldHidden: Bool
    var starCount: Double
    init(comment:Comment) {
        self.iconName = comment.userIcon?.url ?? ""
        self.title = comment.userNickname
        if let replyName = comment.replyName {
            self.detail = "\(replyName.length > 0 ? "回复\(replyName):" : "") \(comment.content)"
        } else {
            self.detail = comment.content
        }
        self.shouldHidden = comment.rate == 0
        self.starCount = Double(comment.rate)
    }
}
