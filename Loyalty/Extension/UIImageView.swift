//
//  UIImageView.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher


extension UIImageView {
    func setImageWithUrlString(urlString:String?){
        guard let urlString = urlString else { return }
        guard let url = NSURL(string: urlString ) else { return }
        self.kf_setImageWithURL(url)
    }
}
