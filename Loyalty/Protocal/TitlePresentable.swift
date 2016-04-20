//
//  TitlePresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/2/1.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol TitlePresentable {
    var title: String { get }
    var titleColor: UIColor { get }
    func updateTitleLabel(label:UILabel)
}

extension TitlePresentable {
    var titleColor: UIColor {
        return UIColor.globalTitleBrownColor()
    }
    
    func updateTitleLabel(label:UILabel) {
        label.text = self.title
        label.textColor = self.titleColor
    }
}