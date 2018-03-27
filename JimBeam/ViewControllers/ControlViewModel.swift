//
//  ControlViewModel.swift
//  JimBeam
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import Foundation

class ControlViewModel {
    
    fileprivate let locationRecorder = LocationRecorder.shared
    fileprivate let locationService = LocationService.shared
    
    var atRecordStateUpdate: ( ()->() )?
    
    func recordButtonTitle() -> String {
        return isRecording() ? "Stop" : "Start"
    }
    
    func switchRecord() {
        guard isRecordingAvaliable() else {
            locationService.askForLocationsAccess() { [weak self] in
                self?.locationRecorder.startRecording()
                self?.atRecordStateUpdate?()
            }
            return
        }
        
        if isRecording() {
            locationRecorder.stopRecording()
        } else {
            locationRecorder.startRecording()
        }
        atRecordStateUpdate?()
    }
    
    func isRecordingAvaliable() -> Bool {
        return LocationService.isLocationServicesEnabled()
    }
    
    func isRecording() -> Bool {
        return locationRecorder.isRecording
    }
    
    func isRecordsAvaliable() -> Bool {
        return lastRoute() != nil
    }
    
    func routes() -> [Route] {
        return RoutesData.shared.rotues()
    }
    
    func lastRoute() -> Route? {
        return RoutesData.shared.lastRoute()
    }
    
}
