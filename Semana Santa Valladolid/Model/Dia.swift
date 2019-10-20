//
//  Dia.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

class Dia: Codable {
    
    let dia: String
    let procesiones: [Procesion]
    
    static let dias: [Dia] = PlistReader.parse(name: "Dias") ?? []
    
}
