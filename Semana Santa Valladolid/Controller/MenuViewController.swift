//
//  MenuViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.loadDias()
        DataManager.loadCofradias()
        DataManager.loadIglesias()
    }

}
