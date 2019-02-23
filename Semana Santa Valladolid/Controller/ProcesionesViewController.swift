//
//  ProcesionesViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import IntentsUI

class ProcesionesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pickerDia: UIPickerView!
    
    let dias = ["12/04/19":0,"13/04/19":1,"14/04/19":2,"15/04/19":3,"16/04/19":4,"17/04/19":5,"18/04/19":6,"19/04/19":7,"20/04/19":8,"21/04/19":9]
    var diaSeleccionado = Dia.dias[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDia.delegate = self
        pickerDia.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let hoy = dateFormatter.string(from: date)
        
        if let hoyIndex = dias[hoy] {
            diaSeleccionado = Dia.dias[hoyIndex]
            pickerDia.selectRow(hoyIndex, inComponent: 0, animated: true)
            tableView.reloadSections([0], with: .fade)
        }
        
        if #available(iOS 12.0, *) {
            donateProcesionesHoyInteraction()
            if let id = UserDefaults.standard.value(forKey: "procesionesDiaUUID") as? String, let UUID = UUID(uuidString: id) {
                INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID) { shortcut, error in
                    if let error = error {
                        print("Error... " + error.localizedDescription)
                        return
                    }
                    if let _ = shortcut { } else {
                        if let vecesVisto = UserDefaults.standard.value(forKey: "vecesVisto") as? Int, vecesVisto != 2 && vecesVisto != 10 { } else {
                            let aviso = UIAlertController(title: "Configurar atajos", message: "¿Quieres que Siri te diga las procesiones del día?", preferredStyle: .alert)
                            let siBtn = UIAlertAction(title: "¡Sí!", style: .default) { Void in
                                self.showAddVoiceUI(for: self.procesionesHoyIntent)
                            }
                            let noBtn = UIAlertAction(title: "No", style: .cancel, handler: nil)
                            aviso.addAction(siBtn)
                            aviso.addAction(noBtn)
                            DispatchQueue.main.async {
                                self.present(aviso, animated: true)
                            }
                        }
                    }
                }
            }
        }
        
    }
    

    // MARK: - TableView & PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Dia.dias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Dia.dias[row].dia
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        diaSeleccionado = Dia.dias[row]
        tableView.reloadSections([0], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaSeleccionado.procesiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: "cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = diaSeleccionado.procesiones[indexPath.row].nombre
        cell.detailTextLabel?.text = diaSeleccionado.procesiones[indexPath.row].hora
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetalleProcesionViewController()
        vc.procesion = self.diaSeleccionado.procesiones[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
