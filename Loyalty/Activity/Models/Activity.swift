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
    
    // AVSubClassing协议方法，返回对应的表名
    static func parseClassName() -> String! {
        return "Shop"
    }
    
    func isMine()->Bool {
        return self.userId == UserInfoManager.sharedManager.currentUser?.username
    }
}

extension Shop {
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
    @NSManaged var startTime:NSDate
    @NSManaged var endTime:NSDate
    @NSManaged var activityDescription:String
    
    var shopInfo:Shop?
    var like:Like?
    var isLikedByMySelf:Bool?
    convenience init(shop:Shop,name:String,startTime:NSDate,endTime:NSDate,description:String,avatar:AVFile,activityType:String,loyaltyCoinMaxCount:Int) {
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
    
    var isMine:Bool {
        return self.creatorId == UserInfoManager.sharedManager.currentUser?.username
    }
    
    static func parseClassName() -> String! {
        return "Activity"
    }
}

extension Activity {
    func queryIsLikedBySelf(completionHandler:(like:Like?)->Void){
        if self.isLikedByMySelf != nil {
            completionHandler(like: self.like)
            return
        }
        guard let userId = UserInfoManager.sharedManager.currentUser?.objectId else { return }
        let query = Like.query()
        query.whereKey("userId", equalTo: userId)
        query.whereKey("activityId", equalTo: self.objectId)
        query.getFirstObjectInBackgroundWithBlock { (object, error) in
            self.like = object as? Like
            self.isLikedByMySelf = (self.like != nil)
            completionHandler(like: self.like)
        }
    }
    
    func queryShopInfo(completion:Shop->Void) {
        //获取shop的查询对象
        let query = Shop.query()
        //根据shopId查询shop
        query.getObjectInBackgroundWithId(self.shopId) { (shop, error) in
            if let shop = shop as? Shop {
                //回调
                self.shopInfo = shop
                completion(shop)
            }
        }
    }
    
    static func query(nearGeoPoint:CGPoint?, type:ActivityType, completion:[Activity] -> Void) {
        let query = Activity.query()
        query.limit = 10
        if let nearGeoPoint = nearGeoPoint {
            query.whereKey("location", nearGeoPoint: AVGeoPoint(latitude: Double(nearGeoPoint.x), longitude: Double(nearGeoPoint.y)))
        }
        query.whereKey("activityTypeString", equalTo: type.rawValue)
        query.findObjectsInBackgroundWithBlock { (activityObject, error) in
            var activityArray:[Activity] = []
            for object in activityObject {
                if let activity = object as? Activity {
                    activityArray.append(activity)
                }
            }
            completion(activityArray)
        }
    }
}
