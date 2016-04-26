//
//  StarPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

protocol StarPresentable {
    var starCount:CGFloat { get }
    func updateViews(starView:StartRateView, starLabel:UILabel)
}

extension StarPresentable {
    func updateViews(starView:StartRateView, starLabel:UILabel) {
        starView.percentOfStar = self.starCount / (CGFloat(starView.numberOfStars))
        starLabel.text = String(format: "%.2f", self.starCount)
    }
}