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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cofradia.procesiones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = (cofradia.buscarProcesiones()[indexPath.row]).nombre
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if let cell = sender as? UITableViewCell {
            let row = tableView.indexPath(for: cell)!.row
            let vc = segue.destination as! DetalleProcesionViewController
            vc.procesion = cofradia.buscarProcesiones()[row]
            self.tableView.deselectRow(at: tableView.indexPath(for: cell)!, animated: true)
        }
    }
    
}
