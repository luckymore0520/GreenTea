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
    var cardList:[Card] = []
    
    init(){
        guard let myCards = UserInfoManager.sharedManager.currentUser?.cards else { return }
        cardList = myCards
    }
    
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let cardView = NSBundle.mainBundle().loadNibNamed("CardView", owner: nil, options: nil)[0] as! CardView
        let card = cardList[Int(index)]
        
        cardView.renderView()
        return cardView
    }
    
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return UInt(cardList.count)
    }
}

