//
//  WebIconPresentable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/23.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol WebIconPresentable {
    var iconName: String { get }
    func updateImageView(imageView: UIImageView)
}

extension WebIconPresentable {
    func updateImageView(imageView: UIImageView) {
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.setImageWithUrlString(iconName)
    }
}