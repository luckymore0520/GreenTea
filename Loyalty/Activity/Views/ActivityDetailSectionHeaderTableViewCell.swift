//
//  ActivityDetailSectionHeaderTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityDetailSectionHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func render(presenter:TitlePresentable) {
        presenter.updateTitleLabel(self.sectionNameLabel)
    }

}
