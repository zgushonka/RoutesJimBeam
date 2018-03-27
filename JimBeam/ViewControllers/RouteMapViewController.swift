//
//  RouteMapViewController.swift
//  JimBeam
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import UIKit
import GoogleMaps

class RouteMapViewController: UIViewController {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var destLabel: UILabel!

    var model: RouteMapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showRoute()
        
        if let model = model {
            timeLabel.text = model.tripTimeText()
            distanceLabel.text = model.tripDistanceText()
            speedLabel.text = model.tripAvgSpeedText()
            
            model.destinationDescription() { [weak self] address in
                self?.destLabel.text = address
            }
        }
    }
    
    func showRoute() {
        guard let locations = model?.route?.locations,
            let firstLocation = locations.first else {
                return
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: firstLocation.coordinate.latitude,
                                              longitude: firstLocation.coordinate.longitude,
                                              zoom: 14.0)
        let map = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
        map.isMyLocationEnabled = true
        mapView.addSubview(map)
        
        let path = GMSMutablePath()
        for aLocation in locations {
            path.add(aLocation.coordinate)
        }
        
        let line = GMSPolyline.init(path: path)
        line.strokeWidth = 5.0
        line.strokeColor = UIColor.red
        line.map = map
    }

}
