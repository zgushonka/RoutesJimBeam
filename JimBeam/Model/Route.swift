//
//  Route.swift
//  JimBeam
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import CoreLocation

struct Route {
    fileprivate (set) var locations: [CLLocation]
    
    init() {
        locations = []
    }
    
    init(withLocations locations: [CLLocation]) {
        self.locations = locations
    }
    
    var creationDate: Date {
        return self.locations.first?.timestamp ?? Date.distantPast
    }
    
    mutating func addLocation(_ location: CLLocation) {
        locations.append(location)
    }
    
    var tripTime: TimeInterval {
        get {
            guard let startTime = locations.first?.timestamp,
                let finishTime = locations.last?.timestamp else {
                    return 0.0
            }
            return finishTime.timeIntervalSince(startTime)
        }
    }
    
    var tripDistance: CLLocationDistance {
        get {
            return tripDistanceSafe()
        }
    }
    
    fileprivate func tripDistanceSafe() -> CLLocationDistance {
        guard locations.count > 2 else { return 0.0 }

        var tripDistance: CLLocationDistance = 0.0
        var previousLocation: CLLocation? = nil
        for aLocation in locations {
            if let _ = previousLocation {
                tripDistance += previousLocation!.distance(from: aLocation)
            }
            previousLocation = aLocation
        }
        return tripDistance
    }

    
    func tripDistanceOld() -> CLLocationDistance {
        let locationsCopy = locations
        guard locationsCopy.count > 2 else { return 0.0 }
        
        var tripDistance: CLLocationDistance = 0
        for (index, aLocation) in locationsCopy.enumerated() {
            if aLocation == locationsCopy.last { break }
            
            let nextLocation = locationsCopy[index + 1] // it's safe to fetch next item
            let newDistance = aLocation.distance(from: nextLocation)
            tripDistance += newDistance
        }
        return tripDistance
    }
    
    var avgSpeed: CLLocationSpeed {
        get {
            let tripTime = self.tripTime
            guard tripTime > 0 else { return 0.0 }
            
            let avgSpeed = tripDistance / tripTime
            return avgSpeed
        }
    }

}

extension Route: Comparable {
    static func ==(lhs: Route, rhs: Route) -> Bool {
        return lhs.creationDate == rhs.creationDate
    }
    
    static func <(lhs: Route, rhs: Route) -> Bool {
        return lhs.creationDate < rhs.creationDate
    }
}

