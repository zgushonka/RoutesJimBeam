//
//  JimBeamTests.swift
//  JimBeamTests
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//


import XCTest
@testable import JimBeam
import CoreLocation


class JimBeamTests: XCTestCase {
    
}
// */

extension XCTestCase {
    static func makeTestRoute() -> Route {
        var route = Route()
        
        let startDate = Date(timeIntervalSince1970: 1000)
        route.addLocation(CLLocation(coordinate: CLLocationCoordinate2D(latitude: +37.33492222, longitude: -122.03304215),
                                     altitude: 100, horizontalAccuracy: 5.0, verticalAccuracy: 5.0, course: 0, speed: 0,
                                     timestamp: startDate))
        
        route.addLocation(CLLocation(coordinate: CLLocationCoordinate2D(latitude: +37.33238246, longitude: -122.05644652),
                                     altitude: 100, horizontalAccuracy: 5.0, verticalAccuracy: 5.0, course: 0, speed: 0,
                                     timestamp: startDate.addingTimeInterval(30 * 60)))
        
        route.addLocation(CLLocation(coordinate: CLLocationCoordinate2D(latitude: +38.35444650, longitude: -122.06749672),
                                     altitude: 100, horizontalAccuracy: 5.0, verticalAccuracy: 5.0, course: 0, speed: 0,
                                     timestamp: startDate.addingTimeInterval(54.25 * 60)))
        
        return route
    }
    
    static func makeHobbitRoute() -> Route {
        var route = Route()
        
        let startDate = Date(timeIntervalSince1970: 1000)
        
        let coordinatesShire = CLLocationCoordinate2D(latitude: +37, longitude: -122)
        let coordinatesErebor = CLLocationCoordinate2D(latitude: +38, longitude: -125)
        
        let locationShireStart = CLLocation(coordinate: coordinatesShire,
                                            altitude: 100, horizontalAccuracy: 5.0, verticalAccuracy: 5.0,
                                            timestamp: startDate)
        
        let locationErebor = CLLocation(coordinate: coordinatesErebor,
                                        altitude: 2900, horizontalAccuracy: 5.0, verticalAccuracy: 5.0,
                                        timestamp: startDate.addingTimeInterval(54.25 * 60))
        
        let locationShireFinish = CLLocation(coordinate: coordinatesShire,
                                             altitude: 100, horizontalAccuracy: 5.0, verticalAccuracy: 5.0,
                                             timestamp: startDate.addingTimeInterval(2 * 54.25 * 60))
        
        route.addLocation(locationShireStart)
        route.addLocation(locationErebor)
        route.addLocation(locationShireFinish)
        return route
    }
    
}

