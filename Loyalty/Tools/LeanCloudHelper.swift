//
//  LeanCloudHelper.swift
//  Loyalty
//
//  Created by WangKun on 16/1/25.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

let appId = "CzsgRqgwFvkH4YMcFW8xnwr7-gzGzoHsz"
let appKey = "N0xI0NlMuzjYJWPhU4WCzrUH"

class LeanCloudHelper {
    static func configureLeanCloudWithOptions(launchOptions:[NSObject: AnyObject]?) {
        AVOSCloud.setAllLogsEnabled(true)
        AVOSCloud.setApplicationId(appId, clientKey: appKey)
        AVAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        LeanCloudHelper.registerSubClass()
    }
    
    static func registerSubClass(){
        Card.registerSubclass()
        Like.registerSubclass()
        User.registerSubclass()
        Shop.registerSubclass()
        Activity.registerSubclass()
    }
    
    static func uploadImage(image:UIImage,completionHandler:(file:AVFile?,errorMsg:String?) -> Void){
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else { return }
        let file = AVFile(data: imageData)
        file.saveInBackgroundWithBlock { (succeed, error) in
            if succeed {
                log.info("文件上传成功,地址\(file.url)")
                completionHandler(file: file, errorMsg: nil)
            } else {
                completionHandler(file: nil, errorMsg: NSError.errorMsg(error))
            }
        }
    }
}



extension NSError {
    static func errorMsg(error:NSError?) -> String? {
        var errorMsg:String?
        if let error = error {
            errorMsg = error.userInfo["error"] as? String ?? "未知错误"
        }
        return errorMsg
    }
}