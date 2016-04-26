//
//  ActivityTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    static let rowHeight = UIScreen.mainScreen().bounds.size.width * 8.0 / 15.0 + 60
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(activityPresentable:ActivityPresentable) {
        activityPresentable.updateImageView(activityImageView)
        activityPresentable.updateTitleLabel(nameLabel)
        activityPresentable.updateLocationLabel(locationLabel)
    }
    
}
