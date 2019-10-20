//
//  IntentHandler.swift
//  SSVLLIntents
//
//  Created by Ruben Fernandez on 24/9/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Intents

class IntentHandler: INExtension, ProcesionesHoyIntentHandling {
    
    let dias = ["12/04/19":0,"13/04/19":1,"14/04/19":2,"15/04/19":3,"16/04/19":4,"17/04/19":5,"18/04/19":6,"19/04/19":7,"20/04/19":8,"21/04/19":9]
    
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
