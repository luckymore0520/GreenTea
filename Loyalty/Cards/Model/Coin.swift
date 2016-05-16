//
//  Coin.swift
//  Loyalty
//
//  Created by WangKun on 16/5/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

class Coin: AVObject,AVSubclassing {
    @NSManaged var activity:Activity
    @NSManaged var coinCode:String
    
    static func parseClassName() -> String! {
        return "Coin"
    }
    
    static func requestNewCoin(activity:Activity, completionHandler:(code:String?,errorMsg:String?)->Void){
        let code = Int.random(1000, max: 9999)
        let coin = Coin()
        coin.activity = activity
        coin.coinCode = "\(code)"
        coin.saveInBackgroundWithBlock { (success, error) in
            completionHandler(code: success ? coin.coinCode : nil, errorMsg: NSError.errorMsg(error))
        }
    }
    
    static func checkCode(activity:Activity, code:String, completionHandler:(success:Bool)->Void) {
        let query = Coin.query()
        query.whereKey("activity", equalTo: activity)
        query.whereKey("coinCode", equalTo: code)
        query.findObjectsInBackgroundWithBlock { (code, error) in
            if code.count > 0 {
                code[0].delete()
                completionHandler(success: true)
            } else {
                completionHandler(success: false)
            }
        }
    }
}