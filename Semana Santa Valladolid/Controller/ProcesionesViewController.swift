//
//  ProcesionesViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import IntentsUI

class ProcesionesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, INUIAddVoiceShortcutViewControllerDelegate, INUIAddVoiceShortcutButtonDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pickerDia: UIPickerView!
    
    var diaSeleccionado = DataManager.dias[0]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDia.delegate = self
        pickerDia.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
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
    
    @available(iOS 12.0, *)
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            print("Error adding voice shortcut: %@" + error.localizedDescription)
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }

}
