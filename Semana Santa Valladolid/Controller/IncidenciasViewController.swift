//
//  IncidenciasViewController.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 09/04/2019.
//  Copyright © 2019 Ruben Fernandez. All rights reserved.
//

import UIKit
import WebKit

class IncidenciasViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Incidencias"
        
        guard let pdf = Bundle.main.url(forResource: "IncidenciasTrafico", withExtension: "pdf") else { return }
        webView.load(URLRequest(url: pdf))
        
    }
    
}
