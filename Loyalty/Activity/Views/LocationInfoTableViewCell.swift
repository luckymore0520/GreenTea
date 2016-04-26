//
//  LocationInfoTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/10.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class LocationInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func render(location:LocationPresentable?){
        location?.updateLocationLabel(self.locationLabel)
    }

}
