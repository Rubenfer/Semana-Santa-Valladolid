//
//  DetalleProcesionViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit

class DetalleProcesionViewController: UIViewController {
    
    var procesion: Procesion!
    
    @IBOutlet var nombreProcesion: UILabel!
    @IBOutlet var descripcionProcesion: UITextView!
    @IBOutlet var recorridoProcesion: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        nombreProcesion.numberOfLines = 0
        nombreProcesion.text = procesion.nombre
        descripcionProcesion.text = procesion.horario
        recorridoProcesion.text = procesion.recorrido
    }

}
