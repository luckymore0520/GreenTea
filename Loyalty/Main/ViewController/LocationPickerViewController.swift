//
//  LocationPickerViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Cartography
class LocationPickerViewController: UIViewController {
    let searchViewController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var mapViewLocation: UIView!
    @IBOutlet weak var tableView: UITableView!
    var mapView:MAMapView?
    var mapSearch:AMapSearchAPI?
    var isLocated:Bool = false
    var pointInfoDataSource:LocationPickerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.view.addSubview(searchViewController.searchBar)
        self.title = "选择位置"
        self.initMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initMapView(){
        mapView = MAMapView(frame: self.mapViewLocation.bounds)
        mapView!.delegate = self
        mapView?.showsUserLocation = true
        mapView?.setZoomLevel(15, animated: false)
        self.mapViewLocation.addSubview(mapView!)
        constrain(mapView!,self.mapViewLocation) {
            mapView, parentView in
            mapView.left == parentView.left
            mapView.right == parentView.right
            mapView.top == parentView.top
            mapView.bottom == parentView.bottom
        }
    }
    
}

extension LocationPickerViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.pointInfoDataSource?.selectRow(indexPath)
    }
}

extension LocationPickerViewController:MAMapViewDelegate {
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation && !isLocated{
            self.isLocated = true
            mapView.setCenterCoordinate(userLocation.coordinate
                , animated: false)
            self.pointInfoDataSource = LocationPickerDataSource(tableView: self.tableView, coordinate: userLocation.coordinate)
        }
    }
}

