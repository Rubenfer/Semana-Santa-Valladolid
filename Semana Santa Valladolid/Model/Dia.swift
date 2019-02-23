//
//  Dia.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

class Dia: Codable {
    
    var dia: String!
    var procesiones = [Procesion]()
    
    static var dias = [Dia]()
    
    static func loadDias() {
        if let path = Bundle.main.path(forResource: "Dias", ofType: "plist"), let dic = NSArray(contentsOfFile: path) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                Dia.dias = try JSONDecoder().decode([Dia].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
