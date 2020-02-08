//
//  CofradiasViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class CofradiasViewController: UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    
    var cofradias: [Cofradia] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cofradias"
        cofradias = Cofradia.cofradias
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        tableView.register(CofradiaCell.self, forCellReuseIdentifier: "cofradiaCell")
        userActivity = NSUserActivity.verCofradias
        userActivity?.becomeCurrent()
        var count = UserDefaults.standard.integer(forKey: "contadorReview")
        count += 1
        UserDefaults.standard.set(count, forKey: "contadorReview")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text)
    }
    
    func filterContentForSearchText(searchText: String?) {
        if let text = searchText, text != "" {
            cofradias = Cofradia.cofradias.filter { $0.nombre.lowercased().contains(text.lowercased()) }
        } else {
            cofradias = Cofradia.cofradias
        }
    }
    
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { cofradias.count }
    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
}
