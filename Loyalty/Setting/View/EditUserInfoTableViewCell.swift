//
//  EditUserInfoTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

enum EditUserInfoCellType:String {
    case Avatar = "头像"
    case Nickname = "昵称"
    case Gender = "性别"
    case City = "常居地"
    case Birthday = "生日"
    case Phone = "手机"
}

class EditUserInfoTableViewCell: UITableViewCell {
    @IBInspectable var cellTypeString:String = "" {
        didSet {
            self.cellType = EditUserInfoCellType(rawValue: cellTypeString)
        }
    }
    var cellType:EditUserInfoCellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
