//
//  Activity.swift
//  Loyalty
//
//  Created by WangKun on 16/1/27.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation


enum ActivityType:String{
    case Promotion = "优惠促销";
    case Loyalty = "集点卡";

}


struct Shop {
    var shopName:String
}

struct Activity {
    var activityType:ActivityType!
    var imageName:String!
    var shop:Shop!
    var likeCount:Int!
    var startTime:NSTimeInterval!
    var endTime:NSTimeInterval!
    var activityDescription:String!
}
