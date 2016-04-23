//
//  PointInfoTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class PointInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var isSelectedImageView: UIImageView!
    @IBOutlet weak var pointLocationLabel: UILabel!
    @IBOutlet weak var pointNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func render(presenter:PointPresentable) {
        presenter.updateTitleLabel(self.pointNameLabel)
        presenter.updateSubTitleLabel(self.pointLocationLabel)
        presenter.updateCheckView(self.isSelectedImageView)
    }
    
}
