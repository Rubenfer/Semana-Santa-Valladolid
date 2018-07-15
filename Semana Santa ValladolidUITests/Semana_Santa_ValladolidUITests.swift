//
//  Semana_Santa_ValladolidUITests.swift
//  Semana Santa ValladolidUITests
//
//  Created by Ruben Fernandez
//  Copyright © 2018 Ruben Fernandez. All rights reserved.
//

import XCTest

class Semana_Santa_ValladolidUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        snapshot("0Menu")
        app.otherElements.containing(.navigationBar, identifier:"Semana Santa de Valladolid").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Button").element(boundBy: 0).tap()
        snapshot("1Cofradias")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Cofradía Penitencial y Sacramental de la Sagrada Cena"]/*[[".cells.staticTexts[\"Cofradía Penitencial y Sacramental de la Sagrada Cena\"]",".staticTexts[\"Cofradía Penitencial y Sacramental de la Sagrada Cena\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("2DetalleCofradias")
        app.navigationBars["Semana_Santa_Valladolid.DetalleCofradiaView"].buttons["Cofradias"].tap()
        app.navigationBars["Cofradias"].buttons["Semana Santa de Valladolid"].tap()
        app.otherElements.containing(.navigationBar, identifier:"Semana Santa de Valladolid").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Button").element(boundBy: 1).tap()
        snapshot("3Procesiones")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Ejercicio del Via Crucis de la Cofradía del Santo Entierro"]/*[[".cells.staticTexts[\"Ejercicio del Via Crucis de la Cofradía del Santo Entierro\"]",".staticTexts[\"Ejercicio del Via Crucis de la Cofradía del Santo Entierro\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("4DetalleProcesion")
        app.navigationBars["Semana_Santa_Valladolid.DetalleProcesionView"].buttons["Procesiones por días"].tap()
        app.navigationBars["Procesiones por días"].buttons["Semana Santa de Valladolid"].tap()
        app.otherElements.containing(.navigationBar, identifier:"Semana Santa de Valladolid").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Button").element(boundBy: 2).tap()
        snapshot("5Pasos")
        app.navigationBars["Pasos"].buttons["Semana Santa de Valladolid"].tap()
        app.buttons["ajustes"].tap()
        snapshot("6Ajustes")
        
    }
    
}
