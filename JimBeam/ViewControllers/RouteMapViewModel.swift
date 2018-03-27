//
//  RouteMapViewModel.swift
//  JimBeam
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import GoogleMaps

class RouteMapViewModel {
    
    var route: Route?
    
    init(route: Route) {
        self.route = route
    }
    
    func tripTimeText() -> String {
        guard let tripTime = route?.tripTime else { return "TripTime: unknown" }
        let timeM = Int(tripTime) / 60
        let timeS = Int(tripTime) % 60
        return "TripTime: \(timeM)m \(timeS)s"
    }
    
    func tripDistanceText() -> String {
        guard let tripDist = route?.tripDistance else { return "TripDistance: unknown" }
        let formatedString = (tripDist / 1000).format(f: ".01")
        return "TripDistance: \(formatedString)km"
    }
    
    func tripAvgSpeedText() -> String {
        guard let tripSpeed = route?.avgSpeed else { return "avgSpeed: unknown" }
        let formatedString = (tripSpeed * 3.6).format(f: ".01")
        return "avgSpeed: \(formatedString)km/h"
    }
    
    var address: String?
    
    func destinationDescription(_ completion: @escaping (String)->() ) {
        if address != nil {
            completion(address!)
        }
        
        if let lastLocation = route?.locations.last {
            GMSGeocoder().reverseGeocodeCoordinate(lastLocation.coordinate, completionHandler: { [weak self] (response, error) in
                    if let firstLine = response?.firstResult()?.lines?.first {
                        var address = "Dest: " + firstLine
                        if let postalCode = response?.firstResult()?.postalCode {
                            address += ", " + postalCode
                        }
                        self?.address = address
                    DispatchQueue.main.async {
                        completion(address)
                    }
                }
            })
        }
    }
    
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
