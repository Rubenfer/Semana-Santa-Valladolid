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
                return Cofradia.cofradias.filter { cofradia in
                    cofradia.nombre.lowercased().contains(searchController.searchBar.text!.lowercased())
                }
            } else {
                return Cofradia.cofradias
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
        tableView.register(CofradiaCell.self, forCellReuseIdentifier: "cofradiaCell")
        if #available(iOS 13.0, *) {
            searchController.searchBar.barTintColor = .systemGray3
        }
        userActivity = NSUserActivity.verCofradias
        userActivity?.becomeCurrent()
        var count = UserDefaults.standard.integer(forKey: "contadorReview")
        count += 1
        UserDefaults.standard.set(count, forKey: "contadorReview")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cofradiaCell", for: indexPath) as! CofradiaCell
        cell.configureCell()
        cell.imgView.image = UIImage(named: cofradias[indexPath.row].id)
        cell.label.text = cofradias[indexPath.row].nombre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detalleCofradiaVC") as! DetalleCofradiaViewController
        vc.cofradia = cofradias[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
