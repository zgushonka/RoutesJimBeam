//
//  LocationProvider.swift
//  JimBeam
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationProvider: NSObject {
    
    fileprivate var timer: Timer?
    fileprivate let recordInterval: TimeInterval = 5.0
    fileprivate let outdateValue: TimeInterval = -(5 * 60)
    fileprivate let locationFetchRetryPeriod: TimeInterval = 5.0
    
    fileprivate let locationService = LocationService.shared
    
    fileprivate var atLocationUpdate: ( (_ lastLocation: CLLocation) -> () )?
    
    fileprivate var startDate: Date!
    
    func startFetchingLocation(_ completion: @escaping (_ lastLocation: CLLocation) -> () ) {
        if timer == nil {
            atLocationUpdate = completion
            startDate = Date()
            locationService.startUpdatingLocation()
            fetchLocation() // add first route location
            timer = Timer.scheduledTimer(timeInterval: recordInterval, target: self, selector: #selector(fetchLocation), userInfo: nil, repeats: true)
        }
    }
    
    func stopFetchingLocation() {
        timer?.invalidate()
        timer = nil
        fetchLocation() // add last route location
        atLocationUpdate = nil
        locationService.stopUpdatingLocation()
    }
    
    @objc func fetchLocation() {
        debugPrint("INFO: try record location. \(Date())")
        if let location = currentLocation() {
            let lastLocationTimeOutdate = location.timestamp.timeIntervalSince(startDate) // negative is older than startDate
            let islastLocationActual = lastLocationTimeOutdate > outdateValue // not older than 5 minutes
            if  islastLocationActual {
                atLocationUpdate?(location)
            } else {
                perform(#selector(fetchLocation), with: nil, afterDelay: locationFetchRetryPeriod) // try update location after timeout
            }
        }
    }
    
    func currentLocation() -> CLLocation? {
        return locationService.lastLocation()
    }
    
}


