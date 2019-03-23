//
//  AppDelegate.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import UIKit
import Intents
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivity.verCofradias.activityType {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: CofradiasViewController = storyboard.instantiateViewController(withIdentifier: "cofradiasVC") as! CofradiasViewController
            let navigationController: UINavigationController = storyboard.instantiateViewController(withIdentifier: "nc") as! UINavigationController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            navigationController.pushViewController(viewController, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            return true
        }
        if userActivity.activityType == "ProcesionesHoyIntent" {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: ProcesionesViewController = storyboard.instantiateViewController(withIdentifier: "procesionesVC") as! ProcesionesViewController
            let navigationController: UINavigationController = storyboard.instantiateViewController(withIdentifier: "nc") as! UINavigationController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            navigationController.pushViewController(viewController, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            return true
        }
        return false
    }

}

