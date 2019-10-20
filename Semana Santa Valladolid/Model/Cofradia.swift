//
//  Cofradia.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

struct Cofradia: Codable {
    
    static let cofradias: [Cofradia] = PlistReader.parse(name: "Cofradias") ?? []
    
    let id: String
    let nombre: String
    let web: String
    let descripcion: String
    let procesiones: [Int]
    let pasos: [String]
    
    func buscarProcesiones() -> [(Procesion, String)] {
        var procesionesCofradia: [(Procesion, String)] = []
        Dia.dias.forEach { dia in
            procesiones.forEach { procesion in
                let procesionesDia = dia.procesiones.filter { $0.id == procesion }
                procesionesDia.forEach { procesionDia in
                    procesionesCofradia.append((procesionDia, dia.dia))
                }
            }
        }
        return procesionesCofradia
    }
    
}
