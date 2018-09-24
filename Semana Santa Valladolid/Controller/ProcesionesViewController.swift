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
    var diaSeleccionado = DataManager.dias[0]

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
            diaSeleccionado = DataManager.dias[hoyIndex]
            pickerDia.selectRow(hoyIndex, inComponent: 0, animated: true)
            tableView.reloadSections([0], with: .fade)
        }
        
        if #available(iOS 12.0, *) {
            donateInteraction()
            if let id = UserDefaults.standard.value(forKey: "procesionesDiaUUID") as? String, let UUID = UUID(uuidString: id) {
                INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID) { shortcut, error in
                    if let error = error {
                        print("Error... " + error.localizedDescription)
                        return
                    }
                    if let _ = shortcut { } else {
                        if let shortcut = INShortcut(intent: self.intent) {
                            if let vecesVisto = UserDefaults.standard.value(forKey: "vecesVisto") as? Int, vecesVisto != 2 && vecesVisto != 10 { } else {
                                let aviso = UIAlertController(title: "Configurar atajos", message: "¿Quieres que Siri te diga las procesiones del día?", preferredStyle: .alert)
                                let siBtn = UIAlertAction(title: "¡Sí!", style: .default) { Void in
                                    let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                                    viewController.modalPresentationStyle = .formSheet
                                    viewController.delegate = self
                                    self.present(viewController, animated: true)
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
        
    }
    

    // MARK: - TableView & PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataManager.dias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataManager.dias[row].dia
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        diaSeleccionado = DataManager.dias[row]
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
    
    // MARK: - Intent managment
    
    @available(iOS 12.0, *)
    var intent: ProcesionesHoyIntent {
        let intencion = ProcesionesHoyIntent()
        intencion.suggestedInvocationPhrase = "¿Qué procesiones hay hoy?"
        return intencion
    }
    
    func donateInteraction() {
        if #available(iOS 12.0, *) {
            let interaction = INInteraction(intent: intent, response: nil)
            interaction.donate { (error) in
                if error != nil {
                    print("Error donating intent..." + error!.localizedDescription)
                }
            }
        }
    }

}

@available(iOS 12.0, *)
extension ProcesionesViewController: INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            print("Error adding voice shortcut: %@" + error.localizedDescription)
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let voiceShortcut = voiceShortcut {
            UserDefaults.standard.set(voiceShortcut.identifier.uuidString, forKey: "procesionesDiaUUID")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}
