//
//  CodingStore.swift
//  JimBeam
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation

class CodingStore: DataStore {
    
    fileprivate let routesTitleFile = "namesFile"
    
    func store(route: Route) {
        let fileName = route.creationDate.description
        store(data: route, toFile: fileName)
        store(newRouteName: fileName)
    }
    
    func routes() -> [Route] {
        var routes: [Route] = []
        let routesTitles = self.routesTitles()
        for fileName in routesTitles {
            if let route = routeWithName(fileName) {
                routes.append(route)
            }
        }
        return routes
    }
    
    fileprivate func routeWithName(_ fileName: String) -> Route? {
        let namesFilePath = getDocumentsDirectory().appendingPathComponent(fileName)
        let route = NSKeyedUnarchiver.unarchiveObject(withFile: namesFilePath.path) as? Route
        return route
    }
    
    fileprivate func store(data: Any, toFile fileName: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: data)
        let fullPath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(to: fullPath)
        } catch {
            print("Couldn't write file")
        }
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

// Route Titles Storage
extension CodingStore {
    fileprivate func store(newRouteName fileName: String) {
        var routesTitlesArray = routesTitles()
        routesTitlesArray.append(fileName)
        
        store(data: routesTitlesArray, toFile: routesTitleFile)
    }
    
    fileprivate func routesTitles() -> [String] {
        let namesFilePath = getDocumentsDirectory().appendingPathComponent(routesTitleFile)
        let routesFileNames = NSKeyedUnarchiver.unarchiveObject(withFile: namesFilePath.path) as? [String]
        return routesFileNames ?? []
    }
}
