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

let kAvatarKey = "Avatar"
let kUserTypeKey = "userType"

extension AVUser {
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