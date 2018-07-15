//
//  AjustesViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class AjustesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func masApps(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/es/developer/ruben-fernandez/id1013021034?mt=8")!)
    }
    
    @IBAction func donacion(_ sender: Any) {
         UIApplication.shared.open(URL(string: "https://www.paypal.me/RubenFernandez/2")!)
    }
    
    @IBAction func openSource(_ sender: Any) {
         UIApplication.shared.open(URL(string: "https://github.com/Rubenfer/Semana-Santa-Valladolid")!)
    }
    
}
