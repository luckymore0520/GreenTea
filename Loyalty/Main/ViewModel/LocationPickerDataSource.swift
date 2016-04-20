//
//  LocationPickerDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Foundation

class LocationPickerDataSource: NSObject,UITableViewDataSource {
    var mapSearch:AMapSearchAPI?
    weak var tableView:UITableView?
    var searchResultArray = []
    init(tableView:UITableView,coordinate:CLLocationCoordinate2D) {
        super.init()
        mapSearch = AMapSearchAPI()
        mapSearch?.delegate = self
        self.tableView = tableView
        tableView.dataSource = self
        tableView.registerReusableCell(PointInfoTableViewCell.self)
        self.searchAroundLocation(coordinate)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PointInfoTableViewCell
        let poi = self.searchResultArray[indexPath.row] as? AMapPOI
        let pointViewModel = PointInfoTableViewCellViewModel(poi: poi, isChecked: indexPath.row == 0)
        cell.render(pointViewModel)
        return UITableViewCell()
    }
    
    func searchAroundLocation(coordinate:CLLocationCoordinate2D){
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        request.types = "餐饮服务|生活服务"
        request.sortrule = 0;
        request.requireExtension = true;
        self.mapSearch?.AMapPOIAroundSearch(request)
    }
}

extension LocationPickerDataSource:AMapSearchDelegate {
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 {
            return
        }
        self.searchResultArray = response.pois
        self.tableView?.reloadData()
    }
}
