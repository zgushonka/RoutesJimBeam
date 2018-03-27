//
//  RouteMapViewModelTests.swift
//  JimBeamTests
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import XCTest
@testable import JimBeam

class RouteMapViewModelTests: XCTestCase {
    
    var routeMapViewModel: RouteMapViewModel!
    
    override func setUp() {
        super.setUp()
        
        let route = XCTestCase.makeTestRoute()
        routeMapViewModel = RouteMapViewModel(route: route)
    }
    
    func testRouteExists() {
        XCTAssertNotNil(routeMapViewModel, "Route not created")
    }
    
    func testTripTimeText() {
        let actual = routeMapViewModel.tripTimeText()
        let expected = "TripTime: 54m 15s"
        XCTAssert(actual == expected, "Text is \(actual) instead of \(expected)")
    }
    
    func testTripDistanceText() {
        let actual = routeMapViewModel.tripDistanceText()
        let expected = "TripDistance: 115.5km"
        XCTAssert(actual == expected, "Text is \(actual) instead of \(expected)")
    }
    
    func testTripAvgSpeedText() {
        let actual = routeMapViewModel.tripAvgSpeedText()
        let expected = "avgSpeed: 127.8km/h"
        XCTAssert(actual == expected, "Text is \(actual) instead of \(expected)")
    }
}
