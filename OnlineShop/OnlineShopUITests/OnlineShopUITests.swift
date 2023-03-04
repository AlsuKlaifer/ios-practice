//
//  OnlineShopUITests.swift
//  OnlineShopUITests
//
//  Created by Alsu Faizova on 03.03.2023.
//

import XCTest

final class OnlineShopUITests: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()
        app.launch()
        self.app = app
    }
    
    var app: XCUIApplication!

    func testShowAlert() throws {
        let loginField = app.textFields["Login"]
        loginField.tap()
        loginField.typeText("123")

        let passwordField = app.textFields["Password"]
        passwordField.tap()
        passwordField.typeText("ustal(")
        
        app.buttons["Log in"].tap()
        let alert = app.alerts["OOOPS"]
        XCTAssertTrue(alert.exists)
    }
    
    func testShowConfirmCode() throws {
        let loginField = app.textFields["Login"]
        loginField.tap()
        loginField.typeText("123")

        let passwordField = app.textFields["Password"]
        passwordField.tap()
        passwordField.typeText("123")
        
        app.buttons["Log in"].tap()
        
        let confirmStaticText = app.staticTexts["Confirm"]
        XCTAssertTrue(confirmStaticText.exists)
    }
    
    func testSelectFirstRow() throws {
        let loginField = app.textFields["Login"]
        loginField.tap()
        loginField.typeText("admin")

        let passwordField = app.textFields["Password"]
        passwordField.tap()
        passwordField.typeText("123")
        
        app.buttons["Log in"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Apple juice"]/*[[".cells.staticTexts[\"Apple juice\"]",".staticTexts[\"Apple juice\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let name = app.staticTexts["Apple juice"]
        let calories = app.staticTexts["Calories: 20"]
        let price = app.staticTexts["Price: 80$"]
        XCTAssertTrue(name.exists)
        XCTAssertTrue(calories.exists)
        XCTAssertTrue(price.exists)
    }
    
    func testSignOut() throws {
        let loginField = app.textFields["Login"]
        loginField.tap()
        loginField.typeText("admin")

        let passwordField = app.textFields["Password"]
        passwordField.tap()
        passwordField.typeText("123")
        
        app.buttons["Log in"].tap()
        
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        app.buttons["Sign out"].tap()
        let button = app.buttons["Log in"]
        
        XCTAssertTrue(button.exists)
    }
}
