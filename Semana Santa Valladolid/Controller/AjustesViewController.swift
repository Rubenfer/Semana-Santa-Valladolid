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
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let id = UserDefaults.standard.string(forKey: "procesionesDiaUUID"), let UUID = UUID(uuidString: id) {
            INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID) { shortcut, error in
                guard error == nil else { return }
                DispatchQueue.main.async {
                    if shortcut != nil {
                        self.ajustesSiriShortcutOutlet.setTitle("Editar atajo de Siri", for: .normal)
                    } else {
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
    
    @IBAction func valorar(_ sender: Any) {
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id1303047750?action=write-review") else { return }
        UIApplication.shared.open(writeReviewURL)
    }
    
    @IBAction func ajustesSiriShortcut(_ sender: Any) {
        if let id = UserDefaults.standard.string(forKey: "procesionesDiaUUID"), let UUID = UUID(uuidString: id) {
            INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID) { shortcut, error in
                if let error = error {
                    print("Error... " + error.localizedDescription)
                    UserDefaults.standard.removeObject(forKey: "procesionesDiaUUID")
                    return
                }
                if let shortcut = shortcut {
                    self.showEditVoiceUI(for: shortcut)
                } else {
                    self.showAddVoiceUI(for: self.procesionesHoyIntent)
                }
            }
        } else {
            showAddVoiceUI(for: procesionesHoyIntent)
        }
    }
    
}
