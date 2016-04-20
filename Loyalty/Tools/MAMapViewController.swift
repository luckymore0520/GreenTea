//
//  MAMapViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class MAMapViewController: UIViewController {
    var mapView:MAMapView?
    var mapSearch:AMapSearchAPI?
    var isLocated:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMapView()
        self.initSearch()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initMapView(){
        mapView = MAMapView(frame: self.view.bounds)
        mapView!.delegate = self
        mapView?.showsUserLocation = true
        mapView?.setZoomLevel(15, animated: false)
        self.view.addSubview(mapView!)
    }
    
    func initSearch(){
        mapSearch = AMapSearchAPI()
        mapSearch?.delegate = self
    }

}

extension MAMapViewController:AMapSearchDelegate {
    func searchReGeocodeWithCoordinate(coordinate: CLLocationCoordinate2D!) {
        let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        regeo.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        print("regeo :\(regeo)")
        self.mapSearch?.AMapReGoecodeSearch(regeo)
    }
    
    func AMapSearchRequest(request: AnyObject!, didFailWithError error: NSError!) {
        print("request :\(request), error: \(error)")
    }
    
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest, response: AMapReGeocodeSearchResponse) {
        if (response.regeocode != nil) {
            let coordinate = CLLocationCoordinate2DMake(Double(request.location.latitude), Double(request.location.longitude))
            let annotation = MAPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = response.regeocode.formattedAddress
            annotation.subtitle = response.regeocode.addressComponent.province
            mapView!.addAnnotation(annotation)
            let overlay = MACircle(centerCoordinate: coordinate, radius: 50.0)
            mapView!.addOverlay(overlay)
        }
    }
}

extension MAMapViewController:MAMapViewDelegate {
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation && !isLocated{
            self.isLocated = true
            mapView.setCenterCoordinate(userLocation.coordinate
                , animated: false)
            searchReGeocodeWithCoordinate(userLocation.coordinate)
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
            poiAnnotationView?.highlighted = true
            poiAnnotationView!.canShowCallout = true
            return poiAnnotationView;
        }
        return nil
    }
    
}
