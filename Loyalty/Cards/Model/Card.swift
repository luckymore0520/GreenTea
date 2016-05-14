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
    
    static func parseClassName() -> String! {
        return "Card"
    }
    
    static func obtainNewCard(activity:Activity, completionHandler:(card:Card?,errorMsg:String?) -> Void) {
        guard let user = UserInfoManager.sharedManager.currentUser else {
            completionHandler(card: nil, errorMsg: "登录后才能领取集点卡")
            return
        }
        let card = Card()
        card.activity = activity
        card.ownerId = user.objectId
        card.currentCount = 0
        card.saveInBackgroundWithBlock { (success, error) in
            if success {
                completionHandler(card: card,errorMsg: nil)
            } else {
                completionHandler(card: nil, errorMsg: NSError.errorMsg(error))
            }
        }
    }
}
