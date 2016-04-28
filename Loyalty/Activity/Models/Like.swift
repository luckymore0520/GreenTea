//
//  Like.swift
//  Loyalty
//
//  Created by WangKun on 16/4/28.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import AVOSCloud

class Like: AVObject, AVSubclassing{
    @NSManaged var activityId:String
    @NSManaged var userId:String
    static func parseClassName() -> String! {
        return "Like"
    }
    
    static func like(activity:Activity, completionHandler:(like:Like?) -> Void)  {
        let like = Like()
        like.activityId = activity.objectId
        guard let userId = UserInfoManager.sharedManager.currentUser?.objectId else { return}
        like.userId = userId
        like.saveInBackgroundWithBlock { (success, error) in
            completionHandler(like: success ? like : nil)
        }
    }
  }
