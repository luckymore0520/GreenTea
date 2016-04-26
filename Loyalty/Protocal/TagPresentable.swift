//
//  TagPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol TagPresentable {
    var tagName:String { get }
    var tagColor:UIColor { get }
    var tagLabelColor:UIColor { get }
    func updateLabel(label:UILabel)
}

extension TagPresentable {
    var tagColor:UIColor {
        return UIColor.globalGreenColor()
    }
    
    var tagLabelColor:UIColor {
        return UIColor.whiteColor()
    }
    
    func updateLabel(label:UILabel) {
        label.backgroundColor = self.tagColor
        label.textColor = self.tagLabelColor
        label.text = self.tagName
    }
}