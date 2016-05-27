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
    var searchResultArray:[AMapPOI] = []
    var selectedRow:Int = 0
    var loadPoiCompletion:((firstPOI:AMapPOI) -> Void)?
    
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
        let poi = self.searchResultArray[indexPath.row]
        let pointViewModel = PointInfoTableViewCellViewModel(poi: poi, isChecked: indexPath.row == self.selectedRow)
        cell.render(pointViewModel)
        return cell
    }
    
    func searchAroundLocation(coordinate:CLLocationCoordinate2D){
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        request.types = "餐饮服务|购物服务"
        request.sortrule = 0;
        request.requireExtension = true;
        request.offset = 100;
        self.mapSearch?.AMapPOIAroundSearch(request)
    }
}


// MARK: - PublicFunc
extension LocationPickerDataSource {
    func selectRow(indexPath:NSIndexPath) -> AMapPOI{
        if indexPath.row != self.selectedRow {
            let originIndexPath = NSIndexPath(forRow: self.selectedRow, inSection: 0)
            self.selectedRow = indexPath.row
            self.tableView?.reloadRowsAtIndexPaths([originIndexPath,indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
        return self.searchResultArray[indexPath.row]
    }
}

extension LocationPickerDataSource:AMapSearchDelegate {
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 {
            return
        }
        self.searchResultArray = response.pois as? [AMapPOI] ?? []
        if let completion = self.loadPoiCompletion {
            completion(firstPOI: self.searchResultArray[0])
        }
        self.tableView?.reloadData()
    }
}
