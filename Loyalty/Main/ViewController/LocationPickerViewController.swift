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
    let searchController = UISearchController(searchResultsController: LocationSearchTableViewController() )
    @IBOutlet weak var mapViewLocation: UIView!
    @IBOutlet weak var tableView: UITableView!
    var mapView:MAMapView?
    var mapSearch:AMapSearchAPI?
    var isLocated:Bool = false
    var currentLocation:CLLocationCoordinate2D?
    var pointInfoDataSource:LocationPickerDataSource?

    
    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择位置"
        self.automaticallyAdjustsScrollViewInsets = false
        self.initMapView()
        self.initSearchController()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initSearchController(){
        // Setup the Search Controller
        self.view.addSubview(searchController.searchBar)
        self.searchTableView.tableHeaderView = searchController.searchBar
        self.searchTableView.tableFooterView = UIView()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        if let searchResoultController = self.searchController.searchResultsController as? LocationSearchTableViewController {
            searchResoultController.selectionHandler = {
                [unowned self]
                result in
                log.info("选择\(result.name)")
                self.searchController.active = false
            }
        }
    }
    
    func initMapView(){
        mapView = MAMapView(frame: self.mapViewLocation.bounds)
        mapView!.delegate = self
        mapView?.showsUserLocation = true
        mapView?.setZoomLevel(12.5, animated: false)
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


extension LocationPickerViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
}

extension LocationPickerViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchResultController = self.searchController.searchResultsController as? LocationSearchTableViewController
        searchResultController?.searchLocation(self.searchController.searchBar.text)
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
            self.currentLocation = userLocation.coordinate
        }
    }
}

