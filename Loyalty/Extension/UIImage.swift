//
//  UIImage.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    /**
     生成一张纯色图片
     
     - parameter color: 图片颜色
     - parameter size:  图片尺寸
     
     - returns: 对应图片
     */
    static func imageWithColor(color:UIColor, size:CGSize) -> UIImage! {
        let rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}