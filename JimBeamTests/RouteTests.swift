//
//  RouteTests.swift
//  JimBeamTests
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import JimBeam

class RouteTests: XCTestCase {
    
    var route: Route!
    
    override func setUp() {
        super.setUp()
        
        route = XCTestCase.makeTestRoute()
    }
    
    func testRouteExists() {
        XCTAssertNotNil(route, "Route not created")
    }
    
    func testCreateDate() {
        let expected = Date(timeIntervalSince1970: 1000)
        let actual = route.creationDate
        XCTAssert(actual == expected, "Creation date should be equal first location timestamp")
    }
    
    func testTripTime() {
        let expected: TimeInterval = 3255.0
        let actual = route.tripTime
        XCTAssert(actual == expected, "Trip time is \(actual) instead of \(expected)")
    }
    
    func testTripDistance() {
        let expected: CLLocationDistance = 115532.0
        let actual = route.tripDistance.rounded()
        XCTAssert(actual == expected, "Trip distance is \(actual) instead of \(expected)")
    }
    
    func testAvgSpeed() {
        let expected: CLLocationSpeed = (115532.0 / 3255.0).rounded()
        let actual = route.avgSpeed.rounded()
        XCTAssert(actual == expected, "Trip average is \(actual) instead of \(expected)")
    }
    
}
