//
//  UserInfoManager.swift
//  Loyalty
//
//  Created by WangKun on 16/1/28.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

let kLimitVerifySeconds = 60

class UserInfoManager {
    private static let sharedInstance = UserInfoManager()
    var savedPhoneNumber:String?
    var verifyRemainTime:Int = kLimitVerifySeconds
    var user:User?
    class var sharedManager : UserInfoManager {
        return sharedInstance
    }
        
    var currentUser:User? {
        if self.isLogin {
            if self.user == nil {
                user = User.currentMyUser()
            }
            return user
        }
        return nil
    }
    
    var isLogin:Bool {
        if let user = User.currentUser() {
            return user.isAuthenticated()
        } else {
            return false
        }
    }
    
    func login(phone:String,password:String,completionHandler: (result:Bool, errorMsg:String?) -> Void ) {
        User.logInWithUsernameInBackground(phone, password: password) { (user, error) -> Void in
            completionHandler(result: user != nil , errorMsg: NSError.errorMsg(error))
            if user != nil {
                User.changeCurrentUser(user, save: true)
            }
        }
    }
    
    func logout(){
        User.logOut()
    }
        
    func register(phone:String,password:String,code:String,completionHandler: (result:Bool, errorMsg:String?) -> Void ) {
        self.verifySMSCode(phone, code: code) { (result, errorMsg) -> Void in
            if result {
                let user = User.init()
                user.username = phone
                user.password = password
                 user.userTypeString = "Custume"
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    completionHandler(result: success, errorMsg: error == nil ? "" : error.localizedDescription)
                })
            } else {
                completionHandler(result: result, errorMsg:errorMsg)
            }
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

// MARK: - Code Timer
extension UserInfoManager {
    func countDown()->Int {
        self.verifyRemainTime -= 1
        if (self.verifyRemainTime <= 0) {
            self.verifyRemainTime = kLimitVerifySeconds
            return 0
        }
        return self.verifyRemainTime
    }
    
    func shouldContinueCountDown()->Bool {
        return self.verifyRemainTime != kLimitVerifySeconds
    }
}