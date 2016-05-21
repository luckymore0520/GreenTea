//
//  CountPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/5/21.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

protocol CountPresentable {
    var count:Int { get }
    var suffixString:String { get }
    func updateCountLabel(label:UILabel)
}

extension CountPresentable {
    var suffixString:String {
        get {
            return "条评论"
        }
    }

    func updateCountLabel(label:UILabel) {
        label.text = "\(self.count)\(self.suffixString)"
    }
}