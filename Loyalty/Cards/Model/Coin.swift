//
//  Coin.swift
//  Loyalty
//
//  Created by WangKun on 16/5/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import AVOSCloud

class Coin: AVObject,AVSubclassing {
    @NSManaged var card:Card
    @NSManaged var code:String
    
    static func parseClassName() -> String! {
        return "Coin"
    }
    
    static func requestNewCoin(){
        
    }
}