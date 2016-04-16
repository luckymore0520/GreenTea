//
//  UserDefaultTool.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Foundation

let cityKey = "CITY_KEY"

class UserDefaultTool {
    
    static func stringForKey(key:String) -> String? {
        let value = UserDefaultTool.valueForKey(key) as? String
        return value
    }
    
    static private func valueForKey(key:String) -> AnyObject? {
        let defaultUserDefault = NSUserDefaults.standardUserDefaults()
        return defaultUserDefault.valueForKey(key)
    }
    
    static func saveValueForKey(key:String,value:AnyObject) {
        let defaultUserDefault = NSUserDefaults.standardUserDefaults()
        defaultUserDefault.setValue(value, forKey: key)
        defaultUserDefault.synchronize()
    }
}
