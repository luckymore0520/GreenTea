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


let kAvatarKey = "myAvatar" //头像
let kUserTypeKey = "userType" //用户类型
let kGenderKey = "sex" //性别
let kBirthdayKey = "birthday" //生日
let kcityKey = "currentCity" //城市

extension AVUser {
    var city:String? {
        get {
            return self.objectForKey(kcityKey) as? String
        }
        set {
            self.setObject(newValue, forKey: kcityKey)
        }
    }
    
    
    var gender:Gender? {
        get {
            return Gender(rawValue: self.objectForKey(kGenderKey) as? String ?? "未知")
        }
        set {
            self.setObject(newValue?.rawValue, forKey: kGenderKey)
        }
    }

    
    
    var myBirthday:String? {
        get {
            return self.objectForKey(kBirthdayKey) as? String
        }
        set {
            self.setObject(newValue, forKey: kBirthdayKey)
        }
    }
    
    var avatar:AVFile? {
        
        get {
            return self.objectForKey(kAvatarKey) as? AVFile
        }
        set {
            self.setObject(newValue, forKey: kAvatarKey)
        }
    }
    
    var userType:UserType {
        get {
            return UserType(rawValue:self.objectForKey(kUserTypeKey) as! String) ?? .Custume
        }
        set {
            self.setObject(newValue.rawValue, forKey: kUserTypeKey)
        }
    }
}