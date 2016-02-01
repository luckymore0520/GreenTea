//
//  IconPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/2/1.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol IconPresentable {
    var iconName: String { get }
    func updateImageView(imageView: UIImageView)
}

extension IconPresentable {
    func updateImageView(imageView: UIImageView) {
        imageView.image = UIImage(named: self.iconName)
    }
}