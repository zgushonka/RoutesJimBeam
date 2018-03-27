//
//  ControlViewController.swift
//  JimBeam
//
//  Created by Buravlyov on 9/25/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var showLastRouteButton: UIButton!
    
    var model = ControlViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Jim Beam"
        model.atRecordStateUpdate = { [weak self] in
            self?.updateRecordButton()
            self?.updateLastRouteButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateRecordButton()
        updateLastRouteButton()
    }
    
    fileprivate func updateRecordButton() {
        let newTitle = model.recordButtonTitle()
        recordButton.setTitle(newTitle, for: .normal)
    }
    
    fileprivate func updateLastRouteButton() {
        showLastRouteButton.isEnabled = model.isRecordsAvaliable()
    }

    @IBAction func recordButtonPressed(_ sender: UIButton?) {
        model.switchRecord()
    }
    
    @IBAction func lastRouteButtonPressed(_ sender: UIButton?) {
        performSegue(withIdentifier: "ShowRouteSegue", sender: nil)
    }
    
    @IBAction func showRoutesButtonPressed(_ sender: UIBarButtonItem?) {
        performSegue(withIdentifier: "ShowRoutesListSegue", sender: nil)
    }

    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVc = segue.destination as? RouteListTableViewController {
            let routes = self.model.routes()
            let model = RouteListViewModel(routes: routes)
            destVc.model = model
        } else
        if let destVc = segue.destination as? RouteMapViewController {
            if let route = model.lastRoute() {
                let model = RouteMapViewModel(route: route)
                destVc.model = model
            }
        }
     }
    
}

