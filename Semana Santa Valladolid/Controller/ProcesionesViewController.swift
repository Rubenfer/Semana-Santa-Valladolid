//
//  ProcesionesViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import IntentsUI
import StoreKit

class ProcesionesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pickerDia: UIPickerView!
    
    let dias = ["03/04/20":0,"04/04/20":1,"05/04/20":2,"06/04/20":3,"07/04/20":4,"08/04/20":5,"09/04/20":6,"10/04/20":7,"11/04/20":8,"12/04/20":9]
    var diaSeleccionado = Dia.dias[0]
    
    override func viewDidAppear(_ animated: Bool) {
        selectToday()
        donateProcesionesHoyInteraction()
        showMessageConfigureSiriShortcut()
        requestReview()
    }
    
    func selectToday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let hoy = dateFormatter.string(from: Date())
        
        if let hoyIndex = dias[hoy] {
            diaSeleccionado = Dia.dias[hoyIndex]
            pickerDia.selectRow(hoyIndex, inComponent: 0, animated: true)
            tableView.reloadSections([0], with: .fade)
        }
    }
    
    func showMessageConfigureSiriShortcut() {
        if let id = UserDefaults.standard.string(forKey: "procesionesDiaUUID"), let UUID = UUID(uuidString: id) {
            INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID) { shortcut, error in
                guard error == nil, shortcut == nil else { return }
                let vecesVisto = UserDefaults.standard.integer(forKey: "vecesVisto")
                if vecesVisto == 2 || vecesVisto == 10 || vecesVisto % 20 == 0 {
                    let aviso = UIAlertController(title: "Configurar atajos", message: "¿Quieres que Siri te diga las procesiones del día?", preferredStyle: .alert)
                    let siBtn = UIAlertAction(title: "¡Sí!", style: .default) { _ in
                        self.showAddVoiceUI(for: self.procesionesHoyIntent)
                    }
                    let noBtn = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    aviso.addAction(siBtn)
                    aviso.addAction(noBtn)
                    DispatchQueue.main.async {
                        self.present(aviso, animated: true)
                    }
                }
                UserDefaults.standard.set(vecesVisto+1, forKey: "vecesVisto")
            }
        }
    }
    
    func requestReview() {
        if UserDefaults.standard.integer(forKey: "contadorReview") == 5 || UserDefaults.standard.integer(forKey: "contadorReview") % 20 == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
}

    // MARK: - PickerView

extension ProcesionesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { Dia.dias.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { Dia.dias[row].dia }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        diaSeleccionado = Dia.dias[row]
        tableView.reloadSections([0], with: .automatic)
    }
    
}

    // MARK: - TableView

extension ProcesionesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { diaSeleccionado.procesiones.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
