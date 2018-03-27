//
//  HobbitRouteTests.swift
//  JimBeamTests
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import JimBeam

class HobbitRouteTests: XCTestCase {
    
    var route: Route!
    
    override func setUp() {
        super.setUp()
        
        route = XCTestCase.makeHobbitRoute()
    }
    
    func testHobbitDistance() {
        let actual = route.tripDistance
        debugPrint("Hobbit distance - \((actual/1000).rounded())km")
        XCTAssert(actual > 0, "The hobbit did not sit at home")
    }
    
}
