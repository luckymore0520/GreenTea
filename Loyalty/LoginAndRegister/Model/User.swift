//
//  User.swift
//  Loyalty
//
//  Created by WangKun on 16/2/1.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

enum UserType:String {
    case Custume = "Custume"
    case Business = "Business"
}

enum Gender:String {
    case Male = "男"
    case Female = "女"
    case Unknown = "未知"
}


class User:AVUser {
    @NSManaged var avatar:AVFile?
    @NSManaged var shop:Shop?
    @NSManaged var userTypeString:String?
    @NSManaged var sex:String?
    @NSManaged var birthday:String?
    @NSManaged var currentCity:String?
    @NSManaged var nickName:String?
    var cards:[Card]?
    override static func parseClassName() -> String! {
        return "_User"
    }
    
    func addNewCard(card:Card){
        if cards == nil { cards = [] }
        cards?.append(card)
    }
    
    func hasOwnedCard(forActivity:Activity) -> Bool {
        guard let cards = self.cards else { return false}
        
        for card in cards {
            if card.activity.objectId == forActivity.objectId {
                return true
            }
        }
        return false
    }
    
    func gender()->Gender {
        return Gender(rawValue: self.sex ?? "未知") ?? .Unknown
    }

    
    func userType()->UserType {
        return UserType(rawValue:self.userTypeString ?? "Custume") ?? .Custume 
    }
}

extension User {
    static func currentMyUser()->User {
        let user = User.currentUser()
        if let shop = user.shop {
            if !shop.isKindOfClass(Shop.classForCoder()) {
                let query = Shop.query()
                query.includeKey("activitys")
                query.getObjectInBackgroundWithId(shop.objectId, block: { (shop, error) in
                    user.shop = shop as? Shop
                })
            }
        }
        if user.cards == nil {
            Card.queryCardsOfUser(user.username, completionHandler: { (cards) in
                user.cards = cards
            })
        }
        return user
    }
    
    func saveInBackgroundAndChange(completion:AVBooleanResultBlock? = nil) {
        self.saveInBackgroundWithBlock { (success, error) in
            User.changeCurrentUser(self, save: true)
            completion?(success,error)
        }
    }
}