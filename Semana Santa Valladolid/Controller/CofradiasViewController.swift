//
//  CofradiasViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class CofradiasViewController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var cofradias: [Cofradia] {
        get {
            if searchController.isSearching() {
                return DataManager.cofradias.filter { cofradia in
                    cofradia.nombre.lowercased().contains(searchController.searchBar.text!.lowercased())
                }
            } else {
                return DataManager.cofradias
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cofradias"
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        userActivity = NSUserActivity.verCofradias
        userActivity?.becomeCurrent()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        tableView.reloadData()
    }
    
    
    // MARK: - TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cofradias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.imageView?.image = UIImage(named: "blanco")
        let imageViewB = UIImageView(frame: CGRect(x: 15, y: 15, width: 90, height: 90))
        imageViewB.image = UIImage(named: "blanco")
        cell.addSubview(imageViewB)
        cell.textLabel?.text = cofradias[indexPath.row].nombre
        let imageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 90, height: 90))
        imageView.image = UIImage(named: cofradias[indexPath.row].id)
        cell.addSubview(imageView)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let row = tableView.indexPath(for: cell)!.row
            let vc = segue.destination as! DetalleCofradiaViewController
            vc.cofradia = cofradias[row]
            self.tableView.deselectRow(at: tableView.indexPath(for: cell)!, animated: true)
        }
    }
    

}
