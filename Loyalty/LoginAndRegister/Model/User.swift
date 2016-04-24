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

    override static func parseClassName() -> String! {
        return "_User"
    }
    
    func gender()->Gender {
        return Gender(rawValue: self.sex ?? "未知") ?? .Unknown
    }

    
    func userType()->UserType {
        return UserType(rawValue:self.userTypeString ?? "Custume") ?? .Custume 
    }
}

extension User {
    func saveInBackgroundAndChange(completion:AVBooleanResultBlock? = nil) {
        self.fetchWhenSave = true
        self.saveInBackgroundWithBlock { (success, error) in
            User.changeCurrentUser(self, save: true)
            completion?(success,error)
        }
    }
}