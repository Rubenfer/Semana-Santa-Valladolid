//
//  Iglesia.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 17/07/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

class Iglesia: Codable {
    
    var nombre: String!
    var latitud: String!
    var longitud: String!
    
    static var iglesias = [Iglesia]()
    
    static func loadIglesias() {
        if let path = Bundle.main.path(forResource: "Iglesias", ofType: "plist"), let dic = NSArray(contentsOfFile: path) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                Iglesia.iglesias = try JSONDecoder().decode([Iglesia].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
