//
//  NSUserActivity+SSVLL.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 08/09/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation
import IntentsUI

extension UISearchController {
    func isSearching() -> Bool {
        if self.isActive && self.searchBar.text != "" {
            return true
        }
        return false
    }
}

// MARK: - NSUserActivity

extension NSUserActivity {
    
    public static var verCofradias: NSUserActivity {
        let activity = NSUserActivity(activityType: "com.rubenfernandez.Semana-Santa-Valladolid.verCofradias")
        activity.title = "Ver cofradías"
        activity.isEligibleForSearch = true
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.suggestedInvocationPhrase = "Ver cofradías de Valladolid"
        }
        return activity
    }
    
    public static var verIncidencias: NSUserActivity {
        let activity = NSUserActivity(activityType: "com.rubenfernandez.Semana-Santa-Valladolid.verIncidencias")
        activity.title = "Ver incidencias"
        activity.isEligibleForSearch = true
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.suggestedInvocationPhrase = "Ver incidencias en Valladolid"
        }
        return activity
    }
    
}

// MARK: - Intents

@available(iOS 12.0, *)
extension UIViewController: INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    
    var procesionesHoyIntent: ProcesionesHoyIntent {
        let intencion = ProcesionesHoyIntent()
        intencion.suggestedInvocationPhrase = "¿Qué procesiones hay hoy?"
        return intencion
    }
    
    public func donateProcesionesHoyInteraction() {
        let interaction = INInteraction(intent: procesionesHoyIntent, response: nil)
        interaction.donate { (error) in
            if error != nil {
                print("Error donating intent..." + error!.localizedDescription)
            }
        }
    }
    
    public func showAddVoiceUI(for intent: INIntent) {
        if let shortcut = INShortcut(intent: intent) {
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self
            self.present(viewController, animated: true)
        }
    }
    
    public func showEditVoiceUI(for shortcut: INVoiceShortcut) {
        let viewController = INUIEditVoiceShortcutViewController(voiceShortcut: shortcut)
        viewController.modalPresentationStyle = .formSheet
        viewController.delegate = self
        self.present(viewController, animated: true)
    }
    
    public func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            print("Error editing voice shortcut: %@" + error.localizedDescription)
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    public func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        UserDefaults.standard.removeObject(forKey: "procesionesDiaUUID")
        controller.dismiss(animated: true, completion: nil)
    }
    
    public func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    public func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let voiceShortcut = voiceShortcut {
            UserDefaults.standard.set(voiceShortcut.identifier.uuidString, forKey: "procesionesDiaUUID")
        }
        dismiss(animated: true, completion: nil)
    }
    
    public func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
