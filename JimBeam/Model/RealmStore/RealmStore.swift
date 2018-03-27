//
//  RealmStore.swift
//  JimBeam
//
//  Created by Oleksandr Buravlyov on 9/27/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmStore: DataStore {
    let realm = try! Realm()
    
    func store(route: Route) {
        let routeRealm = RouteRealm(route: route)
        try! realm.write {
            realm.add(routeRealm)
        }
    }
    
    func routes() -> [Route] {
        let routesRealm = realm.objects(RouteRealm.self)
        let routes = routesRealm.map { $0.route }
        return Array(routes)
    }
}
