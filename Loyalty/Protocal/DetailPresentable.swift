//
//  DetailPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol DetailPresentable {
    var detail:String { get }
    func updateDetailLabel(label:UILabel)
}

extension DetailPresentable {
    func updateDetailLabel(label:UILabel) {
        label.text = self.detail
    }
}

