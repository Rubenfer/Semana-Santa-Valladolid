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
    
    var cofradiasFiltradas = [Cofradia]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cofradias"
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        cofradiasFiltradas = DataManager.cofradias.filter { cofradias in
            return cofradias.nombre.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    
    // MARK: - TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isSearching() {
            return cofradiasFiltradas.count
        }
        return DataManager.cofradias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.imageView?.image = UIImage(named: "blanco")
        if searchController.isSearching() {
            cell.textLabel?.text = cofradiasFiltradas[indexPath.row].nombre
            let imageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 90, height: 90))
            imageView.image = UIImage(named: cofradiasFiltradas[indexPath.row].id)
            cell.addSubview(imageView)
        } else {
            cell.textLabel?.text = DataManager.cofradias[indexPath.row].nombre
            let imageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 90, height: 90))
            imageView.image = UIImage(named: DataManager.cofradias[indexPath.row].id)
            cell.addSubview(imageView)
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let row = tableView.indexPath(for: cell)!.row
            let vc = segue.destination as! DetalleCofradiaViewController
            if searchController.isSearching() {
                vc.cofradia = cofradiasFiltradas[row]
            } else {
                vc.cofradia = DataManager.cofradias[row]
            }
            self.tableView.deselectRow(at: tableView.indexPath(for: cell)!, animated: true)
        }
    }
    

}
