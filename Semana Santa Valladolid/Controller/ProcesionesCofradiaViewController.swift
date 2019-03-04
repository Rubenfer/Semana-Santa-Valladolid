//
//  ProcesionesCofradiaViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class ProcesionesCofradiaViewController: UITableViewController {
    
    var cofradia: Cofradia!
    var procesiones: [(Procesion, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        procesiones = cofradia.buscarProcesiones()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cofradia.procesiones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            }
            return cell
        }()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = (procesiones[indexPath.row].0).nombre
        cell.detailTextLabel?.text = procesiones[indexPath.row].1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetalleProcesionViewController()
        vc.procesion = procesiones[indexPath.row].0
        self.tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
