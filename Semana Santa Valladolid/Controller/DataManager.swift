//
//  DataManager.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    static var dias = [Dia]()
    static var cofradias = [Cofradia]()
    
    static func loadDias() {
        if let path = Bundle.main.path(forResource: "Dias", ofType: "plist"), let dic = NSArray(contentsOfFile: path) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                DataManager.dias = try JSONDecoder().decode([Dia].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static func loadCofradias() {
        if let path = Bundle.main.path(forResource: "Cofradias", ofType: "plist"), let dic = NSArray(contentsOfFile: path) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                DataManager.cofradias = try JSONDecoder().decode([Cofradia].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}


extension UISearchController {
    func isSearching() -> Bool {
        if self.isActive && self.searchBar.text != "" {
            return true
        }
        return false
    }
}
