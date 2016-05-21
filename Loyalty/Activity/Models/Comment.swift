//
//  Comment.swift
//  Loyalty
//
//  Created by WangKun on 16/5/21.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation


import UIKit
import AVOSCloud

class Comment: AVObject, AVSubclassing{
    @NSManaged var shopId:String
    @NSManaged var userId:String
    @NSManaged var content:String
    @NSManaged var replyName:String?
    @NSManaged var replyId:String?
    @NSManaged var rate:Int
    @NSManaged var userIcon:AVFile?
    @NSManaged var userNickname:String
    
    static func parseClassName() -> String! {
        return "Comment"
    }
}

extension Comment {
    static func publishComment(shop:Shop,rate:Int, replyId:String?, replyName: String?,content:String, completionHandler:(success:Bool,errorMsg:String?)->Void) {
        guard let user = UserInfoManager.sharedManager.currentUser else{
            completionHandler(success: false, errorMsg: "请先登录")
            return
        }
        let comment = Comment()
        comment.rate = rate
        comment.userId = user.username
        comment.userIcon = user.avatar
        comment.userNickname = user.nickName ?? ""
        comment.content = content
        comment.replyName = replyName
        comment.replyId = replyId
        comment.shopId = shop.objectId
        comment.saveInBackgroundWithBlock { (success, error) in
            if success {
                if rate != 0 {
                    shop.rate(rate, completionHandler: completionHandler)
                } else {
                    completionHandler(success: true, errorMsg: nil)
                }
            } else {
                completionHandler(success: false, errorMsg: NSError.errorMsg(error))
            }
        }
    }
    

    static func queryComment(shopId:String, completionHandler:(comment:[Comment]?) -> Void) {
        let query = Comment.query()
        query.whereKey("shopId", equalTo: shopId)
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if objects.count > 0 {
                var comments:[Comment] = []
                for i in 0...objects.count-1 {
                    if let comment = objects[i] as? Comment {
                        comments.append(comment)
                    }
                }
                completionHandler(comment: comments)
            }
        }
    }
}