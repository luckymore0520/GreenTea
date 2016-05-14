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
    
    func reloadData() {
        guard let myCards = UserInfoManager.sharedManager.currentUser?.cards else { return }
        cardList = myCards
    }
    
    func moveToCardActivity(activityId:String) -> Bool {
        if cardList.count == 0 { return false}
        var targetIndex = 0
        for i in 0...cardList.count-1 {
            let card = cardList[i]
            if card.activity.loyaltyCoinMaxCount > card.currentCount && card.activity.objectId == activityId {
                targetIndex = i
                break
            }
        }
        if targetIndex > 0 {
            let card = cardList[targetIndex]
            cardList.removeAtIndex(targetIndex)
            var newCardList = [card]
            newCardList += self.cardList
            self.cardList = newCardList
        }
        return true
    }
    
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let cardView = NSBundle.mainBundle().loadNibNamed("CardView", owner: nil, options: nil)[0] as! CardView
        cardView.renderView()
        return cardView
    }
    
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return UInt(cardList.count)
    }
}

