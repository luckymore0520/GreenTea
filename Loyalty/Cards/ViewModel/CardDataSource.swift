//
//  CardDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Koloda

class CardDataSource: KolodaViewDataSource {
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let cardView = NSBundle.mainBundle().loadNibNamed("CardView", owner: nil, options: nil)[0] as! CardView
        
        return cardView
    }
    
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return 20
    }
}

