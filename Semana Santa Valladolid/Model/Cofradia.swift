//
//  Cofradia.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation

class Cofradia: Codable {
    
    var id: String!
    var nombre: String!
    var web: String!
    var descripcion: String!
    var procesiones = [Int]()
    var pasos = [String]()
    
    func buscarProcesiones() -> [Procesion] {
        var procesionesCofradia = [Procesion]()
        for dia in Dia.dias {
            for procesionCofradia in procesiones {
                procesionesCofradia += dia.procesiones.filter { (procesion) -> Bool in
                    return procesionCofradia == procesion.id
                }
            }
        }
        return procesionesCofradia
    }
    
    static var cofradias = [Cofradia]()
    
    static func loadCofradias() {
        if let path = Bundle.main.path(forResource: "Cofradias", ofType: "plist"), let dic = NSArray(contentsOfFile: path) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                Cofradia.cofradias = try JSONDecoder().decode([Cofradia].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
