//
//  MapViewController.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/16/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

/*
 http://docs.fabo.io/swift/mapkit/004_point.html
 Info.plist
 
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>Use Location</string>
 */

import UIKit
import MapKit

class MapViewController : UIViewController {

// MapView
    var myMapView : MKMapView!
    var myLocationmanager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Map"
        self.view.backgroundColor = UIColor.cyan
        
        self.setupUI()
    }
    
    func setupUI() {
        /////// Location ///////
        setupLocation()
        /////// Map ////////////
        setupMap()
        testSetMapParameter()
        setPin()
    }
    func setupLocation() {
        myLocationmanager = CLLocationManager()
        myLocationmanager.delegate = self
        myLocationmanager.distanceFilter = 100.0
        myLocationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        let status = CLLocationManager.authorizationStatus()
        //display authorize dialog
        if status != CLAuthorizationStatus.authorizedWhenInUse {
            print("not determined")
            myLocationmanager.requestWhenInUseAuthorization()
        }
        myLocationmanager.startUpdatingLocation()
    }
    
    func setupMap() {
        myMapView = MKMapView()
        myMapView.frame = self.view.bounds
        myMapView.delegate = self
        self.view.addSubview(myMapView)
    }
    
    func setPin() {
        let myPin : MKPointAnnotation = MKPointAnnotation()
        // point
        let myLat: CLLocationDegrees = 37.506804
        let myLon: CLLocationDegrees = 139.930531
        let pinCenter: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon)
        myPin.coordinate = pinCenter
        myPin.title = "Pin Title"
        myPin.subtitle = "detail"
        myMapView.addAnnotation(myPin)
    }

    
    //  set up location center point
    func testSetMapParameter() {
        // point
        let myLat: CLLocationDegrees = 37.506804
        let myLon: CLLocationDegrees = 139.930531
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon)
        
        // Distance
        let myLatDist : CLLocationDistance = 100
        let myLonDist : CLLocationDistance = 100
        // Region
        var myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDist, myLonDist);
        
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        myRegion = MKCoordinateRegion(center: myCoordinate, span: span)

        
        myMapView.setRegion(myRegion, animated: true)
    }
    
}
extension MapViewController : CLLocationManagerDelegate {
    
    // GPSから値を取得した際に呼び出されるメソッド.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("didUpdateLocations")
        
        // 配列から現在座標を取得.
        let myLocations: NSArray = locations as NSArray
        let myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        let myLocation:CLLocationCoordinate2D = myLastLocation.coordinate
        
        print("\(myLocation.latitude), \(myLocation.longitude)")
        
        // 縮尺.
        let myLatDist : CLLocationDistance = 100
        let myLonDist : CLLocationDistance = 100
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, myLatDist, myLonDist);
        
        // MapViewに反映.
        myMapView.setRegion(myRegion, animated: true)
    }

    
    // 認証が変更された時に呼び出されるメソッド.
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
        case .authorized:
            print("Authorized")
        case .denied:
            print("Denied")
        case .restricted:
            print("Restricted")
        case .notDetermined:
            print("NotDetermined")
        }
    } 

}

extension MapViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("regionWillChangeAnimated")
    }
    
    // Regionが変更した時に呼び出されるメソッド.
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
    }

    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {}

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {}

    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {}

    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {}

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {}

}
