//
//  Card.swift
//  Loyalty
//
//  Created by WangKun on 16/4/29.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import AVOSCloud

class Card: AVObject,AVSubclassing {
    @NSManaged var activity:Activity
    @NSManaged var ownerId:String
    @NSManaged var currentCount:Int
    
    func getFullInfo(){
        let query = Activity.query()
        query.getObjectInBackgroundWithId(self.activity.objectId) { (activity, error) in
            if let activity = activity as? Activity {
                self.activity = activity
            }
        }
    }
    
    var isFull:Bool {
        return activity.loyaltyCoinMaxCount == self.currentCount
    }
    
    static func parseClassName() -> String! {
        return "Card"
    }
}


extension Card {
    func collect(code:String, completionHandler:(success:Bool)->Void) {
        if self.currentCount == self.activity.loyaltyCoinMaxCount {
            completionHandler(success: false)
        } else {
            Coin.checkCode(self.activity, code: code, completionHandler: { (success) in
                if success {
                    self.currentCount += 1
                    self.saveInBackgroundWithBlock({ (success, error) in
                        completionHandler(success: success)
                    })
                } else {
                    completionHandler(success: false)
                }
            })
            
        }
    }
    
    static func queryCardWithId(objectId:String, completionHandler:Card?->Void) {
        let query = Card.query()
        query.includeKey("activity")
        query.getObjectInBackgroundWithId(objectId) { (card, error) in
            if let card = card as? Card {
                completionHandler(card)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    static func queryCardsOfUser(userName:String,completionHandler:[Card]->Void) {
        let query = Card.query()
        query.whereKey("ownerId", equalTo: userName)
        query.includeKey("activity")
        query.findObjectsInBackgroundWithBlock { (cards, error) in
            if cards.count > 0 {
                let cardList = cards as! [Card]
                completionHandler(cardList)
            }
        }
    }
    
    static func obtainNewCard(activity:Activity, completionHandler:(card:Card?,errorMsg:String?) -> Void) {
        guard let user = UserInfoManager.sharedManager.currentUser else {
            completionHandler(card: nil, errorMsg: "登录后才能领取集点卡")
            return
        }
        let card = Card()
        card.activity = activity
        card.ownerId = user.username
        card.currentCount = 0
        card.saveInBackgroundWithBlock { (success, error) in
            if success {
                user.addNewCard(card)
                completionHandler(card: card,errorMsg: nil)
            } else {
                completionHandler(card: nil, errorMsg: NSError.errorMsg(error))
            }
        }
    }

}