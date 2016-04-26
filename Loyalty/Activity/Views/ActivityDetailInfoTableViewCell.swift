//
//  AvtivityDetailInfoTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityDetailInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func render(detailPresentable:DetailPresentable?) {
        detailPresentable?.updateDetailLabel(detailLabel)
    }
}
