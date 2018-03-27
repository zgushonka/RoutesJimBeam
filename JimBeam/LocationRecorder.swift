//
//  LocationRecorder.swift
//  JimBeam
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationRecorder {
    
    static let shared = LocationRecorder()
    
    fileprivate (set) var isRecording = false
    fileprivate let locationProvider = LocationProvider()
    
    var currentRoute: Route?
    
    func startRecording() {
        if !isRecording,
            LocationService.isLocationServicesEnabled() {
            debugPrint("INFO: Start route.")
            isRecording = true
            currentRoute = Route()
            locationProvider.startFetchingLocation() { newLocation in
                debugPrint("INFO: Add location - \(newLocation)")
                self.currentRoute?.addLocation(newLocation)
            }
        }
    }
    
    func stopRecording() {
        locationProvider.stopFetchingLocation()
        isRecording = false
        debugPrint("INFO: Finish route with \(currentRoute?.locations.count ?? 0) locations.")
        
        // store Route
        if let _ = currentRoute {
            RoutesData.shared.store(route: currentRoute!)
        }
    }
    
}
