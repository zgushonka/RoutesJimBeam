//
//  RouteListViewModel.swift
//  JimBeam
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation

struct RouteListViewModel {
    
    fileprivate (set) var routes: [Route]?
    
    init(routes: [Route]) {
        self.routes = routes
    }
    
    func routeTitle(_ index: Int) -> String {
        guard let route = routes?[index] else { return "none" }
        
        let title = "\(index) - \(route.creationDate)"
        return title
    }
}
