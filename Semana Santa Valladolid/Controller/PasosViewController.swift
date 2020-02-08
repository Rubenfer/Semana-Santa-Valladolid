//
//  PasosViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class PasosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pasos"
        let count = UserDefaults.standard.integer(forKey: "contadorReview")
        UserDefaults.standard.set(count+1, forKey: "contadorReview")
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int { Cofradia.cofradias.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { Cofradia.cofradias[section].pasos.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Cofradia.cofradias[indexPath.section].pasos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { Cofradia.cofradias[section].nombre }
    
}
