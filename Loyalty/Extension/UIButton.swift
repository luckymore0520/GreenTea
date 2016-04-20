//
//  UIButton.swift
//  Loyalty
//
//  Created by WangKun on 16/1/29.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIButton {
    func setDisableStyle(color:UIColor = UIColor(hexString: "c5c5c5")!) {
        self.setBackgroundImage(UIImage.imageWithColor(color, size: self.frame.size), forState: UIControlState.Disabled)
    }
    
    func setImageWithUrlString(urlString:String?) {
        guard let urlString = urlString else { return }
        guard let url = NSURL(string: urlString ) else { return }
        self.kf_setImageWithURL(url, forState: UIControlState.Normal)
    }
}