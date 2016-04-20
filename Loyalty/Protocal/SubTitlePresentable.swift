//
//  SubTitlePresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

protocol SubTitlePresentable {
    var subTitle: String { get }
    var subTitleColor: UIColor { get }
    func updateSubTitleLabel(label:UILabel)
}

extension SubTitlePresentable {
    var subTitleColor: UIColor {
        return UIColor.globalGrayColor()
    }
    
    func updateSubTitleLabel(label:UILabel) {
        label.text = self.subTitle
        label.textColor = self.subTitleColor
    }
}