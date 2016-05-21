//
//  ShopInfoTableViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ShopInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var starRateView: StartRateView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func render(shop:ShopPresentable?) {
        guard let shop = shop else { return }
        shop.updateTitleLabel(self.shopNameLabel)
        shop.updateViews(self.starRateView, starLabel: self.startLabel)
        shop.updateCountLabel(reviewCountLabel)
        shop.updateHiddableViews([self.reviewCountLabel])
    }
}
