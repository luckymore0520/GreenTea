//
//  Log.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger.defaultInstance()
    let logPath : NSURL = cacheDirectory.URLByAppendingPathComponent("XCGLogger.Log")
    log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: false, writeToFile: logPath, fileLogLevel: .Info)
    log.xcodeColorsEnabled = true
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: .red,
        .Severe: .whiteOnRed
    ]
    return log
}()

var documentsDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1]
}

var cacheDirectory: NSURL {
    let urls = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
    return urls[urls.endIndex-1]
}