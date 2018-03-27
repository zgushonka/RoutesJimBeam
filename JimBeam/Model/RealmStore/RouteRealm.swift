//
//  RouteRealm.swift
//  JimBeam
//
//  Created by Oleksandr Buravlyov on 9/27/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift

class RouteRealm: Object {
    @objc dynamic var locations: Data? = nil
    
    convenience init(route: Route) {
        self.init()
        self.locations = NSKeyedArchiver.archivedData(withRootObject: route.locations)
    }
    
    var route: Route {
        if let locations = locations,
            let clLocations = NSKeyedUnarchiver.unarchiveObject(with: locations) as? [CLLocation] {
            return Route(withLocations: clLocations)
        }
        return Route()
    }
    
}

