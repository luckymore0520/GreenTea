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
    var selectedAnotation:MAPointAnnotation?
    var isLocated:Bool = false
    var currentLocation:CLLocationCoordinate2D?
    var selectedPOI:AMapPOI?
    var pointInfoDataSource:LocationPickerDataSource?
    var pickCompletion:((location:CLLocationCoordinate2D,address:String)->Void)?
    
    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择位置"
        self.automaticallyAdjustsScrollViewInsets = false
        self.initMapView()
        self.initSearchController()
        self.setRightButton("确定", selector: #selector(LocationPickerViewController.onSaveButtonClicked))
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
                self.drawAnootation(result)
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
    
    func drawAnootation(poi:AMapPOI) {
        let anotation = MAPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2DMake(Double(poi.location.latitude), Double(poi.location.longitude))
        anotation.title = poi.name
        anotation.subtitle = poi.address
        self.mapView?.addAnnotation(anotation)
        if let currentAnnotation = self.selectedAnotation {
            self.mapView?.removeAnnotation(currentAnnotation)
        }
        self.mapView?.setCenterCoordinate(anotation.coordinate, animated: true)
        self.selectedAnotation = anotation
        self.selectedPOI = poi
    }
    
}

// MARK: - Action
extension LocationPickerViewController {
    func onSaveButtonClicked(){
        self.navigationController?.popViewControllerAnimated(true)
        guard let currentLocation = self.currentLocation else { return }
        guard let completion = self.pickCompletion else { return }
        guard let selectedPOI = self.selectedPOI else { return }
        completion(location: currentLocation, address: selectedPOI.address)
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
        let selectedPOI = self.pointInfoDataSource?.selectRow(indexPath)
        guard let poi = selectedPOI else { return }
        self.drawAnootation(poi)
    }
}

extension LocationPickerViewController:MAMapViewDelegate {
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation && !isLocated{
            self.isLocated = true
            mapView.setCenterCoordinate(userLocation.coordinate
                , animated: false)
            self.pointInfoDataSource = LocationPickerDataSource(tableView: self.tableView, coordinate: userLocation.coordinate)
            self.pointInfoDataSource?.loadPoiCompletion = {
                [unowned self]
                poi in
                self.drawAnootation(poi)
            }
            self.currentLocation = userLocation.coordinate
        }
    }
    
    
    func mapView(mapView: MAMapView, viewForAnnotation annotation: MAAnnotation) -> MAAnnotationView? {
        if annotation.isKindOfClass(MAPointAnnotation) {
            let annotationIdentifier = "invertGeoIdentifier"
            var poiAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) as? MAPinAnnotationView
            if poiAnnotationView == nil {
                poiAnnotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            }
            poiAnnotationView!.pinColor = MAPinAnnotationColor.Green
            poiAnnotationView!.animatesDrop   = true
            poiAnnotationView!.canShowCallout = true
            return poiAnnotationView;
        }
        return nil
    }
}

