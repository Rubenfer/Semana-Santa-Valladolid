//
//  NSUserActivity+SSVLL.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 08/09/2018.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import Foundation
import Intents

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
