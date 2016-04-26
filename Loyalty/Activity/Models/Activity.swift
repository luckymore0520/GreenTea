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
    @NSManaged var activitys:[Activity]?
    
    
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
    
    func addNewActivity(activity:Activity) {
        if self.activitys == nil {
            self.activitys = []
        }
        self.activitys?.append(activity)
        self.saveInBackground()
    }
}

class Activity: AVObject, AVSubclassing  {
    @NSManaged var activityTypeString:String?
    @NSManaged var avatar:AVFile
    @NSManaged var location:AVGeoPoint
    @NSManaged var locationName:String
    @NSManaged var shopId:String
    @NSManaged var creatorId:String
    @NSManaged var loyaltyCoinMaxCount:Int
    @NSManaged var likeCount:Int
    @NSManaged var name:String
    @NSManaged var startTime:String
    @NSManaged var endTime:String
    @NSManaged var activityDescription:String?
    
    
    convenience init(shop:Shop,name:String,startTime:String,endTime:String,description:String,avatar:AVFile,activityType:String,loyaltyCoinMaxCount:Int) {
        self.init()
        self.activityTypeString = activityType
        self.shopId = shop.objectId
        self.creatorId = shop.userId ?? ""
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.loyaltyCoinMaxCount = loyaltyCoinMaxCount
        self.activityDescription = description
        self.avatar = avatar
        self.location = shop.location
        self.locationName = shop.locationName
    }
    
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
