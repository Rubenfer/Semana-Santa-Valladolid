//
//  Iglesia.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 17/07/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

class Iglesia: Codable {
    
    static let iglesias: [Iglesia] = PlistReader.parse(name: "Iglesias") ?? []
    
    let nombre: String
    let latitud: String
    let longitud: String
    
}
