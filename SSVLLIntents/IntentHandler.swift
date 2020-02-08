//
//  IntentHandler.swift
//  SSVLLIntents
//
//  Created by Ruben Fernandez on 24/9/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Intents

class IntentHandler: INExtension, ProcesionesHoyIntentHandling {
    
    let dias = ["03/04/20":0,"04/04/20":1,"05/04/20":2,"06/04/20":3,"07/04/20":4,"08/04/20":5,"09/04/20":6,"10/04/20":7,"11/04/20":8,"12/04/20":9]
    
    func handle(intent: ProcesionesHoyIntent, completion: @escaping (ProcesionesHoyIntentResponse) -> Void) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        if let indexHoy = dias[dateFormatter.string(from: date)] {
            if Dia.dias[indexHoy].procesiones.count > 0 {
                let numeroProcesiones = NSNumber(value: Dia.dias[indexHoy].procesiones.count)
                completion(ProcesionesHoyIntentResponse.success(numeroProcesiones: numeroProcesiones))
            } else {
                completion(ProcesionesHoyIntentResponse(code: .noProcesiones, userActivity: nil))
            }
        } else {
            completion(ProcesionesHoyIntentResponse(code: .noProcesiones, userActivity: nil))
        }
        
    }
    
    func confirm(intent: ProcesionesHoyIntent, completion: @escaping (ProcesionesHoyIntentResponse) -> Void) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        if let indexHoy = dias[dateFormatter.string(from: date)] {
            if Dia.dias[indexHoy].procesiones.count > 0 {
                let numeroProcesiones = NSNumber(value: Dia.dias[indexHoy].procesiones.count)
                completion(ProcesionesHoyIntentResponse.success(numeroProcesiones: numeroProcesiones))
            } else {
                completion(ProcesionesHoyIntentResponse(code: .noProcesiones, userActivity: nil))
            }
        } else {
            completion(ProcesionesHoyIntentResponse(code: .noProcesiones, userActivity: nil))
        }
        
    }
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is ProcesionesHoyIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        
        return self
    }
    
}
