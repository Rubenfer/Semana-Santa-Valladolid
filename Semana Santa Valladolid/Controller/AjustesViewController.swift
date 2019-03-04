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
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 12.0, *) {
            
            if let id = UserDefaults.standard.value(forKey: "procesionesDiaUUID") as? String, let UUID = UUID(uuidString: id) {
                INVoiceShortcutCenter.shared.getVoiceShortcut(with: UUID) { shortcut, error in
                    if let error = error {
                        print("Error... " + error.localizedDescription)
                        return
                    }
                    if let _ = shortcut {
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
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id1303047750?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func ajustesSiriShortcut(_ sender: Any) {
        if #available(iOS 12.0, *) {
            if let id = UserDefaults.standard.value(forKey: "procesionesDiaUUID") as? String, let UUID = UUID(uuidString: id) {
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
    
}
