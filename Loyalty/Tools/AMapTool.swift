//
//  AMapTool.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation


let AMapAppKey = "98f69873dd6ddb4f950d50ec0bbb97c5"
class AMapTool {
    static func configureAMapKit(){
        MAMapServices.sharedServices().apiKey = AMapAppKey
        AMapSearchServices.sharedServices().apiKey = AMapAppKey
    }
}