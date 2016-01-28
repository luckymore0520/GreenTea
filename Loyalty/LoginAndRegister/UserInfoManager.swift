//
//  UserInfoManager.swift
//  Loyalty
//
//  Created by WangKun on 16/1/28.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

class UserInfoManager {
    private static let sharedInstance = UserInfoManager()
    class var sharedManager : UserInfoManager {
        return sharedInstance
    }
    
    func isLogin() -> Bool {
        return AVUser.currentUser() != nil
    }
    
    func login(phone:String,password:String,completionHandler: (result:Bool, errorMsg:String?) -> Void ) {
        AVUser.logInWithUsernameInBackground(phone, password: password) { (user, error) -> Void in
            completionHandler(result: user != nil , errorMsg: error.localizedDescription)
        }
    }
}