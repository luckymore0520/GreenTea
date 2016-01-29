//
//  UIButton.swift
//  Loyalty
//
//  Created by WangKun on 16/1/29.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setDisableStyle(color:UIColor = UIColor(hexString: "c5c5c5")!) {
        self.setBackgroundImage(UIImage.imageWithColor(color, size: self.frame.size), forState: UIControlState.Disabled)
    }
}