//
//  DetalleProcesionViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class DetalleProcesionViewController: UITableViewController {
    
    var procesion: Procesion!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
        switch indexPath.row {
        case 0:
            let attributes: [NSAttributedString.Key:Any] = [
                .font : UIFont.systemFont(ofSize: 20, weight: .bold)
            ]
            let attributedText = NSAttributedString(string: procesion.nombre, attributes: attributes)
            cell?.textLabel?.attributedText = attributedText
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.textLabel?.textAlignment = .center
            break
        case 1:
            cell?.textLabel?.text = "Detalles\n\n\(procesion.horario!)"
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.textLabel?.textAlignment = .justified
            break
        case 2:
            cell?.textLabel?.text = "Recorrido\n\n\(procesion.recorrido!)"
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.textLabel?.textAlignment = .justified
            break
        default:
            break
        }
        return cell
    }

}
