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
        setPin("Pin Title","detail", 37.506804,139.930531) // test
        
        showOpreationView()
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
    
    func setPin(_ title : String?, _ subtitle : String?,
                _ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let myPin : MKPointAnnotation = MKPointAnnotation()
        let pinCenter: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        myPin.coordinate = pinCenter
        myPin.title = title
        myPin.subtitle = subtitle
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
    
    // MARK: - show Opreation View
    func showOpreationView() {
        // ボタンを作成.
        let backButton: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 120,height: 50))
        backButton.backgroundColor = UIColor.red;
        backButton.setTitle("Back", for: UIControlState())
        backButton.setTitleColor(UIColor.white, for: UIControlState())
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-100)
        backButton.addTarget(self, action: #selector(self.onClickBackButton(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    func onClickBackButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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
        myMapView.removeAnnotations()
        setPin("Current Location","detail", (myLocation.latitude),(myLocation.longitude)) // test
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
    
    // addOverlayed
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // create a renderer
        let myCircleview : MKCircleRenderer = MKCircleRenderer()
        myCircleview.fillColor = UIColor.yellow
        myCircleview.strokeColor = UIColor.red
        myCircleview.alpha = 0.5
        myCircleview.lineWidth = 1.5
        return myCircleview
    }
    
    // annotation to add an image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let myIdentifier = "myPin"
        var myAnnotation: MKAnnotation!
        
        if myAnnotation == nil {
            myAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: myIdentifier)
        }
        myAnnotation.image = UIImage(named: "Icon-40")!
        myAnnotation.annotation = annotation
        return myAnnotation
    }

    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {}

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {}

    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {}

    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {}

    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {}

}
