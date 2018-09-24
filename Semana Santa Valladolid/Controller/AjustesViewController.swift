//
//  AjustesViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import IntentsUI

class AjustesViewController: UITableViewController {

    @IBOutlet weak var ajustesSiriShortcutOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @available (iOS 12.0, *)
    var intent: ProcesionesHoyIntent {
        let intencion = ProcesionesHoyIntent()
        intencion.suggestedInvocationPhrase = "¿Qué procesiones hay hoy?"
        return intencion
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 12.0, *) {
            INVoiceShortcutCenter.shared.getAllVoiceShortcuts { shortcuts, error in
                if let error = error {
                    print("Error... " + error.localizedDescription)
                    return
                }
                if let _ = shortcuts, let _ = shortcuts!.first(where: { $0.shortcut.intent == self.intent }) {
                    DispatchQueue.main.async {
                        self.ajustesSiriShortcutOutlet.setTitle("Editar atajo de Siri", for: .normal)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.ajustesSiriShortcutOutlet.setTitle("Preguntar a Siri por las procesiones del día", for: .normal)
                    }
                }
            }
        }
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
    
    @IBAction func ajustesSiriShortcut(_ sender: Any) {
        if #available(iOS 12.0, *) {
            INVoiceShortcutCenter.shared.getAllVoiceShortcuts { shortcuts, error in
                if let error = error {
                    print("Error... " + error.localizedDescription)
                    return
                }
                if let _ = shortcuts, let shortcut = shortcuts!.first(where: { $0.shortcut.intent == self.intent }) {
                    let viewController = INUIEditVoiceShortcutViewController(voiceShortcut: shortcut)
                    viewController.modalPresentationStyle = .formSheet
                    viewController.delegate = self
                    self.present(viewController, animated: true)
                } else {
                    if let shortcut = INShortcut(intent: self.intent) {
                        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                        viewController.modalPresentationStyle = .formSheet
                        viewController.delegate = self
                        self.present(viewController, animated: true)
                    }
                }
            }
        }
    }
    
}

@available(iOS 12.0, *)
extension AjustesViewController: INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    
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
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}
