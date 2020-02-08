//
//  IntentViewController.swift
//  SSVLLIntentsUI
//
//  Created by Ruben Fernandez on 24/9/18.
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import IntentsUI

class IntentViewController: UIViewController, INUIHostedViewControlling, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dias = ["03/04/20":0,"04/04/20":1,"05/04/20":2,"06/04/20":3,"07/04/20":4,"08/04/20":5,"09/04/20":6,"10/04/20":7,"11/04/20":8,"12/04/20":9]
    
    var procesiones = [Procesion]()
    
    var desiredSize: CGSize {
        get {
            let width = self.extensionContext!.hostedViewMaximumAllowedSize.width
            let height = CGFloat(80 * procesiones.count)
            return CGSize(width: width, height: height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        if let indexHoy = dias[dateFormatter.string(from: date)] {
            procesiones = Dia.dias[indexHoy].procesiones
        }
        
        tableView.reloadData()
        
    }
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        tableView.rowHeight = 30
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        if let indexHoy = dias[dateFormatter.string(from: date)] {
            procesiones = Dia.dias[indexHoy].procesiones
        }
        
        tableView.reloadData()
        
        completion(true, parameters, self.desiredSize)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { procesiones.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "procesionCell")
        cell!.textLabel?.text = procesiones[indexPath.row].nombre + " (" + procesiones[indexPath.row].hora + ")"
        cell!.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }
    
}
