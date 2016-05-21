//
//  CommentCell.swift
//  Loyalty
//
//  Created by WangKun on 16/5/21.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var starRateview: StartRateView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var starRateViewHeightConstant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func render(commentPresentable:CommmentPresentable) {
        commentPresentable.updateImageView(self.iconImageView)
        commentPresentable.updateTitleLabel(self.nicknameLabel)
        commentPresentable.updateDetailLabel(self.contentLabel)
        commentPresentable.updateHiddableViews([starRateview])
        commentPresentable.updateViews(self.starRateview, starLabel: nil)
        self.starRateViewHeightConstant.constant = commentPresentable.shouldHidden ? 0 : 15
    }
}
