//
//  UserLocationUtils.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/21/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit
//import MapKit
import CoreLocation

class UserLocationUtils: NSObject {

    private static let sharedInstance = UserLocationUtils()
    var userPosition: CLLocationCoordinate2D?
    private lazy var locationManager:CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        return locationManager
    }()
    
    class var sharedUserLocationUtils: UserLocationUtils {
        return sharedInstance
    }
    
    /// get User location authentication
    func startUserlocation() {
        _ = locationManager.autoContentAccessingProxy
        locationManager.startUpdatingLocation()
    }
}

extension UserLocationUtils: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        print(error)

    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
        let userPos = locations[0] as CLLocation
        userPosition = userPos.coordinate
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            print("denied")
        case CLAuthorizationStatus.denied:
            print("denied")
        case CLAuthorizationStatus.notDetermined:
            print("notDetermined")
        default:
            print("default")
        }
    }
}
