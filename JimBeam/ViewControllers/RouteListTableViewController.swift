//
//  RouteListTableViewController.swift
//  JimBeam
//
//  Created by Buravlyov on 9/26/17.
//  Copyright © 2017 Buravlyov. All rights reserved.
//

import UIKit

class RouteListTableViewController: UITableViewController {

    var model: RouteListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.routes?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell reuseIdentifier", for: indexPath)
        cell.textLabel?.text = model?.routeTitle(indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowRouteSegueFromList", sender: nil)
    }
    
    fileprivate func selectedRoute() -> Route? {
        var route: Route? = nil
        if let index = tableView.indexPathForSelectedRow?.row {
            route = model?.routes?[index]
        }
        return route
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVc = segue.destination as? RouteMapViewController {
            if let route = selectedRoute() {
                let model = RouteMapViewModel(route: route)
                destVc.model = model
            }
        }
    }

}
