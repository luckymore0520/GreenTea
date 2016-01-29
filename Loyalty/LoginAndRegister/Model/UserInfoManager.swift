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
    
    func requestSMSCode(phone:String, completionHandler: (result:Bool, errorMsg:String?) -> Void) {
        AVOSCloud.requestSmsCodeWithPhoneNumber(phone, appName: "绿茶", operation: "注册", timeToLive: 10) { (success, error) -> Void in
            completionHandler(result: success, errorMsg: error == nil ? "" : error.localizedDescription)
        }
    }
    
    func verifySMSCode(phone:String, code:String, completionHandler: (result:Bool, errorMsg:String?) -> Void) {
        AVOSCloud.verifySmsCode(code, mobilePhoneNumber: phone) { (success, error) -> Void in
            completionHandler(result: success, errorMsg: error == nil ? "" : error.localizedDescription)
        }
    }
}