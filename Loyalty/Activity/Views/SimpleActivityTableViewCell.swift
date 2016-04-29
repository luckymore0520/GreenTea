//
//  SimpleActivityTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class SimpleActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var activityDetailLabel: UILabel!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var activityIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func render(activityPresentable:ActivityDetailPresentable) {
        activityPresentable.updateLabel(self.activityTypeLabel)
        activityPresentable.updateImageView(self.activityIconImageView)
        activityPresentable.updateDetailLabel(self.activityDetailLabel)
        activityPresentable.updateTitleLabel(self.activityTitleLabel)
    }
    
}
