//
//  LeanCloudHelper.swift
//  Loyalty
//
//  Created by WangKun on 16/1/25.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

//https://leancloud.cn/data.html?appid=CzsgRqgwFvkH4YMcFW8xnwr7-gzGzoHsz#/
let appId = "CzsgRqgwFvkH4YMcFW8xnwr7-gzGzoHsz"
let appKey = "N0xI0NlMuzjYJWPhU4WCzrUH"


func configureLeanCloudWithOptions(launchOptions:[NSObject: AnyObject]?) {
    AVOSCloud.setAllLogsEnabled(true)
    AVOSCloud.setApplicationId(appId, clientKey: appKey)
    AVAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
}

