//
//  UILabel.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func getMinWidth() -> CGFloat {
        guard let text = self.text else { return 0 }
        let textNSString = NSString(string: text)
        let maximunLabelSize = CGSizeMake(CGFloat.max, self.frame.height)
        let expectedLabelSize = textNSString.boundingRectWithSize(maximunLabelSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil).size
        return expectedLabelSize.width
    }
    
    func getMinHeight() -> CGFloat {
        guard let text = self.text else { return 0 }
        let textNSString = NSString(string: text)
        let maximunLabelSize = CGSizeMake(self.frame.width,CGFloat.max)
        let expectedLabelSize = textNSString.boundingRectWithSize(maximunLabelSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil).size
        return expectedLabelSize.height
    }

}