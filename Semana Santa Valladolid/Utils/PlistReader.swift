//
//  PlistReader.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 20/10/2019.
//  Copyright © 2019 Ruben Fernandez. All rights reserved.
//

import Foundation

class PlistReader {
    
    class func parse<T: Codable>(name: String) -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: "plist"), let dic = NSArray(contentsOfFile: path) {
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
