//
//  RoutesData.swift
//  JimBeam
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation

class RoutesData {
    static let shared = RoutesData()
    
    let dataStorage: DataStore = RealmStore()
    
    func store(route: Route) {
        dataStorage.store(route: route)
    }
    
    func rotues() -> [Route] {
        var routes = dataStorage.routes()
        routes = routes.sorted { $0 < $1 }
        return routes
    }
    
    func lastRoute() -> Route? {
        return rotues().last
    }
    
}

protocol DataStore {
    func store(route: Route)
    func routes() -> [Route]
}
