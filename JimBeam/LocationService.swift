//
//  LocationService.swift
//  JimBeam
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    static let shared = LocationService()
    private var locationManager: CLLocationManager?
    
    var atLocationAccessGranted: ( ()->() )?
    
    private override init() {
        super.init()
        
        initLocationManager()
    }
    
    /// create a Location Manager
    private func initLocationManager() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager?.delegate = self
            locationManager?.activityType = .automotiveNavigation
            locationManager?.allowsBackgroundLocationUpdates = true
        }
    }
    
    func lastLocation() -> CLLocation? {
        return locationManager?.location
    }
    
    /// Star updating location updates
    func startUpdatingLocation() {
        if LocationService.isLocationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
    
    static func isLocationServicesEnabled() -> Bool {
        var enabled = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                enabled = true
            case .denied, .notDetermined, .restricted:
                enabled = false
            }
        }
        return enabled
    }
    
    func askForLocationsAccess(_ completion: ( ()->() )? = nil ) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted, .denied, .notDetermined:
            atLocationAccessGranted = completion
            locationManager?.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            break
        }
    }
    
}


//
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            atLocationAccessGranted?()
            atLocationAccessGranted = nil
        }
    }
}
