//
//  Activity.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

enum ActivityType:String{
    case Promotion = "优惠促销";
    case Loyalty = "集点卡";
}

class Shop: AVObject, AVSubclassing {
    @NSManaged var shopName:String!
    @NSManaged var rate:NSNumber!
    @NSManaged var commentCount:NSNumber!
    @NSManaged var location:NSValue!
    @NSManaged var locationName:String!
    static func parseClassName() -> String! {
        return "Shop"
    }
}

class Activity: AVObject, AVSubclassing  {
    @NSManaged var activityTypeString:String?
    @NSManaged var imageName:String?
    @NSManaged var shop:Shop?
    @NSManaged var likeCount:Int32
    @NSManaged var startTime:NSTimeInterval
    @NSManaged var endTime:NSTimeInterval
    @NSManaged var activityDescription:String?
    
    var activityType:ActivityType? {
        get {
            guard let activityTypeString = self.activityTypeString else { return nil }
            return ActivityType(rawValue: activityTypeString)
        }
    }
    
    static func parseClassName() -> String! {
        return "Activity"
    }
}
