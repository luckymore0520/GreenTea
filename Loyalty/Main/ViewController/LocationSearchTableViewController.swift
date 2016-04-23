//
//  LocationSearchTableViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/23.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class LocationSearchTableViewController: UITableViewController {
    var searchResult:[AMapPOI] = []
    var mapSearch = AMapSearchAPI()
    var selectionHandler:((poi:AMapPOI) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapSearch.delegate = self
        self.tableView.registerReusableCell(PointInfoTableViewCell.self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.frame = CGRectMake(0, -44, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResult.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PointInfoTableViewCell
        let poi = self.searchResult[indexPath.row]
        let pointViewModel = PointInfoTableViewCellViewModel(poi: poi, isChecked: false)
        cell.render(pointViewModel)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectionHandler = self.selectionHandler else { return }
        selectionHandler(poi: self.searchResult[indexPath.row])
    }
}



extension LocationSearchTableViewController {
    func searchLocation(keyword:String?){
        guard let keyword = keyword else { return }
        let request = AMapPOIKeywordsSearchRequest()
        request.types = "餐饮服务|生活服务"
        request.sortrule = 0;
        request.keywords = keyword
        request.city = UserDefaultTool.stringForKey(kCityKey)
        self.mapSearch?.AMapPOIKeywordsSearch(request)
    }
}


extension LocationSearchTableViewController:AMapSearchDelegate {
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 {
            return
        }
        self.searchResult = response.pois as! [AMapPOI]
        self.tableView?.reloadData()
    }
}
