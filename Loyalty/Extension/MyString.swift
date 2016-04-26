//
//  String.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

extension String {
    func minHeight(maxWidth:CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: maxWidth, height: CGFloat.max)
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
        return boundingBox.height
    }
}