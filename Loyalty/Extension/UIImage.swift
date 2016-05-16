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
    
    static func createQRForString(qrString: String?) -> UIImage?{
        if let sureQRString = qrString {
            let stringData = sureQRString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            // 创建一个二维码的滤镜
            guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
            qrFilter.setValue(stringData, forKey: "inputMessage")
            qrFilter.setValue("H", forKey: "inputCorrectionLevel")
            let qrCIImage = qrFilter.outputImage
            // 创建一个颜色滤镜,黑白色
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            colorFilter.setDefaults()
            colorFilter.setValue(qrCIImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            // 返回二维码image
            let codeImage = UIImage(CIImage: colorFilter.outputImage!.imageByApplyingTransform(CGAffineTransformMakeScale(5, 5)))
            return codeImage
        }
        return nil
    }
}