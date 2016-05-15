//
//  AMapTool.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import MapKit

let AMapAppKey = "98f69873dd6ddb4f950d50ec0bbb97c5"
class AMapTool {
    static func configureAMapKit(){
        MAMapServices.sharedServices().apiKey = AMapAppKey
        AMapSearchServices.sharedServices().apiKey = AMapAppKey
    }
    
    static func naviToPOI(name:String,latitute:Double,longitute:Double) {
        let urlString = "iosamap://viewMap?sourceApplication=绿茶&poiname=\(name)&lat=\(latitute)&lon=\(longitute)&dev=0".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        guard let url = NSURL(string: urlString!) else  { return }
        if UIApplication.sharedApplication().canOpenURL(NSURL(string:"iosamap://")!) {
            UIApplication.sharedApplication().openURL(url)
        } else {
            let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(latitute, longitute), addressDictionary: nil))
            toLocation.name = name
            MKMapItem .openMapsWithItems([toLocation], launchOptions: nil)
            
    
        }
    }
}