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
    @NSManaged var shopName:String
    @NSManaged var rate:NSNumber
    @NSManaged var commentCount:NSNumber
    @NSManaged var location:AVGeoPoint
    @NSManaged var locationName:String
    @NSManaged var phoneNumber:String
    @NSManaged var shopDescription:String
    @NSManaged var avatar:AVFile
    @NSManaged var userId:String?

    
    convenience init(shopName:String,location:CGPoint,locationName:String,phoneNumber:String,description:String,avatar:AVFile){
        self.init()
        self.rate = 0
        self.commentCount = 0
        self.shopName = shopName
        self.locationName = locationName
        self.location = AVGeoPoint(latitude: Double(location.x), longitude: Double(location.y))
        self.phoneNumber = phoneNumber
        self.avatar = avatar
        self.shopDescription = description
        if let user = UserInfoManager.sharedManager.currentUser {
            self.userId = user.username
        }
    }
    
    static func parseClassName() -> String! {
        return "Shop"
    }
    
    func isMine()->Bool {
        return self.userId == UserInfoManager.sharedManager.currentUser?.username
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
