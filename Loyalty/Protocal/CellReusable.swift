//
//  CellReusable.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol CellReusable {
    static func cellIdentifier()->String!
    static func nib() -> UINib!
}

extension UITableViewCell:CellReusable {}
extension UICollectionViewCell:CellReusable {}

extension CellReusable where Self:NSObject {
    static func cellIdentifier()->String! {
        let classString : String = NSStringFromClass(self.classForCoder())
        return classString.componentsSeparatedByString(".").last;
    }
    
    static func nib() -> UINib! {
        return UINib(nibName: self.cellIdentifier(), bundle: nil)
    }
}

