//
//  Semana_Santa_ValladolidTests.swift
//  Semana Santa ValladolidTests
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import XCTest
@testable import Semana_Santa_Valladolid

class Semana_Santa_ValladolidTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadProcesiones() {
        Dia.loadDias()
        XCTAssertEqual(Dia.dias.count, 10)
        for dia in Dia.dias {
            XCTAssertGreaterThan(dia.procesiones.count, 0)
        }
    }
    
    func testLoadCofradias() {
        Cofradia.loadCofradias()
        XCTAssertEqual(Cofradia.cofradias.count, 20)
    }
    
    func testLoadIglesias() {
        Iglesia.loadIglesias()
        XCTAssertGreaterThan(Iglesia.iglesias.count, 0)
    }
    
}
