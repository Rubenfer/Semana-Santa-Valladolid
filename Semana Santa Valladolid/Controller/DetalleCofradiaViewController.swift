//
//  DetalleCofradiaViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class DetalleCofradiaViewController: UIViewController {
    
    var cofradia: Cofradia!
    
    @IBOutlet var texto: UITextView!
    @IBOutlet var habitoImg: UIImageView!
    
    @IBAction func verWeb(_ sender: Any) {
        UIApplication.shared.open(URL(string: cofradia.web)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitoImg.image = UIImage(named: "h\(cofradia.id!)")
        texto.text = cofradia.descripcion
    }
    
    @IBAction func procesionesBtn(_ sender: Any) {
        let vc = ProcesionesCofradiaViewController()
        vc.cofradia = cofradia
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
