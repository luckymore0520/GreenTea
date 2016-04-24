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
let kCityKey = "currentCity" //城市
let kNickname = "nickName"
extension AVUser {
    var nickname:String {
        get {
            return self.objectForKey(kNickname) as? String ?? "请设置昵称"
        }
        set {
            self.setObject(newValue, forKey: kNickname)
        }
    }
    
    var city:String? {
        get {
            return self.objectForKey(kCityKey) as? String
        }
        set {
            self.setObject(newValue, forKey: kCityKey)
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

extension AVUser {
    func saveInBackgroundAndChange(completion:AVBooleanResultBlock? = nil) {
        self.saveInBackgroundWithBlock { (success, error) in
            if success {
                AVUser.changeCurrentUser(self, save: true)
            }
            completion?(success,error)
        }
    }
}