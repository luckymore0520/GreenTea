//
//  MoneyCollectionViewCell.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class MoneyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coinSequenceLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.coinSequenceLabel.layer.cornerRadius = coinSequenceLabel.frame.width / 2.0
        self.coinSequenceLabel.layer.borderWidth = 3.0
    }
    
    

    func updateLabelState(sequence:Int, isCollected:Bool = false) {
        self.coinSequenceLabel.selected = isCollected
        self.coinSequenceLabel.setTitle("\(sequence)", forState: UIControlState.Normal)
        self.coinSequenceLabel.layer.borderColor = self.coinSequenceLabel.selected ? UIColor.globalGreenColor().CGColor : UIColor.globalGrayColor().CGColor
    }
}
