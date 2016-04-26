//
//  LocationPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol LocationPresentable {
    var location:String { get }
    func updateLocationLabel(label:UILabel)
}

extension LocationPresentable {
    func updateLocationLabel(label:UILabel) {
        label.text = self.location
    }
}